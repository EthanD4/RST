# Define the network adapter name
$adapterName = "Ethernet 3"

# Define the MAC address to change to
$newMacAddress = "00","15","5D",$(Get-Random -Minimum 00 -Maximum FF),$(Get-Random -Minimum 00 -Maximum FF),$(Get-Random -Minimum 00 -Maximum FF) -join '-'

# Start a continuous loop to check the connection status
while ($true) {
    # Get the network adapter information
    $adapter = Get-NetAdapter | Where-Object { $_.Name -eq $adapterName }

    # Check if the adapter is connected to the internet
    if ($adapter | Test-NetConnection -InformationLevel Quiet) {
        # The adapter is connected, do nothing
        Write-Host "Internet is connected."
    } else {
        # The adapter is not connected, change the MAC address
        Write-Host "Internet is disconnected. Changing MAC address..."

        # Set the new MAC address
        Set-NetAdapterAdvancedProperty -Name $adapterName -DisplayName "Network Address" -RegistryValue $newMacAddress

        # Wait for 10 seconds before checking again
        Start-Sleep -Seconds 10
    }
}
