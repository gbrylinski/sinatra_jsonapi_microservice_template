FROM ruby:latest
LABEL description="MicroService #1"
LABEL author="grze.codes"

ENV APP_PATH /app
ENV BUNDLE_PATH /bundle

#RUN apt-get update -qy && apt-get dist-upgrade -qy && apt-get install openssl-dev
RUN apt-get install -yq libssl-dev

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

RUN gem install bundler --no-ri --no-rdoc

ADD . $APP_PATH

RUN bundle install

EXPOSE 9292
CMD bundle exec rackup -s Rhebok -o 0.0.0.0 -p 9292
