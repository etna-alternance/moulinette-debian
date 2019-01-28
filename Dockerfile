FROM debian:8.1

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
	&& sed -i '$ a\deb http://packages.dotdeb.org stable all' /etc/apt/sources.list \
	&& sed -i '$ a\deb-src http://packages.dotdeb.org stable all' /etc/apt/sources.list \
	&& sed -i '$ a\deb http://packages.dotdeb.org wheezy-php55 all' /etc/apt/sources.list \
	&& sed -i '$ a\deb-src http://packages.dotdeb.org wheezy-php55 all' /etc/apt/sources.list \
	&& wget http://www.dotdeb.org/dotdeb.gpg \
	&& apt-key add dotdeb.gpg \
	&& rm dotdeb.gpg \
	&& apt-get -qq update \
	&& apt-get install -y --no-install-recommends wget curl build-essential php5 ruby ssh host tree bc

# Java
RUN apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    && echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
    && echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections \
	&& apt-get -qq update \
    && apt-get install -y oracle-java8-installer oracle-java8-set-default

# Cleanup
RUN rm -rf /var/lib/apt/lists/*
