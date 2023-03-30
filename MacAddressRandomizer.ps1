# Define the network adapter name
$adapterName = "Ethernet 3"

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

        # Generate a new random MAC address
        $newMacAddress = "00-15-5D-" + (Get-Random -Minimum 0 -Maximum 256).ToString("X2"), (Get-Random -Minimum 0 -Maximum 256).ToString("X2"), (Get-Random -Minimum 0 -Maximum 256).ToString("X2")
        
        # Check if the new MAC address is different from the previous one
        if ($newMacAddress -ne $adapter.MacAddress) {
            # Set the new MAC address
            Set-NetAdapterAdvancedProperty -Name $adapterName -DisplayName "Network Address" -RegistryValue $newMacAddress
        } else {
            # The new MAC address is the same as the previous one, do nothing
            Write-Host "New MAC address is the same as the previous one."
        }

        # Wait for 10 seconds before checking again
        Start-Sleep -Seconds 10
    }
}
