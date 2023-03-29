FROM alpine:latest AS font-builder

RUN apk --update add openssl wget unzip \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /fonts \
  && cd /fonts \
  && wget http://astralinux.ru/information/fonts-astra/font-ptastra-serif-ver1003.zip \
  && wget http://astralinux.ru/information/fonts-astra/font-ptastrasans-ttf-ver1002.zip \
  && unzip font-ptastra-serif-ver1003.zip \
  && unzip font-ptastrasans-ttf-ver1002.zip \
  && rm -rf *.zip

RUN apk add msttcorefonts-installer \
  && update-ms-fonts 

FROM debian:bookworm AS doc-builder

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends --assume-yes \
  texlive-latex-base \
  texlive-xetex \
  texlive-latex-extra \
  texlive-plain-generic \
  texlive-lang-cyrillic \
  python3-pygments \
  cmake \
  make

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends --assume-yes \
  texlive-extra-utils \
  ghostscript \
  imagemagick \
  inkscape \
  graphviz \
  dia

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends --assume-yes \
  cm-super \
  fonts-liberation \
  texlive-fonts-recommended
  # scalable-cyrfonts-tex

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends --assume-yes \
  latexmk

RUN dpkg-query --showformat='${binary:Package}\n' --show '*-doc' \
  | xargs apt-get -y remove

RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
  /usr/share/doc/* /usr/share/man/*

COPY --from=font-builder /fonts /usr/share/fonts/truetype/astra/
RUN chmod -R 644 /usr/share/fonts/truetype/astra/*
COPY --from=font-builder /usr/share/fonts/truetype/msttcorefonts /usr/share/fonts/truetype/msttcorefonts
RUN chmod -R 644 /usr/share/fonts/truetype/msttcorefonts/*
RUN fc-cache -f -v \
  && luaotfload-tool -u -f

WORKDIR /doc
COPY ./docker/scripts /scripts

ENTRYPOINT ["/scripts/boot.sh"]
