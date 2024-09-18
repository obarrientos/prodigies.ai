New-AzVmss -ResourceGroupName "MyResourceGroup" -Location "EastUS" -VMScaleSetName "MyVmss" -SkuCapacity 2 -VirtualNetworkName "MyVNet" -SubnetName "MySubnet" `
    -PublicIpAddressName "MyPublicIP" -UpgradePolicyMode Automatic
