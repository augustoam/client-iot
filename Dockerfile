FROM wondersistemas/ruby:v2.5.1
MAINTAINER Wonder Sistemas <wonder@wonder.com.br>

ENV RAILS_ENV production
ENV NODE_ENV production
ENV BABEL_ENV production
ENV BUNDLE_RETRY 15
ENV BUNDLE_TIMEOUT 30
ENV BUNDLE_WITHOUT "test development"

ENV PROJECT_PATH /usr/src/synchouse/src/
RUN mkdir -p $PROJECT_PATH
WORKDIR $PROJECT_PATH
COPY Gemfile Gemfile.lock $PROJECT_PATH
RUN bundle install -V
COPY . $PROJECT_PATH/
RUN rails assets:precompile --trace

EXPOSE 3000
ENTRYPOINT ["bin/docker_entrypoint"]
CMD ["bundle", "exec", "puma"]
