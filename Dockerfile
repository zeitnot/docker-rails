FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs netcat
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install
COPY . /app/
ENV BUNDLE_JOBS 8
ENTRYPOINT ["sh","/app/docker-entrypoint.sh"]
EXPOSE 3000
CMD ["bundle","exec","rails","server","-b","0.0.0.0"]

