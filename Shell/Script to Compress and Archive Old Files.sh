#!/bin/bash
find /path/to/files -type f -mtime +30 -exec tar -rvf archive.tar {} \;
