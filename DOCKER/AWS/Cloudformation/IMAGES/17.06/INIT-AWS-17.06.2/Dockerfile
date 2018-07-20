FROM centos:latest
ENV container docker

LABEL maintainer="Yann DANIEL <danielyann@me.com>"

# dependancies installation
RUN yum update -y
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py
RUN yum install -y wget
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -Uvh epel-release*rpm
RUN yum install -y jq bash ca-certificates sudo groff less libtool-ltdl.x86_64 ld-musl-x86_64
RUN pip install awscli && pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz

# Docker EE 17.06.2-ee6 setup

WORKDIR /
RUN groupadd docker -g 993 && useradd docker -g docker

# needed in order for go binary to work.
RUN wget https://storage.googleapis.com/golang/go1.8.1.linux-amd64.tar.gz && tar xvf go1.8.1.linux-amd64.tar.gz && rm go1.8.1.linux-amd64.tar.gz
RUN chown -R root:root ./go && mv go /usr/local
RUN echo "export GOPATH=$HOME/work" >> ~/.profile && echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> ~/.profile
RUN source ~/.profile

# setup init
RUN mkdir -p /usr/bin/ /var/log/docker/
COPY entry.sh entry.sh
COPY buoy /usr/bin/buoy
COPY ld-musl-x86_64.so.1 /lib
COPY libc.musl-x86_64.so.1 /lib
RUN chmod 755 /entry.sh /usr/bin/buoy

# Purge
RUN yum clean all && rm -rf /var/cache/yum

ENTRYPOINT ["/entry.sh"]
