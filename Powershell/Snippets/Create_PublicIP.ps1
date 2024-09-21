$resourceGroupName = "Prodigies_ResourceGroup"
$publicIpName = "Prodigies-PublicIP"
$location = "East US 2"

New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name $publicIpName -Location $location -AllocationMethod Static -Sku Standard
