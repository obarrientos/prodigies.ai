# Define variables
$resourceGroupName = "Prodigies_ResourceGroup"
$workspaceName = "Prodigies-ResourceGroup-EUS2"

# Delete the Log Analytics Workspace
Remove-AzOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName -Name $workspaceName -Force