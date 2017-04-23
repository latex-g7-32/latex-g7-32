FROM debian:8

RUN apt-get update

RUN apt-get install -f -y texlive-full
RUN apt-get install -f -y cmake
RUN apt-get install -f -y make
RUN apt-get install -f -y inkscape
RUN apt-get install -f -y dia
RUN apt-get install -f -y graphviz
RUN apt-get install -f -y python-pygments
RUN apt-get install -f -y git

RUN apt-get clean
RUN apt-get autoclean -y
RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
RUN rm -f /etc/ssh/ssh_host_*

VOLUME ["/doc/"]

ADD scripts /scripts/

ENTRYPOINT ["/scripts/boot.sh"]
