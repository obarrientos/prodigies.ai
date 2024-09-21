$resourceGroup = "Prodigies_ResourceGroup"
$location = "EastUS2"
$vnetName = "Prodigies-VNet"
$subnetName = "default"

$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup
Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet
