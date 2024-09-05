#!/bin/bash

# Source the variable file
source ./variables.sh

# CREATE SUBNET FOR SELF HOSTED AGENT
az network vnet subnet create -g $grp --vnet-name $vnetName -n $subnetForSelfHostedAgent --address-prefixes 10.0.2.0/24

# CREATE SELF HOSTED AGENT
az container create \
  --resource-group $grp \
  --name $aciName \
  --image $image \
  --vnet $vnetName \
  --subnet $subnetForSelfHostedAgent \
  --environment-variables AZP_URL=$azpUrl AZP_TOKEN=$azpToken AZP_POOL=$azpPool AZP_AGENT_NAME="$azpAgentName" \
  --ports 80 443