FROM golang:1.16.2 AS builder
WORKDIR /go/src/github.com/gliderlabs/registrator/
COPY . .
RUN \
	CGO_ENABLED=0 GOOS=linux go build \
		-a -installsuffix cgo \
		-ldflags "-X main.Version=$(cat VERSION)" \
		-o bin/registrator \
		.

FROM scratch
COPY --from=builder /go/src/github.com/gliderlabs/registrator/bin/registrator /bin/registrator
ENTRYPOINT ["/bin/registrator"]