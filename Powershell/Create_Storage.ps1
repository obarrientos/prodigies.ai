$storageAccount = "mystorageaccount"
$resourceGroup = "MyResourceGroup"
$location = "EastUS"

New-AzStorageAccount -ResourceGroupName $resourceGroup -AccountName $storageAccount -Location $location -SkuName "Standard_LRS" -Kind "StorageV2"
