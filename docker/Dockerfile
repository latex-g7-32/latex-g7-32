FROM debian:bookworm

# Update package lists and install necessary packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
       apt-get install --no-install-recommends --assume-yes \
            cmake \
            make \
            git \
            inkscape \
            dia \
            graphviz \
            perl \
            ghostscript \
            python3-pygments \
            imagemagick \
            texlive-latex-base \
            texlive-lang-cyrillic \
            texlive-xetex \
            texlive-latex-extra \
            texlive-plain-generic \
            texlive-fonts-extra \
            texlive-extra-utils

RUN dpkg-query --showformat='${binary:Package}\n' --show '*-doc' \
    | xargs apt-get -y remove

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
              /usr/share/doc/* /usr/share/man/*

VOLUME ["/doc/"]

ADD scripts /scripts/

ENTRYPOINT ["/scripts/boot.sh"]
