FROM centos:latest
ENV container docker

LABEL maintainer="Yann DANIEL <danielyann@me.com>"

ARG CENTOS_FRONTEND=noninteractive

ENV AWS_REGION ''
ENV MANAGER_SECURITY_GROUP_ID ''
ENV WORKER_SECURITY_GROUP_ID ''

EXPOSE 5000

RUN yum update -y
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN python get-pip.py
RUN yum install -y wget
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -Uvh epel-release*rpm
RUN yum install -y jq libltdl-dev python-wheel python-pip crontabs libtool-ltdl.x86_64 ld-musl-x86_64
RUN pip install -U pip && \
    pip install awscli

COPY ./app /app
WORKDIR /app
COPY ld-musl-x86_64.so.1 /lib/
COPY libc.musl-x86_64.so.1 /lib/

RUN pip install -r requirements.txt

COPY entry.sh /

# Purge
RUN yum clean all && rm -rf /var/cache/yum

ENTRYPOINT ["/entry.sh"]
