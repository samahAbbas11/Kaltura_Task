# get the latest version of nginx image from docker hub
FROM nginx:latest

# Copy html file from current directory to nginx html directory
COPY ./index.html /usr/share/nginx/html/index.html

EXPOSE 80