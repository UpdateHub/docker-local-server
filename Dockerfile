FROM golang:1.9.2-alpine3.6 as builder

RUN apk add --update --no-cache alpine-sdk linux-headers libarchive-dev

WORKDIR /go/src/github.com/updatehub/

RUN git clone https://github.com/updatehub/updatehub && \
    cd updatehub && git checkout 1.0.0

WORKDIR /go/src/github.com/updatehub/updatehub

RUN make vendor  updatehub-server

FROM alpine:3.6

RUN apk add --update libarchive

COPY --from=builder /go/src/github.com/updatehub/updatehub/bin/updatehub-server ./

VOLUME ["/data"]

EXPOSE 8080

ADD scripts/entrypoint ./

ENTRYPOINT ["./entrypoint"]
