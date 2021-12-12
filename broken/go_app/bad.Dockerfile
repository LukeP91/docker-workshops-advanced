FROM golang:1.15.2-alpine3.12
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN go build -o web .

EXPOSE 5000
CMD ["/build/web"]
