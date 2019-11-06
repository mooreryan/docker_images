FROM alpine:3.10.3

WORKDIR /root/downloads

COPY test.c .

RUN apk add --no-cache build-base && \
    gcc -lm -o test_prog test.c && \
    apk del build-base
