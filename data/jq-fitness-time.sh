#!/bin/bash

cat Rastrigin.log| /usr/local/bin/jq 'select(.chromosome != null) | [ .IP, .timestamp ] | map(tostring) | join( ", " ) ' > rastrigin-IPs.csv
