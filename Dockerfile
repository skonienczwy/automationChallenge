FROM nginx:1.21.1

COPY index.html /data/www/
COPY cgi.conf /etc/nginx/cgi.conf
COPY nginx.conf /etc/nginx/nginx.conf
