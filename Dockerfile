# build stage
FROM golang:1.17-alpine AS builder

WORKDIR /app

# copy files to download dependencies
COPY ./go.mod ./go.sum ./

# download dependencies
RUN go mod download 

# explicitly download missing package
RUN go mod download google.golang.org/grpc

# copy project
COPY ./helloworld ./helloworld
# COPY . .

WORKDIR /app/helloworld

# build greeter_server binary
RUN CGO_ENABLED=0 GOOS=linux go build -o greeter_server ./greeter_server

# build greeter_client binary
RUN CGO_ENABLED=0 GOOS=linux go build -o greeter_client ./greeter_client

# final stage
FROM alpine:latest

WORKDIR /app

# copy built server & client binaries from previous stage
COPY --from=builder /app/helloworld/greeter_server .
COPY --from=builder /app/helloworld/greeter_client .

# set executable permission for binary
RUN chmod +x greeter_server greeter_client

# install go dependencies
RUN apk update && apk add --no-cache ca-certificates

# expose desired port
EXPOSE 50051

# set entrypoint to run greeter_server
CMD ["./greeter_server"]
