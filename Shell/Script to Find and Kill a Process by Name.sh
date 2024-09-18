#!/bin/bash
kill $(ps aux | grep 'process_name' | awk '{print $2}')
