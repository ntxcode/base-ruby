FROM ntxcode/ubuntu-base
MAINTAINER Nathan Ribeiro, ntxdev <nathan@ntxdev.com.br>

ENV RUBY_VERSION 2.2

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C3173AA6 && \
    echo deb http://ppa.launchpad.net/brightbox/ruby-ng-experimental/ubuntu trusty main > /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-trusty.list && \
    apt-get update -q && apt-get install -yq --no-install-recommends \
        git-core \
        libgeos-dev \
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
