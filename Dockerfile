FROM docker.io/library/ruby:3.4-alpine

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

WORKDIR /sicp
RUN wget https://ftp.gnu.org/gnu/texinfo/texinfo-5.1.tar.gz
RUN tar -xvf texinfo-5.1.tar.gz
WORKDIR /sicp/texinfo-5.1

WORKDIR /sicp
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN update-ms-fonts

WORKDIR /sicp
ENV PERL5LIB \
"/sicp/texinfo-5.1/tp:\
/sicp/texinfo-5.1/tp/maintain/lib/libintl-perl/lib:\
/sicp/texinfo-5.1/tp/maintain/lib/Unicode-EastAsianWidth/lib:\
/sicp/texinfo-5.1/tp/maintain/lib/Text-Unidecode/lib:\
/sicp/texinfo-5.1/Pod-Simple-Texinfo/lib"
ENV PATH \
"/sicp/phantomjs-2.1.1-linux-x86_64/bin:\
${PATH}"

RUN make all

CMD ["sleep", "infinity"]
