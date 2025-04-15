# RazDevCenter
This repo contains my Microsoft Dev Center experimentations.


## Microsoft Dev Box

- `/devbox-customization`: contains `.yaml` customization files that can be used for provisioning Dev Boxes.
- `/task-catalog`: contains the tasks that the customization files can use  


## Azure Deployment Environments

- `/general-environment-catalog`: contains IaC templates for provisioning generic Azure resources
- `/project-environment-calatog`: contains IaC templates for provisioning project-specific Azure resources (usually the template of an `azd` project)

> [!NOTE]
> Azure Deployment Environment by default only supports ARM Templates
> - To generate ARM from a Bicep template, run `az bicep build --file project-environment-catalog/eshop-project-environment/main.bicep --outfile project-environment-catalog/eshop-project-environment/azuredeploy.json` (change file path as needed)
> - To support Terraform or Pulumi, see [ADE Extension Model](https://learn.microsoft.com/en-us/azure/deployment-environments/concept-extensibility-model)