#!/bin/bash

# Display the Fully Qualified Domain Name (FQDN)
fqdn=$(hostname)
echo "FQDN: $fqdn"

# Display host information using hostnamectl
echo "Host Information:"
hostnamectl

# Display IP addresses using grep to filter out 127.0.0.1 addresses
ip_addresses=$(hostname -I | grep -v '^127')
echo "IP Addresses:"
echo $ip_addresses

# Display root filesystem status using df
echo "Root Filesystem Status:"
df -h /
