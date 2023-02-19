FROM ruby:3.0-alpine

RUN apk update
RUN apk add --no-cache gcc
RUN apk add --no-cache libc-dev
RUN apk add --no-cache gcompat
RUN apk add --no-cache make
RUN apk add --no-cache bash
RUN apk add --no-cache wget
RUN apk add --no-cache tar
RUN apk add --no-cache git
RUN apk add --no-cache fontconfig
RUN apk add --no-cache msttcorefonts-installer
RUN apk add --no-cache inkscape
RUN apk add --no-cache zip
RUN apk add --no-cache grep


RUN gem install nokogiri

RUN git clone https://github.com/sarabander/sicp.git
COPY inkscape.patch /sicp/inkscape.patch
WORKDIR /sicp
RUN git apply inkscape.patch

RUN wget http://www.cpan.org/src/5.0/perl-5.12.2.tar.gz
RUN tar -xvf perl-5.12.2.tar.gz
WORKDIR /sicp/perl-5.12.2
RUN ["./Configure", "-Dcc=gcc", "-e", "-d",\
     "-Dprefix=/opt/perl-5.12.2-emg",\
     "-Duseithreads",\
     "-Dusethreads",\
     "-Duselargefiles"]
RUN ["make"]
RUN ["make", "install"]
RUN ["ln", "-s", "/opt/perl-5.12.2-emg/bin/perl", "/usr/bin/perl"]
RUN ["ln", "-s", "/usr/local/bin/ruby", "/usr/bin/ruby"]

WORKDIR /sicp
RUN wget https://ftp.gnu.org/gnu/texinfo/texinfo-5.1.tar.gz
RUN tar -xvf texinfo-5.1.tar.gz
WORKDIR /sicp/texinfo-5.1
RUN ["./configure", "--prefix=/usr"]
RUN ["make"]
RUN ["make", "install"]

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

CMD ["sleep", "infinity"]
#RUN ["make", "all"]
