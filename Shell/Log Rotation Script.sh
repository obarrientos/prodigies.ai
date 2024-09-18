#!/bin/bash
log_file="/var/log/myapp.log"
max_size=10485760 # 10MB
if [ $(stat -c%s "$log_file") -ge $max_size ]; then
    mv "$log_file" "$log_file.$(date +%F_%T)"
    touch "$log_file"
fi
