#!/bin/bash

# Display Operating System information
echo "Operating System Information:"
hostnamectl | grep "Operating System\|Kernel"

# Display CPU information
echo -e "\nCPU Information:"
lscpu | grep "Model name\|Socket(s)\|Core(s) per socket\|Thread(s) per core\|CPU MHz"

# Display Memory information
echo -e "\nMemory Information:"
sudo dmidecode --type 17 | grep -E "Manufacturer:|Size:|Speed:" | grep -v "Configured Clock Speed" | grep -A2 "Size: [0-9]" | awk '{gsub(/^ *| *$/,"")}1'
echo "Total Physical Memory: $(free -h --si | awk '/^Mem:/{print $2}')"

# Display Disk information
echo -e "\nDisk Information:"
df -h --output=source,fstype,size,used,avail,pcent,target -x tmpfs -x devtmpfs

# Display Network Adapter information
echo -e "\nNetwork Adapter Information:"
ip -o -4 addr show | awk '{print $2, $4}'
