#!/bin/bash

# Source the variable file
source ./variables.sh

# CREATING RESOURCE GROUP
az group create --name $grp --location $loc

# CREATING APP SERVICE PLAN
az appservice plan create --name $pln --resource-group $grp --location $loc --sku S1

# CREATING APP SERVICE
az webapp create --name $app --plan $pln --resource-group $grp

# DISABLE PUBLIC NETWORK ACCESS
az webapp update --name $app --resource-group $grp --set publicNetworkAccess=Disabled

# CREATE VIRTUAL NETWORK
az network vnet create --address-prefixes 10.0.0.0/16 --name $vnetName --resource-group $grp


# CREATING SUBNET FOR PRIVATE ENDPOINT
az network vnet subnet create -g $grp --vnet-name $vnetName -n $subnetForPrivateEndpoint --address-prefixes 10.0.1.0/24


# CREATE PRIVATE DNS ZONE
az network private-dns zone create --resource-group $grp --name $privateDnsZoneName

# LINK PRIVATE DNS ZONE TO VNET
az network private-dns link vnet create --resource-group $grp --zone-name $privateDnsZoneName --name MyDNSLink --virtual-network $vnetName --registration-enabled false



# CREATE PRIVATE ENDPOINT
MSYS_NO_PATHCONV=1 az network private-endpoint create --resource-group $grp --vnet-name $vnetName --subnet $subnetForPrivateEndpoint --name $privateEndpointName --private-connection-resource-id $(az webapp show --name $app --resource-group $grp --query id --output tsv) --group-ids sites --connection-name myConnection

# CONFIGURE PRIVATE DNS ZONE
az network private-dns record-set a add-record --resource-group $grp --zone-name $privateDnsZoneName --record-set-name $app --ipv4-address $(az network private-endpoint show --name $privateEndpointName --resource-group $grp --query 'customDnsConfigs[0].ipAddresses[0]' --output tsv)

az network private-dns record-set a add-record --resource-group $grp --zone-name $privateDnsZoneName --record-set-name $app.scm --ipv4-address $(az network private-endpoint show --name $privateEndpointName --resource-group $grp --query 'customDnsConfigs[0].ipAddresses[0]' --output tsv)


