FROM eggmuffin/ddc-init-aws:17.03.2-ee-6-aws1
ENV container docker

LABEL maintainer="Yann DANIEL <danielyann@me.com>"

WORKDIR /

COPY entry.sh /

RUN chmod +x entry.sh && chown root:root entry.sh

ENTRYPOINT ["/entry.sh"]
