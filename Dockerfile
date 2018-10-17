FROM golang:1.10.4 as builder
WORKDIR /go/src/github.com/tpmacc/simple-server/
RUN go get -d -v golang.org/x/net/html  
COPY server.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/tpmacc/simple-server/server .
CMD ["./server"]  
