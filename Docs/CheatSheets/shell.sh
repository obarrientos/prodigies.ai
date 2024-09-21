# Automated Deployment Script
git pull origin main
./build.sh
./deploy.sh


# Log Rotation Script
log_file="/var/log/myapp.log"
max_size=10485760 # 10MB
if [ $(stat -c%s "$log_file") -ge $max_size ]; then
    mv "$log_file" "$log_file.$(date +%F_%T)"
    touch "$log_file"
fi


# Script for Generating SSH Key
ssh-keygen -t rsa -b 4096 -C "youremail@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa


# Network Connectivity Script
if ping -c 1 google.com &> /dev/null
then
    echo "Internet connection is active"
else
    echo "No internet connection"
fi


# Cron Job Setup Script
(crontab -l ; echo "0 0 * * * /path/to/script.sh") | crontab -


# Script to Compress and Archive Old Files
find /path/to/files -type f -mtime +30 -exec tar -rvf archive.tar {} \;


# Project Clean-up Script
find . -type f -name "*.log" -delete
find . -type f -name "*.tmp" -delete


# Script to Find and Kill a Process by Name
kill $(ps aux | grep 'process_name' | awk '{print $2}')


# Environment Setup Script
sudo apt update
sudo apt install -y git vim curl


# Check If Service Is Running Script
if ! pgrep apache2 > /dev/null
then
    echo "Restarting Apache"
    sudo systemctl restart apache2
fi


# Directory Sync Script
rsync -av /source/directory /destination/directory


# Script to Restart Docker Containers
docker-compose down
docker-compose up -d


