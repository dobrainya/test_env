FROM nginx:latest

#RUN apt-get update && apt-get install -y \
 #       nano \
 #       mc

WORKDIR /etc/nginx/conf.d

COPY hosts.local.conf .

WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]
