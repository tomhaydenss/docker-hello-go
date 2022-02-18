FROM golang:1.17-alpine AS builder

WORKDIR /usr/src/app

COPY go.mod ./
RUN go mod download && go mod verify

COPY ./hello.go .

RUN go build -v -o /usr/local/bin/app ./...

FROM hello-world

WORKDIR /usr/local/bin/app

COPY --from=builder /usr/local/bin/app .

CMD ["./app"]
