#!/usr/bin/env pwsh

try {
    az group delete --name ${env:AZURE_RG_NAME} --yes
} catch {
    Write-Error "Failed to get AKS credentials: $_"
    exit 1
}