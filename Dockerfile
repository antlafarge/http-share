FROM nginx:alpine

RUN rm -f -r -d /usr/share/nginx/html/*

COPY app.conf /etc/nginx/conf.d/
