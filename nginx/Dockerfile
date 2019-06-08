FROM nginx:1.17.0
RUN apt-get update -qq && apt-get -y install apache2-utils nano curl

COPY nginx/application.conf /etc/nginx/conf.d/default.conf
ENV RAILS_ROOT /var/www/poll/public
WORKDIR $RAILS_ROOT
RUN envsubst '$RAILS_ROOT' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf

# check every 2s to ensure this service returns HTTP 200
HEALTHCHECK --interval=2s --timeout=3s --start-period=10s --retries=3 CMD curl http://localhost/nginx-healthz || exit 1