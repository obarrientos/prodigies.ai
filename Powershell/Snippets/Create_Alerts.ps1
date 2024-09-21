Add-AzMetricAlertRule -ResourceGroupName "MyResourceGroup" -Name "HighCPUMetric" -TargetResourceId "/subscriptions/{sub-id}/resourceGroups/{rg-name}/providers/Microsoft.Compute/virtualMachines/{vm-name}" `
-MetricName "Percentage CPU" -Operator GreaterThan -Threshold 80 -WindowSize 00:05:00
