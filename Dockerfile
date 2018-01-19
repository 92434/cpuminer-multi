#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM ubuntu:12.10
RUN apt-get update && apt-get install -y \
  automake \
  libcurl4-openssl-dev \
  git \
  make

RUN		git clone https://github.com/pooler/cpuminer

RUN		cd cpuminer && ./autogen.sh
RUN		cd cpuminer && CFLAGS="-march=native" && ./configure --disable-aes-ni
RUN		cd cpuminer && make && make install

WORKDIR		/cpuminer
ENTRYPOINT	["./minerd"]
