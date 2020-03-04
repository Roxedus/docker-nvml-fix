FROM amd64/ubuntu

LABEL maintainer="Roxedus"

ENV driver_version=440.44

RUN \
	apt-get update && apt-get install -y --no-install-recommends \
		git \
		make \
		ca-certificates \
		curl\
		build-essential && \
	git clone https://github.com/CFSworks/nvml_fix.git /tmp && \
	cd /tmp && \
	make TARGET_VER=$driver_version && \
	dpkg-divert --add --local --divert /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1.orig --rename /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1  && \
	make install libdir=/usr/lib/x86_64-linux-gnu TARGET=libnvidia-ml.so && \
	apt-get remove --auto-remove -y \
		make \
		build-essential \
		git
		
CMD ["watch nvidia-smi"]
