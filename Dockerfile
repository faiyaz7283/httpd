# Start with httpd alpine image
FROM httpd:alpine

LABEL maintainer="faiyaz7283@gmail.com"

# Create the SSL directory
RUN mkdir -p /usr/local/apache2/ssl

# Create the conf/other directory
RUN mkdir -p /usr/local/apache2/conf/other

# Move all files from extra to other dir, except few common used files
RUN cd /usr/local/apache2/conf/extra &&\
ls | egrep -v -e "httpd-(default|ssl|vhosts)\.conf|other" | xargs -I {} mv {} /usr/local/apache2/conf/other

# Create the www directory
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

# Copy over the modified httpd.conf file
COPY httpd.conf /usr/local/apache2/conf/

# Set /var/www as working directory
WORKDIR /var/www