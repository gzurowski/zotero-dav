## Builder
FROM nginx:alpine AS builder

RUN apk add --no-cache \
    gcc \
    libc-dev \
    libxml2-dev \
    libxslt-dev \
    make \
    pcre-dev

# Nginx sources
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O nginx.tar.gz && \
    tar -xzC /tmp -f nginx.tar.gz

# WebDAV extension module sources
RUN wget "https://github.com/arut/nginx-dav-ext-module/archive/v3.0.0.tar.gz" -O nginx-dav-ext-module.tar.gz && \
    tar -xzC /tmp -f nginx-dav-ext-module.tar.gz

# Build module
RUN cd /tmp/nginx-${NGINX_VERSION} && \
    ./configure --with-compat --add-dynamic-module=/tmp/nginx-dav-ext-module-3.0.0 && \
    make modules

## Main
FROM nginx:alpine

# Copy compiled module
COPY --from=builder /tmp/nginx-${NGINX_VERSION}/objs/ngx_http_dav_ext_module.so /etc/nginx/modules/

RUN apk add --no-cache \
    apache2-utils \
    libxml2

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
