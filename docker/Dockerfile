FROM centos

RUN mkdir /tfinfra \
&& yum install zip unzip -y \
&& curl https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip --output terraform_0.12.6_linux_amd64.zip \
&& unzip terraform_0.12.6_linux_amd64.zip \
&& mv terraform /usr/bin \
&& rm -fR terraform_0.12.6_linux_amd64.zip
WORKDIR /tfinfra
