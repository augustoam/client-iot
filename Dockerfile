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

COPY bin $PROJECT_PATH/bin
COPY public $PROJECT_PATH/public
COPY vendor $PROJECT_PATH/vendor
COPY config $PROJECT_PATH/config
COPY lib/assets $PROJECT_PATH/lib/assets
COPY lib/tasks $PROJECT_PATH/lib/tasks
COPY lib/templates $PROJECT_PATH/lib/templates
COPY Rakefile config.ru $PROJECT_PATH/
COPY app/assets $PROJECT_PATH/app/assets
COPY app/models/application_record.rb $PROJECT_PATH/app/models/application_record.rb
COPY app/models/usuario.rb $PROJECT_PATH/app/models/usuario.rb
COPY app/models/admin.rb $PROJECT_PATH/app/models/admin.rb
ARG SECRET_KEY_BASE
RUN rails assets:precompile --trace

COPY app $PROJECT_PATH/app
COPY db $PROJECT_PATH/db

EXPOSE 3000
ENTRYPOINT ["bin/docker_entrypoint"]
CMD ["bundle", "exec", "puma"]
