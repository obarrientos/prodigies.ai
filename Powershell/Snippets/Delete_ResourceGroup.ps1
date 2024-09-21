# Define the parameter block
param(
    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
)

# Delete the resource group
Remove-AzResourceGroup -Name $resourceGroupName

Remove-AzResourceGroup -Name "MC_Prodigies_ResourceGroup_Prodigies-Kubernetes-Cluster_eastus2" -Force -AsJob