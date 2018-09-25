FROM ubuntu:16.04


RUN apt-get update && \
    apt-get install -y curl make git-core gcc && \
    apt-get clean
#Install Go    
RUN curl -Lo /tmp/go1.11.tar.gz https://dl.google.com/go/go1.11.linux-amd64.tar.gz && \ 
tar -xvf /tmp/go1.11.tar.gz -C /usr/local/
ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=${GOPATH}/bin:${GOROOT}/bin:${PATH}
RUN go version

#Install goreleaser
RUN go get -d github.com/goreleaser/goreleaser
RUN mkdir /root/go/bin
WORKDIR /root/go/src/github.com/goreleaser/goreleaser/
RUN make setup build
RUN dep ensure -vendor-only

#Install jFrog CLI
RUN curl -Lo /usr/bin/jfrog https://api.bintray.com/content/jfrog/jfrog-cli-go/\$latest/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64
RUN chmod +x /usr/bin/jfrog
