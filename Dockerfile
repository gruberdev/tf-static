FROM debian:10.9

ARG PRE_COMMIT_VERSION="2.11.1"
ARG GOLANG_VERSION="1.16.2"
ARG TERRAFORM_VERSION="0.15.2"
ARG TERRAFORM_DOCS_VERSION="v0.13.0"
ARG TFLINT_VERSION="v0.28.1"
ARG TFSEC_VERSION="v0.39.29"
ARG CHECKOV_VERSION="2.0.113"
ARG TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
ARG GOLANG_URL="https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz"

# Install general dependencies
RUN apt-get update -q && apt-get install -yqq --no-install-recommends \
 apt-utils locales iputils-tracepath mc nano \
 vim curl wget build-essential \
 unzip git subversion sudo  \
 software-properties-common && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*

# Install golang & terraform
RUN wget ${GOLANG_URL} && \
 wget -q ${TERRAFORM_URL} && \
 unzip -q terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
 rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
 tar xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
 rm -f go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV GOPATH /go
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR /run
ADD scripts .
# pre-commit-terraform & tflint & checkov & validate & fmt
RUN apt-get update && \
 sudo add-apt-repository ppa:deadsnakes/ppa && \
 sudo apt-get install -yqq --no-install-recommends  \
 python3.7 python3-pip && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* && \
 pip3 install setuptools==56.1.0  && \
 pip3 install pre-commit==2.12.1 && \
 chmod +x /run/tf-commit.sh && \
 sh /run/tf-commit.sh && \
 go get -u github.com/tfsec/tfsec/cmd/tfsec && \
 python3.7 -m pip install -U checkov==2.0.113  && python3.7 -m pip install -U checkov==2.0.113 

ENTRYPOINT [ "pre-commit" ]