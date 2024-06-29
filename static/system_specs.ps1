# Display Operating System information
Write-Host "Operating System Information:"
Get-ComputerInfo | Select-Object CsName, WindowsVersion, WindowsBuildLabEx, OsArchitecture

# Display CPU information
Write-Host "`nCPU Information:"
Get-WmiObject -Class Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed

# Display Memory information
Write-Host "`nMemory Information:"
Get-WmiObject -Class Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, Speed | Format-Table -AutoSize
$totalMemory = (Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum
Write-Host "Total Physical Memory: $([Math]::Round($totalMemory / 1GB, 2)) GB"

# Display Disk information
Write-Host "`nDisk Information:"
Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | Select-Object DeviceID, VolumeName, Size, FreeSpace | Format-Table -AutoSize
foreach ($disk in Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }) {
    $size = [Math]::Round($disk.Size / 1GB, 2)
    $freeSpace = [Math]::Round($disk.FreeSpace / 1GB, 2)
    Write-Host "Drive $($disk.DeviceID): $size GB total, $freeSpace GB free"
}

# Display Network Adapter information
Write-Host "`nNetwork Adapter Information:"
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true } | Select-Object Description, MACAddress, IPAddress | Format-Table -AutoSize
