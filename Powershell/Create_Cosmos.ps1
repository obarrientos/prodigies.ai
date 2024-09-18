# Variables
$resourceGroupName = "Prodigies_ResourceGroup"
$location = "East US 2"
$accountName = "prodigies-cosmos"
$kind = "GlobalDocumentDB"  # SQL API
$skuName = "Free"

# Create Cosmos DB account
New-AzCosmosDBAccount -ResourceGroupName $resourceGroupName `
                      -Name $accountName `
                      -Location $location `
                      -ApiKind $kind `
                      -DefaultConsistencyLevel "Session" `
                      -EnableAutomaticFailover `
                      -EnableMultipleWriteLocations `
                      -EnableFreeTier $true `
                      -EnableBurstCapacity $true `
                      -EnableAnalyticalStorage $true `
                      -PublicNetworkAccess "Disabled"
