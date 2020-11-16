FROM ruby:2.7.2

ENV BUNDLER_VERSION=2.1.4

RUN apt-get update -qq && apt-get install -y build-essential nodejs postgresql-client yarn

WORKDIR /app

RUN gem install bundler -v 2.1.4

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . ./

COPY "./entrypoints/docker-entrypoint.sh" /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
