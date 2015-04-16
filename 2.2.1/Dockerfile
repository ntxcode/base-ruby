FROM ntxcode/ubuntu-base:14.04
MAINTAINER Nathan Ribeiro, ntxdev <nathan@ntxdev.com.br>

ENV RUBY_VERSION 2.2

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C3173AA6 && \
    echo deb http://ppa.launchpad.net/brightbox/ruby-ng-experimental/ubuntu trusty main > /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-trusty.list && \
    apt-get update -q && apt-get install -yq --no-install-recommends \
        # For bundler git gems
        git-core \
        # For postgis/rgeo support
        libgeos-dev \
        ruby$RUBY_VERSION \
        ruby$RUBY_VERSION-dev \
        libgeos-dev \
        ruby-geos \
        # Nginx
        nginx

# Setup Rubygems
RUN echo 'gem: --no-document' > /etc/gemrc && \
    gem install bundler && gem update --system

RUN rm -rf /var/lib/apt/lists/* && \
    truncate -s 0 /var/log/*log && \
    cd /usr/share && rm -fr doc/* man/* info/* lintian/* && \
    mkdir man/man1

RUN cd /usr/lib && ln -s libgeos-3.4.2.so libgeos.so

CMD ["/usr/bin/ruby"]
