ARG RUBY_VERSION=2.7.6
FROM ruby:$RUBY_VERSION

ENV LANG C.UTF-8
ENV NODE_VERSION 16
ENV NODE_ENV development
ENV INSTALL_PATH /home/hyrax

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends nodejs postgresql-client yarn build-essential vim graphicsmagick ghostscript ffmpeg 

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
ADD ./hyrax $INSTALL_PATH

RUN gem install bundler
RUN bundle install
RUN yarn install --check-files
RUN yarn upgrade
RUN rm -rf tmp

# RUN useradd -Ms /bin/bash app -u 1001

# RUN addgroup -S --gid 101 app && \
#   adduser -S -G app -u 1001 -s /bin/sh -h /app app
# USER app