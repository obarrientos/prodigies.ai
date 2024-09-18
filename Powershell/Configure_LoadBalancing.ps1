New-AzLoadBalancerRuleConfig -Name "HTTP" -FrontendIpConfiguration $frontend -BackendAddressPool $backend -Protocol Tcp -FrontendPort 80 -BackendPort 80
