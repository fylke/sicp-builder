FROM docker.io/library/ruby:3.4-alpine AS build

ARG SICP_REF=bda03f79d6e2e8899ac2b5ca6a3732210e290a79

RUN apk add --no-cache \
    bash \
    fontconfig \
    gcc \
    gcompat \
    git \
    grep \
    inkscape \
    libc-dev \
    make \
    msttcorefonts-installer \
    nodejs \
    npm \
    perl \
    tar \
    wget \
    zip

RUN gem install --no-document nokogiri

RUN git init /sicp \
    && git -C /sicp fetch --depth 1 https://github.com/sarabander/sicp.git "$SICP_REF" \
    && git -C /sicp checkout --detach FETCH_HEAD
COPY inkscape.patch /sicp/inkscape.patch
WORKDIR /sicp
RUN git apply inkscape.patch

RUN ["ln", "-s", "/usr/local/bin/ruby", "/usr/bin/ruby"]

RUN wget https://ftp.gnu.org/gnu/texinfo/texinfo-5.1.tar.gz
RUN tar -xvf texinfo-5.1.tar.gz
RUN update-ms-fonts

# Node replacements for the upstream PhantomJS scripts (same file names, so the
# upstream Makefile is used unchanged).
COPY scripts/package.json scripts/package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund
COPY --chmod=755 scripts/get-math.js scripts/put-math.js scripts/batch-prettify.js ./

ENV PERL5LIB \
"/sicp/texinfo-5.1/tp:\
/sicp/texinfo-5.1/tp/maintain/lib/libintl-perl/lib:\
/sicp/texinfo-5.1/tp/maintain/lib/Unicode-EastAsianWidth/lib:\
/sicp/texinfo-5.1/tp/maintain/lib/Text-Unidecode/lib:\
/sicp/texinfo-5.1/Pod-Simple-Texinfo/lib"

# -B regenerates the HTML instead of reusing the files committed upstream.
# The Makefile does not fail when math conversion goes wrong, so check it here.
RUN make -B all \
    && grep -q '<math ' html/*.xhtml \
    && ! grep -lE "color:blue|class='faulty'" html/*.xhtml \
    && test -s /sicp.epub

FROM docker.io/library/eclipse-temurin:21-jre-alpine AS validate

ARG EPUBCHECK_VERSION=5.4.0
ARG EPUBCHECK_SHA256=33350c61038e71dfb3d45a76aed04bf5481e6d5500cb780f6e98db8bbd15a28c

RUN apk add --no-cache unzip wget \
    && wget -q -O /tmp/epubcheck.zip \
       "https://github.com/w3c/epubcheck/releases/download/v${EPUBCHECK_VERSION}/epubcheck-${EPUBCHECK_VERSION}.zip" \
    && echo "${EPUBCHECK_SHA256}  /tmp/epubcheck.zip" | sha256sum -c - \
    && unzip -q /tmp/epubcheck.zip -d /opt \
    && rm /tmp/epubcheck.zip

COPY --from=build /sicp.epub /sicp.epub
# Exits non-zero on any error or warning, which fails the build.
RUN java -jar /opt/epubcheck-${EPUBCHECK_VERSION}/epubcheck.jar --failonwarnings /sicp.epub

FROM scratch AS epub
# Copying from the validate stage makes validation a prerequisite of the output.
COPY --from=validate /sicp.epub /sicp.epub
