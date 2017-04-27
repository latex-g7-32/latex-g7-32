FROM debian:stretch

RUN apt-get update \
    && apt-get install --assume-yes cmake make \
                                    git \
                                    inkscape dia graphviz perl ghostscript \
                                    python-pygments \
                                    texlive-latex-base texlive-lang-cyrillic \
                                    texlive-xetex texlive-latex-extra \
                                    texlive-generic-extra texlive-fonts-extra \
    && (dpkg-query --showformat '${binary:Package}\n' --show '*-doc' \
        | xargs apt-get -y remove) \
    && apt-get clean \
    && rm -r /var/lib/apt/lists /var/cache/apt/archives /usr/share/doc \
             /usr/share/man

VOLUME ["/doc/"]

ADD scripts /scripts/

ENTRYPOINT ["/scripts/boot.sh"]
