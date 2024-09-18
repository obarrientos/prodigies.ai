#!/bin/bash
if ! pgrep apache2 > /dev/null
then
    echo "Restarting Apache"
    sudo systemctl restart apache2
fi
