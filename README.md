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