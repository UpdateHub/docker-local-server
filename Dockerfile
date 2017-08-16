FROM golang:1.8.3-alpine3.6 as builder

RUN apk add --update --no-cache alpine-sdk linux-headers libarchive-dev

WORKDIR /go/src/github.com/UpdateHub/

RUN git clone https://github.com/UpdateHub/updatehub

WORKDIR /go/src/github.com/UpdateHub/updatehub

RUN curl https://glide.sh/get | sh
RUN glide install

WORKDIR /go/src/github.com/UpdateHub/updatehub/cmd/updatehub-server

RUN go build -ldflags "-s -w"

FROM alpine:3.6

RUN apk add --update libarchive

COPY --from=builder /go/src/github.com/UpdateHub/updatehub/cmd/updatehub-server/updatehub-server /usr/local/bin

ENTRYPOINT ["./usr/local/bin/updatehub-server"]
