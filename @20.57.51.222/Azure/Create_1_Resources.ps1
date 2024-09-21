# Variables
$resourceGroup = "ProdigiesAI_ResourceGroup"
$backoffice_resourceGroup = "ProdigiesAI_ResourceGroup"
$location = "EastUS2"
$vnetName = "ProdigiesAI-VNet"
$subnetName = "default"
$publicIpName = "ProdigiesAI-PublicIP"

# 1. Create ProdigiesAI Resource Group
Write-Verbose "Creating ProdigiesAI Resource Group..."
New-AzResourceGroup -Name $resourceGroup -Location $location


# 2. Create BackOffice Resource Group
Write-Verbose "Creating BackOffice Resource Group..."
New-AzResourceGroup -Name $backoffice_resourceGroup -Location $location

# 3. Create Virtual Network and Subnet
Write-Verbose "Creating Virtual Network and Subnet..."        
$vnet = New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $vnetName -AddressPrefix "10.0.0.0/16" -Force
$subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# 4. Create Public IP Address for Public-facing VM (Zeus-VM)
Write-Verbose "Creating Public IP for Public-facing VM..."
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroup -Name $publicIpName -Location $location -AllocationMethod Static -Sku Standard -Force