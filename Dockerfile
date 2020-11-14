FROM ruby:2.7.2-alpine

ENV BUNDLER_VERSION=2.1.4

RUN apk add --update --no-cache bash build-base nodejs postgresql-dev tzdata ruby-dev yarn

RUN gem install bundler -v 2.1.4

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

COPY . ./

COPY "./entrypoints/docker-entrypoint.sh" /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
