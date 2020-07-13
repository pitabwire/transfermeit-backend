FROM golang:1.14 as builder

WORKDIR /
ADD go.mod ./
RUN go mod download
ADD . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o transfermeit .

FROM scratch
COPY --from=builder /go/src/github.com/maxisme/transfermeit-backend/transfermeit /transfermeit
WORKDIR /
ENTRYPOINT ["/transfermeit"]
