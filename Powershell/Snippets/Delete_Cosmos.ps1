# Delete Cosmos DB account
$resourceGroupName = "Prodigies_ResourceGroup"
$accountName = "prodigies-cosmos"

Remove-AzCosmosDBAccount -ResourceGroupName $resourceGroupName `
                         -Name $accountName