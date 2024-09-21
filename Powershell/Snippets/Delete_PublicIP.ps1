# Define variables
$resourceGroupName = "Prodigies_ResourceGroup"
$publicIpName = "Prodigies-PublicIP"

# Remove the public IP address
Remove-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name $publicIpName