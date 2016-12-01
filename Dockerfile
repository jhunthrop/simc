FROM ubuntu:trusty

MAINTAINER reload

ARG version=master
LABEL version=${version}

WORKDIR /opt

RUN apt-get update && \
  apt-get install -y build-essential libssl-dev git && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean

RUN git clone -b "${version}" \
      --single-branch --depth 1 https://github.com/simulationcraft/simc.git && \
    cd /opt/simc/engine && \
    make OPENSSL=1 optimized && \
    cp /opt/simc/engine/simc /bin/simc && \
    rm -rf /opt/simc

CMD ['simc']
