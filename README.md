# RazDevCenter
This repo contains my Microsoft Dev Center experimentations.


## Microsoft Dev Box

- `/devbox-customization`: contains `.yaml` customization files that can be used for provisioning Dev Boxes.
- `/task-catalog`: contains the tasks that the customization files can use  


## Azure Deployment Environments (ADE)

- `/general-environment-catalog`: contains IaC templates for provisioning generic Azure resources
- `/project-environment-calatog`: contains IaC templates for provisioning project-specific Azure resources (usually the template of an `azd` project)

### Bicep to ARM Templates
ADE by default only supports ARM Templates or Terraform. To generate an ARM template from a Bicep file, run the following command

```
az bicep build --file PATH_TO_FILE/main.bicep --outfile project-environment-catalog/eshop-project-environment/azuredeploy.json
```

To make this easier, GitHub actions in `/.github/workflows` are created to auto-generate ARM templates when any `*.bicep` files change.
This will recreate an `azuredeploy.json` file.

### Environment.YAML
ADE requires an `environment.yaml` file to specify the name and parameters required for the environment.
After the `azuredeploy.json` file is created, use GitHub Copilot to generate the `environment.yaml` file.