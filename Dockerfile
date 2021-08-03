FROM wordpress:$WORDPRESS_VERSION

# replace wp-content with our own
RUN rm -fr /usr/src/wordpress/wp-content
COPY wp-content/ /usr/src/wordpress/wp-content/
RUN chown -R www-data:www-data /usr/src/wordpress/wp-content

WORKDIR /var/www/html
