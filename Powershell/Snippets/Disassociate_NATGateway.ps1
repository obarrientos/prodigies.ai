
# Variables for subnet
$vnetName = "Prodigies_ResourceGroup"
$subnetName = "default"

# Get the VNet and subnet
$vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName
$subnet = $vnet.Subnets | Where-Object { $_.Name -eq $subnetName }

# Disassociate NAT Gateway
$subnet.NatGateway = $null

# Update the subnet
Set-AzVirtualNetwork -VirtualNetwork $vnet
