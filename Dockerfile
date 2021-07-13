FROM golang:1.16 AS builder
WORKDIR /go/src/github.com/gliderlabs/registrator/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /bin/registrator .

FROM scratch
COPY --from=builder /bin/registrator /bin/registrator
ENTRYPOINT ["/bin/registrator"]