FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install
COPY . /app/
EXPOSE 3000
WORKDIR /app
CMD ["bundle","exec","rails","server","-b","0.0.0.0"]