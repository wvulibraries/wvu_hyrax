FROM ruby:2.7.6

ENV BUNDLER_VERSION=2.2.27
ENV RAILS_VERSION=5.2.6

RUN mkdir -p /home/hyrax/
WORKDIR /home/hyrax
ADD ./hyrax /home/hyrax

RUN apt-get update && apt-get -y install cron

# Use JEMALLOC instead
# JEMalloc is a faster garbage collection for Ruby.
# -------------------------------------------------------------------------------------------------
RUN apt-get install -y libjemalloc2 libjemalloc-dev
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so

RUN \
  gem update --system --quiet && \
  gem install bundler -v ${BUNDLER_VERSION} && \
  gem install rails -v ${RAILS_VERSION} && \
  bundle install --jobs=4 --retry=3 

# FFMPEG Used to transcode video
# -------------------------------------------------------------------------------------------------
RUN apt-get install -y ffmpeg 

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

ADD ./startup.sh /usr/bin/
RUN chmod -v +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"]