FROM php:apache
RUN export DEBIAN_FRONTEND=noninteractive && \
	ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
	apt-get update && \
	apt-get install \
		sudo \
		gcc \
		runc \
		iproute2 \
		locate \
		dnsutils \
		jq \
        socat \
        tcpdump \
        traceroute \
        netcat-traditional \
        dsniff \
		nmap \
		wget \
		openssh-client \
		net-tools \
		network-manager \
		curl \
		wget \
		netcat \
		iptables \
		procps \
		xz-utils \
		libssl-dev \
		libpam0g-dev \
		zlib1g-dev \
		dh-autoreconf \
		apt-transport-https \
		ca-certificates \
		gnupg-agent \
		software-properties-common \
		iputils-ping \
		nano \
		-y && \
	echo "www-data ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
	echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list && \
	apt-get update && \
	apt-get install docker-ce -y && \
	curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin && \
    chmod +x /usr/local/bin/kubectl
COPY yayfilesyay /var/www/html/
RUN chmod +x /var/www/html/*
CMD ["apache2-foreground"]
