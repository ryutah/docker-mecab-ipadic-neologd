FROM python:3.6.4-alpine

ARG BUILD_DEPS="git build-base bash curl file openssl sudo"

RUN apk add --no-cache $BUILD_DEPS

WORKDIR /tmp

RUN git clone https://github.com/taku910/mecab.git \
 && cd mecab/mecab \
 && ./configure --enable-utf8-only \
 && make \
 && make install \
 && rm -rf /tmp/mecab

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
 && cd mecab-ipadic-neologd \
 && ./bin/install-mecab-ipadic-neologd -n -a -y

WORKDIR /root

COPY ./run_mecab.sh /root

RUN chmod +x /root/run_mecab.sh

ENTRYPOINT ["/root/run_mecab.sh"]
