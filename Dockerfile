FROM golang:1.16.2 AS builder
WORKDIR /go/src/github.com/gliderlabs/registrator/
COPY . .
RUN go build -o bin/registrator .

FROM scratch
COPY --from=builder /go/src/github.com/gliderlabs/registrator/bin/registrator /bin/registrator
ENTRYPOINT ["/bin/registrator"]