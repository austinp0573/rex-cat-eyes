#!/bin/sh

# 1. Clear memory caches to free up every possible drop of RAM
sync; echo 3 > /proc/sys/vm/drop_caches

# Permanent Swap Setup
dd if=/dev/zero of=/swapfile bs=1M count=128
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Ensure swap persists after reboot
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

# Tell Alpine to only swap as a last resort
sysctl vm.swappiness=1
echo "vm.swappiness=1" >> /etc/sysctl.conf

# 3. Update repositories and install nginx
apk update
apk add nginx

# 5. Create the web root directory
mkdir -p /var/www/cat-eyes

# 6. Configure Nginx for minimal resource usage
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

# 7. Fix base permissions (Nginx needs to own the folder)
chown -R nginx:nginx /var/www/cat-eyes
chmod 755 /var/www/cat-eyes

# 8. Enable and start Nginx
rc-update add nginx default
rc-service nginx start