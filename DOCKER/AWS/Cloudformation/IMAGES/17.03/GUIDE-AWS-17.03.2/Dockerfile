FROM centos:7.3.1611
ENV container docker

LABEL maintainer="Yann DANIEL <danielyann@me.com>"

ARG CENTOS_FRONTEND=noninteractive

RUN yum update -y
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py
RUN yum install -y wget
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -Uvh epel-release*rpm
RUN yum install -y jq libltdl-dev python-wheel python-pip crontabs libtool-ltdl.x86_64 ld-musl-x86_64
RUN pip install -U pip && \
    pip install awscli

WORKDIR /

RUN groupadd docker -g 993
RUN useradd docker -g docker
RUN mkdir -p /usr/docker /var/log/cron /var/log/docker

COPY ./bin/* /usr/bin/
COPY ./crontabs/root /usr/docker/crontab.txt

COPY entry.sh /

# Purge
RUN yum clean all && rm -rf /var/cache/yum

ENTRYPOINT ["/entry.sh"]
