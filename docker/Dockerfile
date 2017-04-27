FROM debian:8

RUN apt-get update

RUN apt-get install -f -y cmake
RUN apt-get install -f -y make
RUN apt-get install -f -y inkscape
RUN apt-get install -f -y dia
RUN apt-get install -f -y graphviz
RUN apt-get install -f -y python-pygments
RUN apt-get install -f -y git
RUN apt-get install -f -y texlive-latex-base
RUN apt-get install -f -y texlive-lang-cyrillic
RUN apt-get install -f -y texlive-latex-extra
RUN apt-get install -f -y texlive-generic-extra
RUN apt-get install -f -y texlive-xetex

RUN dpkg-query --showformat '${binary:Package}\n' --show '*-doc' | xargs apt-get -y remove

RUN apt-get clean
RUN rm -r /var/lib/apt/lists /var/cache/apt/archives /usr/share/doc /usr/share/man

VOLUME ["/doc/"]

ADD scripts /scripts/

ENTRYPOINT ["/scripts/boot.sh"]
