# Start with httpd alpine image
FROM httpd:alpine

LABEL maintainer="faiyaz7283@gmail.com"

# Install bash and other helpful tools
RUN apk add --no-cache bash bash-completion busybox-suid sudo git nano curl man

# Create the SSL directory
RUN mkdir -p /usr/local/apache2/ssl

# Create the conf/other directory
RUN mkdir -p /usr/local/apache2/conf/other

# Move all files from extra to other dir, except few common used files
RUN cd /usr/local/apache2/conf/extra && \
    ls | egrep -v -e "httpd-(default|ssl|vhosts)\.conf|other" | xargs -I {} mv {} /usr/local/apache2/conf/other

# Create the www directory
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

# Add the missing libphp5.so module.
RUN apk add --no-cache php5-apache2 && \
    cp /usr/lib/apache2/libphp5.so /usr/local/apache2/modules/libphp5.so && \
    apk del --no-cache --purge -r php5-apache2

# Add a group and user
RUN addgroup -g 1000 -S dcutil && \
    adduser -D -u 1000 -s /bin/bash -G dcutil dcutil

# Copy over the modified httpd.conf file
COPY httpd.conf /usr/local/apache2/conf/

# Set /var/www as working directory
WORKDIR /var/www