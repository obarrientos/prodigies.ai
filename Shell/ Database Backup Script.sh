#!/bin/bash
mysqldump -u [user] -p[password] [database_name] > /backup/db_backup_$(date +%F).sql
