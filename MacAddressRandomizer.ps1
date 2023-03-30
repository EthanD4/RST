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

: '
 the purpose of the script is to randomize the MAC address of the computer whenever the internet connection is lost. 
 This is done to prevent the ISP from tracking the user's online activity by associating their MAC address with their
 internet usage. 
 
 The purpose of the service is to run the script in the background as a Windows service, 
 so that it can monitor the internet connection continuously and randomize the MAC address automatically 
 whenever the connection is lost. This way, the user doesn't have to manually run the script every time 
 the internet connection drops.
'
