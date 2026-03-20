#!/bin/bash
# Task 3: Backup Configuration for Web Servers
echo "--- Task 3: Backup Configuration for Web Servers ---"

# Create required directories for the assignment simulation
mkdir -p /etc/httpd /var/www/html
mkdir -p /etc/nginx /usr/share/nginx/html
mkdir -p /backups

# Create dummy content to backup
echo "Apache Config" > /etc/httpd/httpd.conf
echo "Apache Web Root" > /var/www/html/index.html
echo "Nginx Config" > /etc/nginx/nginx.conf
echo "Nginx Web Root" > /usr/share/nginx/html/index.html

# Ensure backup scripts exist for cron jobs
cat << 'EOF' > /usr/local/bin/backup_apache.sh
#!/bin/bash
DATE=$(date +%Y-%m-%d)
tar -czf /backups/apache_backup_$DATE.tar.gz /etc/httpd /var/www/html 2>/dev/null
EOF

cat << 'EOF' > /usr/local/bin/backup_nginx.sh
#!/bin/bash
DATE=$(date +%Y-%m-%d)
tar -czf /backups/nginx_backup_$DATE.tar.gz /etc/nginx /usr/share/nginx/html 2>/dev/null
EOF

chmod +x /usr/local/bin/backup_apache.sh
chmod +x /usr/local/bin/backup_nginx.sh

# Setup CRON jobs (every Tuesday at 12:00 AM)
# 0 0 * * 2
echo "0 0 * * 2 /usr/local/bin/backup_apache.sh" | crontab -u Sarah -
echo "0 0 * * 2 /usr/local/bin/backup_nginx.sh" | crontab -u mike -

echo "Cron jobs configured:"
echo "Sarah's crontab:"
crontab -u Sarah -l
echo "Mike's crontab:"
crontab -u mike -l

# Trigger manual backup for verification
/usr/local/bin/backup_apache.sh
/usr/local/bin/backup_nginx.sh

echo "Verifying backup integrity in /backups/:"
ls -lh /backups/
DATE=$(date +%Y-%m-%d)
echo "Integrity check (listing files in Apache backup):"
tar -tzf /backups/apache_backup_$DATE.tar.gz
echo "Integrity check (listing files in Nginx backup):"
tar -tzf /backups/nginx_backup_$DATE.tar.gz

echo "Backup Configuration setup complete."
