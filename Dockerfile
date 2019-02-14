FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TZ Europe/Paris


# Common
RUN apt-get -qq update \
	&& apt-get install -y --no-install-recommends -y locales wget \
	&& sed -i '$ a\en_US.UTF-8 UTF-8' /etc/locale.gen \
	&& sed -i '$ a\fr_FR.UTF-8 UTF-8' /etc/locale.gen \
	&& locale-gen en_US.UTF-8 fr_FR.UTF-8 \
	&& apt-get install -y --no-install-recommends wget curl build-essential php ruby ssh host tree bc

# Java
RUN apt-get install -y default-jre default-jdk

# Cleanup
RUN rm -rf /var/lib/apt/lists/*
