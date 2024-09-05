# Location for the Azure resources
loc='australiaeast'

# Resource group name where all resources will be created
grp='todelASVNETDemo9RG'

# App Service Plan name
pln='todelASVNETDemoRG9Plan'

# App Service name
appname='todelASVNETDemo9'

# Virtual Network (VNET) name
vnetName='VNET'

# App Service name (used in some contexts)
app='todelasvnetdemoapp9'

# Private Endpoint name for the App Service
privateEndpointName='privateEndpoint'

# Private DNS Zone name for the private endpoint
privateDnsZoneName='privatelink.azurewebsites.net'

# Subnet name for the private endpoint
subnetForPrivateEndpoint='PrivateEndpointSubnet'

# Subnet name for the self-hosted agent
subnetForSelfHostedAgent='SelfHostedAgentSubnet'

# Azure Container Instance (ACI) name for the self-hosted agent
aciName='selfhostedagentlinux'

# Docker image for the self-hosted agent
image='ghcr.io/waiholiu/selfhostedagentlinux:latest'

# Azure DevOps organization URL
azpUrl='https://dev.azure.com/wai0211'

# Personal Access Token (PAT) for Azure DevOps (replace with your actual token)
azpToken='<PAT token>'

# Azure DevOps agent pool name
azpPool='TestSelfHosted'

# Azure DevOps agent name
azpAgentName='Self Hosted Agent 9'