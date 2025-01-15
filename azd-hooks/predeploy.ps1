#!/usr/bin/env pwsh

$credentialsOutput = az aks get-credentials --resource-group ${env:AZURE_RG_NAME} --name ${env:AZURE_AKS_CLUSTERNAME}

@"
image: ${env:AZURE_REGISTRY_URI}/maartenvandiemen/eshoponweb:latest
"@ | Out-File -FilePath ./custom-values.yaml -Encoding utf8 -Force

$releaseName = "eshoponweb"
$namespace = "default"

$releaseExists = helm list --namespace $namespace -q | Select-String -Pattern "^$releaseName$"

if ($releaseExists) {
    helm upgrade $releaseName ./eshoponweb-chart -f ./custom-values.yaml --namespace $namespace
} else {
    helm install $releaseName ./eshoponweb-chart -f ./custom-values.yaml --namespace $namespace
}