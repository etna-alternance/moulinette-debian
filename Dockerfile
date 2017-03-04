FROM debian:8.1

MAINTAINER Theo Massard massar_t@etna-alternance.net

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TZ Europe/Paris

RUN apt-get -qq update \
	&& apt-get install -y --no-install-recommends -y locales wget \
	&& sed -i '$ a\en_US.UTF-8 UTF-8' /etc/locale.gen \
	&& sed -i '$ a\fr_FR.UTF-8 UTF-8' /etc/locale.gen \
	&& locale-gen en_US.UTF-8 fr_FR.UTF-8 \
	&& sed -i '$ a\deb http://packages.dotdeb.org stable all' /etc/apt/sources.list \
	&& sed -i '$ a\deb-src http://packages.dotdeb.org stable all' /etc/apt/sources.list \
	&& sed -i '$ a\deb http://packages.dotdeb.org wheezy-php55 all' /etc/apt/sources.list \
	&& sed -i '$ a\deb-src http://packages.dotdeb.org wheezy-php55 all' /etc/apt/sources.list \
	&& wget http://www.dotdeb.org/dotdeb.gpg \
	&& apt-key add dotdeb.gpg \
	&& rm dotdeb.gpg \
	&& apt-get -qq update \
	&& apt-get install -y --no-install-recommends build-essential php5 ruby ssh host \
	&& rm -rf /var/lib/apt/lists/*
