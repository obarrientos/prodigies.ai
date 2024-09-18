# Variables
$resourceGroup = "Prodigies_ResourceGroup"
$location = "East US 2"
$vnetName = "Prodigies-VNet"
$subnetName = "default"

# Create a Virtual Network
New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16" -Subnet `
    @{Name=$subnetName; AddressPrefix="10.0.0.0/24"}