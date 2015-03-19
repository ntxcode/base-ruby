FROM ubuntu-debootstrap:14.04
MAINTAINER Nathan Ribeiro, ntxdev <nathan@ntxdev.com.br>

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 && \
    printf "path-exclude /usr/share/doc/*\npath-exclude /usr/share/man/*\npath-exclude /usr/share/info/*\npath-exclude /usr/share/lintian/*" >> /etc/dpkg/dpkg.cfg.d/nodoc && \
    cd /usr/share && rm -fr doc/* man/* info/* lintian/*

ENV LANG      en_US.UTF-8
ENV LANGUAGE  en_US.UTF-8
ENV LC_ALL    en_US.UTF-8

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
        autoconf \
        ca-certificates \
        g++ \
        gcc \
        libc6-dev \
        make \
        patch \
        libbz2-dev \
        libcurl4-openssl-dev \
        libevent-dev \
        libffi-dev \
        libglib2.0-dev \
        libmysqlclient-dev \
        libncurses-dev \
        libpq-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxslt-dev \
        libyaml-dev \
        zlib1g-dev \
        git-core \
        libgeos-dev && \

    rm -rf /var/lib/apt/lists/* && \
    truncate -s 0 /var/log/*log

ENV RUBY_VERSION 2.2

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C3173AA6 && \
    echo deb http://ppa.launchpad.net/brightbox/ruby-ng-experimental/ubuntu trusty main > /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-trusty.list && \
    apt-get update -q && apt-get install -yq --no-install-recommends \
        ruby$RUBY_VERSION \
        ruby$RUBY_VERSION-dev && \

    # clean up
    rm -rf /var/lib/apt/lists/* && \
    truncate -s 0 /var/log/*log && \

    # Setup Rubygems
    echo 'gem: --no-document' > /etc/gemrc && \
    gem install bundler && gem update --system

RUN bundle config --global frozen 1 && \
    mkdir -p /usr/src/app

WORKDIR /usr/src/app

ONBUILD COPY Gemfile      /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app

CMD ["/usr/bin/ruby"]
