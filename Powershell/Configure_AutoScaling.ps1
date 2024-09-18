Add-AzVmssAutoscaleSetting -ResourceGroupName "MyResourceGroup" -VmssName "MyVmss" -MinCount 2 -MaxCount 10 -DefaultCount 3 `
-MetricName "Percentage CPU" -Operator GreaterThan -Threshold 80 -ScaleAction Increase -Cooldown 5
