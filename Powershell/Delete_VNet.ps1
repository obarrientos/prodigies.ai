# Define variables
$resourceGroupName = "Prodigies_ResourceGroup"
$vnetName = "Prodigies-VNet"

# Remove the VNet
Remove-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnetName