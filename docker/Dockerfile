FROM boscore/builder as builder
ARG branch=master

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates curl wget git cmake python3 g++ && rm -rf /var/lib/apt/lists/*

RUN cd / && git clone --depth 1 -b $branch https://github.com/boscore/bos.cdt.git --recursive \
    && cd /bos.cdt/ \
    && ./build.sh \
    && ./install.sh \
    && cd .. \
    && rm -rf ./bos.cdt

