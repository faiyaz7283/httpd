# Start with httpd alpine image
FROM httpd:alpine

LABEL maintainer="faiyaz7283@gmail.com"

# Create the www directory
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

# Set /var/www as working directory
WORKDIR /var/www