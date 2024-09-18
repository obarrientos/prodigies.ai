
# Define variables
$resourceGroupName = "Prodigies_ResourceGroup"
$natGatewayName = "Prodigies-NAT"
$publicIpName = "Prodigies-PublicIP"

# Get the NAT Gateway
$natGateway = Get-AzNatGateway -ResourceGroupName $resourceGroupName -Name $natGatewayName

# Disassociate the Public IP from the NAT Gateway
$natGateway.PublicIpAddresses = $natGateway.PublicIpAddresses | Where-Object { $_.Id -ne "/subscriptions/33f8d807-62c2-4c19-9ba0-3d3cef4f5336/resourceGroups/$resourceGroupName/providers/Microsoft.Network/publicIPAddresses/$publicIpName" }

# Update the NAT Gateway
Set-AzNatGateway -NatGateway $natGateway
