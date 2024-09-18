# Define variables
$resourceGroupName = "Prodigies_ResourceGroup"
$aksClusterName = "Prodigies-Kubernates-Cluster"

# Delete the Kubernetes cluster
Remove-AzAksCluster -ResourceGroupName $resourceGroupName -Name $aksClusterName
