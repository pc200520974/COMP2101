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
#!/bin/bash

# Get the hostname and FQDN
hostname=$(hostname)
fqdn=$(hostname -f)

# Get the operating system name and version
os_name_version=$(lsb_release -ds)

# Get the IP address of the default interface
ip_address=$(ip route get 1.1.1.1 | grep -oP 'src \K\S+')

# Get the root filesystem free space (human-friendly format)
root_free_space=$(df -h / | awk 'NR==2 {print $4}')

# Create an output template and use embedded variables
output_template="
Report for $hostname
===============
FQDN: $fqdn
Operating System name and version: $os_name_version
IP Address: $ip_address 
Root Filesystem Free Space: $root_free_space
===============
"

# Display the output
echo "$output_template"
