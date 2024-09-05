# SelfHostedAgentLinux

just an image with the self-hosted agent for Azure DevOps (linux) as documented at https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops



# How to use

Docker-publish.xml is a github action that will build and push the image to the docker registry. The image is tagged with the build number and the latest tag.

It can be run anywhere - by referencing the image at ghcr.io/waiholiu/selfhostedagentlinux:latest

eg. to run the image on a local machine:

```bash
docker run -e AZP_URL="https://dev.azure.com/wai0211" -e AZP_TOKEN="<token>" -e AZP_POOL="TestSelfHosted" -e AZP_AGENT_NAME="Docker Agent - Linux" --name "ghcr-agent-linux" ghcr.io/waiholiu/selfhostedagentlinux:latest

```

# Environment Variables
Env variables to feed into the container are detailed at https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#environment-variables

AZP_TOKEN - the PAT token for the agent to connect to Azure DevOps





# Set up Self Hosted Agent example

## Set up agent pool 

- In DevOps, go to organization settings, Agent pools and create a new one
- Get the PAT token with access to Agent Pools (Read and Manage)
- From DevOps you'll need the following information
  - URL of your DevOps organization (eg. https://dev.azure.com/orgID)
  - PAT token
  - Agent pool name

Go to the variables.sh file and update the variables with the information from above as well as the info about what resource group and name of your app service etc.


## Set up scenario

The scenario is that you have an App Service that is only accessible from a VNET. 

To start we can run 
```
sh deployInitialInfrastructure.sh
```
 to create the infrastructure. This will create the following resources:
- A VNET 
- App Service with public endpoints turned off and private endpoint into the VNET
- Private DNS settings so that you can use the App Service URL inside the VNET
- An ACI that is inside the VNET which we will use to verify that we can access the App Service from inside the VNET

If you go to the App Service URL from your browser, you will get a unauthorised error. This is because the App Service is only accessible from the VNET.


## Set up self-hosted agent

Ok so as the app service has no public endpoints, you can't use the Microsoft hosted agent to update the app service as there's no line of sight.

What we will need to do is set a self-hosted agent. For that, we'll be deploying a Azure Container Instance (ACI) that is inside the VNET. This self-hosted agent can then be used to deploy the app service.

You can do that by running  
```sh deploySelfHostedAgent.sh```. This will create a a new subnet and deploy the ACI inside that subnet

If you go to the ACI and connect to it, and type in curl [App Service URL], you will get a response from the App Service (the generic website). This is because the ACI is inside the VNET and can access the App Service.

Hopefully you've set up your variables.sh correctly. If you have if you go to DevOps, you should be able to see the agent in the agent pool that you created earlier and it should be online.

Now you can build yaml pipelines and reference that agent pool to deploy to the app service by typing in

```yaml
pool:
  name: SelfHostedAgentPool
```

### Delete everything

run ```sh deleteAll.sh``` to delete everything


