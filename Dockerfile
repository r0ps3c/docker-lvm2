FROM ubuntu:devel
ENV DEBIAN_FRONTEND noninteractive
RUN \
        apt update && \
	apt -y install gpg curl

COPY roprop-ubuntu-ppa-jammy.list /etc/apt/sources.list.d/

RUN \
	touch /etc/apt/trusted.gpg.d/roprop-ubuntu-ppa.gpg && \
	curl -s 'https://api.launchpad.net/devel/~roprop/+archive/ubuntu/ppa?ws.op=getSigningKeyData' | sed 's/^\"//;s/\"$//;s/\\n/\n/g' | gpg --no-options --no-default-keyring --batch --keyring /etc/apt/trusted.gpg.d/roprop-ubuntu-ppa.gpg --homedir /tmp --import -- && \
	apt update && \
        apt -y install lvm2 vdo && \
        apt -y --purge autoremove && \
        apt -y clean && \
        rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/sbin/lvm"]
