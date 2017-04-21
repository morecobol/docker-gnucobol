FROM debian:jessie-slim

WORKDIR /opt

RUN apt-get update -y
RUN apt-get install wget gcc make -y
RUN apt-get install libdb-dev libncurses5-dev libgmp-dev autoconf -y

RUN wget https://s3.amazonaws.com/cobol.run/gnu-cobol-2.0_rc-2.tar.gz
RUN tar zxf gnu-cobol-2.0_rc-2.tar.gz

WORKDIR gnu-cobol-2.0
RUN ./configure
RUN make
RUN make install
RUN make check
RUN ldconfig

WORKDIR ~/
COPY test.cob .
RUN cobc --version
RUN cobc -xj test.cob
