#!/bin/sh

# 1. Update repositories and install nginx
apk update
apk add nginx

# 2. Create the web root directory
mkdir -p /var/www/cat-eyes

# 3. Configure Nginx for minimal resource usage
cat << 'EOF' > /etc/nginx/http.d/default.conf
server {
    listen 80;
    server_name _;

    root /var/www/cat-eyes;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    # Disable access logs to save disk I/O and CPU cycles
    access_log off;
    error_log /var/log/nginx/error.log crit;
}
EOF

# 4. Fix base permissions (Nginx needs to own the folder)
chown -R nginx:nginx /var/www/cat-eyes
chmod 755 /var/www/cat-eyes

# 5. Enable and start Nginx
rc-update add nginx default
rc-service nginx start