# Variables
$resourceGroupName = "Prodigies_ResourceGroup"
$location = "East US 2"
$workspaceName = "Prodigies-LogAnalytics"

# Create a Log Analytics Workspace
New-AzOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName -Name $workspaceName -Location $location -Sku "PerGB2018"
