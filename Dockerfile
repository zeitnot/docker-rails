FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install
COPY . /app/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 3000
CMD ["bundle","exec","rails","server","-b","0.0.0.0"]