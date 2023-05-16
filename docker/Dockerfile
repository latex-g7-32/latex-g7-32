FROM alpine:latest AS font-builder

RUN apk --update add openssl wget unzip \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /fonts \
  && cd /fonts \
  && wget http://astralinux.ru/information/fonts-astra/font-ptastra-serif-ver1003.zip \
  && wget http://astralinux.ru/information/fonts-astra/font-ptastrasans-ttf-ver1002.zip \
  && unzip font-ptastra-serif-ver1003.zip \
  && unzip font-ptastrasans-ttf-ver1002.zip \
  && rm -rf *.zip \
  && apk add msttcorefonts-installer \
  && update-ms-fonts 

FROM debian:bookworm AS doc-builder

COPY --from=font-builder /fonts /usr/share/fonts/truetype/astra/
COPY --from=font-builder /usr/share/fonts/truetype/msttcorefonts /usr/share/fonts/truetype/msttcorefonts

RUN chmod -R 644 /usr/share/fonts/truetype/astra/* \
  && chmod -R 644 /usr/share/fonts/truetype/msttcorefonts/* \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends --assume-yes \
  texlive-latex-base \
  texlive-xetex \
  texlive-latex-extra \
  texlive-plain-generic \
  texlive-lang-cyrillic \
  texlive-science \
  python3-pygments \
  cm-super \
  fonts-liberation \
  texlive-fonts-recommended \
  fontconfig \
  cmake \
  make \
  inkscape \
  dia \
  graphviz \
  imagemagick \
  texlive-extra-utils \ 
  ghostscript \
  && dpkg-query --showformat='${binary:Package}\n' --show '*-doc' \
  | xargs apt-get -y remove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
  /usr/share/doc/* /usr/share/man/* \
  && fc-cache -f -v

WORKDIR /doc
COPY ./docker/scripts /scripts

ENTRYPOINT ["/scripts/boot.sh"]
