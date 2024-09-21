$publicIP = New-AzPublicIpAddress -ResourceGroupName "MyResourceGroup" -Name "MyPublicIP" -Location "EastUS" -AllocationMethod Static
$frontendIP = New-AzLoadBalancerFrontendIpConfig -Name "MyFrontendIP" -PublicIpAddress $publicIP

New-AzLoadBalancer -ResourceGroupName "MyResourceGroup" -Name "MyLoadBalancer" -Location "EastUS" -FrontendIpConfiguration $frontendIP
