FROM httpd:alpine

# Copy our vhost config & tell Apache to use it
COPY vhost.conf /usr/local/apache2/conf/
RUN echo "Include conf/vhost.conf" >> /usr/local/apache2/conf/httpd.conf

# Enable expires & rewrite modules
RUN sed -i \
  -e 's/#LoadModule expires_module/LoadModule expires_module/' \
  -e 's/#LoadModule rewrite_module/LoadModule rewrite_module/' \
  /usr/local/apache2/conf/httpd.conf

COPY site/public/ /app/
