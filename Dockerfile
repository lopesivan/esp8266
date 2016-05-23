FROM alpine:edge

MAINTAINER Huang Rui vowstar@gmail.com

ENV TOOLCHAIN /opt/xtensa-lx106-elf
ENV PATH $(TOOLCHAIN)/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
ENV COMPILE gcc

RUN apk --no-cache add \
        autoconf \
        automake \
        bison \
        bzip2 \
        flex \
        g++ \
        gawk \
        gcc \
        git \
        gperf \
        libtool \
        make \
        ncurses-dev \
        expat-dev \
        nano \
        python \
        py-pip \
        sed \
        texinfo \
        unrar \
        unzip \
        help2man \
        wget \
        expat-dev \
    && pip install pyserial \
    && mkdir -p /opt/crosstool \
    && adduser -D -H -u 1000 build \
    && chown -R build /opt/crosstool \
    && chgrp -R build /opt/crosstool

USER build

RUN cd /opt/crosstool \
    && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git esp-open-sdk \
    && cd esp-open-sdk \
    && make STANDALONE=n TOOLCHAIN=$(TOOLCHAIN)

USER root
