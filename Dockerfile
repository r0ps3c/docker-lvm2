FROM ubuntu:rolling
ENV DEBIAN_FRONTEND noninteractive
RUN \
        apt update && \
        apt -y install lvm2 && \
        apt -y --purge autoremove && \
        apt -y clean && \
        rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/sbin/lvm"]
