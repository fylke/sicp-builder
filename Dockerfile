FROM docker.io/library/ruby:3.4-alpine3.24 AS build

ARG SICP_REF=bda03f79d6e2e8899ac2b5ca6a3732210e290a79

RUN apk add --no-cache \
    bash \
    font-linux-libertine \
    fontconfig \
    gcc \
    gcompat \
    git \
    grep \
    inkscape \
    libc-dev \
    make \
    nodejs \
    npm \
    patch \
    perl \
    tar \
    wget \
    zip

RUN gem install --no-document nokogiri

RUN git init /sicp \
    && git -C /sicp fetch --depth 1 https://github.com/sarabander/sicp.git "$SICP_REF" \
    && git -C /sicp checkout --detach FETCH_HEAD
WORKDIR /sicp
# Inkscape 1.x dropped the -e/-f flags the upstream Makefile uses.
RUN sed -i "s/-e \$(THUMB) -f \$(DIR)fig/-o \$(THUMB) \$(DIR)fig/" Makefile \
    && grep -q -- "-o \$(THUMB)" Makefile

RUN ["ln", "-s", "/usr/local/bin/ruby", "/usr/bin/ruby"]

# Upstream targets Texinfo 5.1 and ships a modified HTML.pm. texinfo-sicp.patch
# carries those modifications over to 6.0, and texi2any is built from the
# tarball in place of the copy in the upstream repo.
COPY texinfo-sicp.patch /
RUN wget -q https://ftp.gnu.org/gnu/texinfo/texinfo-6.0.tar.gz \
    && echo "83d3183290f34e7f958d209d0b20022c6fe9e921eb6fe94c27d988827d4878d2  texinfo-6.0.tar.gz" | sha256sum -c - \
    && tar -xf texinfo-6.0.tar.gz \
    && patch -p1 -d texinfo-6.0 < /texinfo-sicp.patch \
    && (cd texinfo-6.0 && ./configure -q && make -C tp texi2any) \
    && cp texinfo-6.0/tp/texi2any texi2any
# The cover SVG needs Alegreya (variable TTF, OFL), pinned by google/fonts commit.
ARG ALEGREYA_URL=https://raw.githubusercontent.com/google/fonts/199711f8c8d2cafc88f26c174152abfa18eb62c3/ofl/alegreya/Alegreya%5Bwght%5D.ttf
RUN mkdir -p /usr/share/fonts/alegreya \
    && wget -O /usr/share/fonts/alegreya/Alegreya.ttf "$ALEGREYA_URL" \
    && echo "ba5564634b93a8f8ba57b48cd4f1ae7417d2b4656fbac779028679b00de3cf12  /usr/share/fonts/alegreya/Alegreya.ttf" | sha256sum -c - \
    && fc-cache -f

# Node replacements for the upstream PhantomJS scripts (same file names, so the
# upstream Makefile is used unchanged).
COPY scripts/package.json scripts/package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund
COPY --chmod=755 scripts/get-math.js scripts/put-math.js scripts/batch-prettify.js ./

ENV PERL5LIB \
"/sicp/texinfo-6.0/tp:\
/sicp/texinfo-6.0/tp/maintain/lib/libintl-perl/lib:\
/sicp/texinfo-6.0/tp/maintain/lib/Unicode-EastAsianWidth/lib:\
/sicp/texinfo-6.0/tp/maintain/lib/Text-Unidecode/lib:\
/sicp/texinfo-6.0/Pod-Simple-Texinfo/lib"

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
