# Variables
$resourceGroup = "MyResourceGroup"
$location = "EastUS"
$vnetName = "MyVNet"
$subnetName = "MySubnet"

# Create a Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create a Virtual Network
New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16" -Subnet `
    @{Name=$subnetName; AddressPrefix="10.0.0.0/24"}