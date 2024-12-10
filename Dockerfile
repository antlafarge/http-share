FROM nginx:alpine

RUN rm -f -r /usr/share/nginx/html/*

COPY default.conf /etc/nginx/conf.d/
