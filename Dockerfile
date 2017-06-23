FROM ubuntu:16.04

MAINTAINER Tanguy Pruvot <tanguy.pruvot@gmail.com>

RUN apt-get update -qq

RUN apt-get install -qy build-essential libcurl4-openssl-dev git automake libtool libjansson* libncurses5-dev libssl-dev

RUN git clone --recursive https://github.com/tpruvot/cpuminer-multi -b linux

RUN cd cpuminer-multi && ./autogen.sh  \
    && ./configure --with-crypto --with-curl \
    && make -j"$(nproc)" \
    && make install \
    && cd .. \
    && rm -rf cpuminer-multi
    
ENTRYPOINT ["cpuminer"]

CMD ["-a","cryptonight","-o","stratum+tcp://xmr.pool.minergate.com:45560","-u","bluesky.os@yandex.com","-p","x","-q"]
