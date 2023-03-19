# Set the DNS servers to use
$primaryDns = "1.1.1.1"
$secondaryDns = "1.0.0.1"

# Get the network adapter configuration for Ethernet 3
$adapter = Get-NetAdapter | Where-Object {$_.Name -eq "Ethernet 3"}

# Set the DNS server addresses
Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses ($primaryDns, $secondaryDns)

#https://www.thewindowsclub.com/change-dns-server-using-command-prompt-and-powershell