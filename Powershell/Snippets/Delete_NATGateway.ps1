# Variables
$resourceGroupName = "Prodigies_ResourceGroup"
$natGatewayName = "Prodigies-NAT"

# Delete the NAT Gateway
Remove-AzNatGateway -ResourceGroupName $resourceGroupName -Name $natGatewayName -Force
