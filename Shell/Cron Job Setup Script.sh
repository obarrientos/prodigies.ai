#!/bin/bash
(crontab -l ; echo "0 0 * * * /path/to/script.sh") | crontab -
