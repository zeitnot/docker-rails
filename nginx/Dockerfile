FROM nginx:1.17.0
RUN apt-get update -qq && apt-get -y install apache2-utils nano curl

COPY nginx/application.conf /etc/nginx/conf.d/default.conf
ENV RAILS_ROOT /var/www/poll/public
WORKDIR $RAILS_ROOT
RUN envsubst '$RAILS_ROOT' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf