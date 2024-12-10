FROM nginx:alpine

RUN rm -f -r /usr/share/nginx/html/*

COPY app.conf /etc/nginx/conf.d/
