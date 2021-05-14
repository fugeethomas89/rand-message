FROM golang:1.16-alpine as builder
WORKDIR /usr/src/rand-message
COPY . .
RUN CGO_ENABLED=0 go build -ldflags '-s -w --extldflags "-static -fpic"' -o target/rand-message

FROM alpine as runner
COPY --from=builder /usr/src/rand-message/target/rand-message /usr/bin/rand-message

CMD ["/usr/bin/rand-message"]
