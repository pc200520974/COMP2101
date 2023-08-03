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
#!/bin/bash

# Check if the script is run with root privilege
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script requires root privilege. Please run with sudo or as root."
    exit 1
fi

# Function to check and print errors
print_error() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Function to print section title
print_section_title() {
    echo "=============================="
    echo "$1"
    echo "=============================="
}

# Function to display system description
display_system_description() {
    print_section_title "System Description"
    manufacturer=$(dmidecode -s system-manufacturer)
    model=$(dmidecode -s system-product-name)
    serial_number=$(dmidecode -s system-serial-number)
    echo "Computer manufacturer: $manufacturer"
    echo "Computer description or model: $model"
    echo "Computer serial number: $serial_number"
}

# Function to display CPU information
display_cpu_info() {
    print_section_title "CPU Information"
    cpu_info=$(lshw -class cpu)
    print_error "Failed to get CPU information."
    echo "$cpu_info" | awk '/product/ {print "CPU manufacturer and model:", $2, $3}'
    echo "$cpu_info" | awk '/width/ {print "CPU architecture:", $2}'
    echo "$cpu_info" | awk '/cores/ {print "CPU core count:", $2}'
    max_speed=$(echo "$cpu_info" | awk '/capacity/ {print $2}')
    echo "CPU maximum speed: $(echo "scale=2; $max_speed/1000" | bc) GHz"

    caches=$(echo "$cpu_info" | grep -A 3 "cache" | grep "size" | awk '{print $2, $3}')
    echo "Sizes of caches (L1, L2, L3): $caches"
}

# Function to display operating system information
display_os_info() {
    print_section_title "Operating System Information"
    os_name=$(lsb_release -ds)
    echo "Linux distro: ${os_name%% *}"
    echo "Distro version: $(lsb_release -rs)"
}

# Main script
display_system_description
display_cpu_info
display_os_info
