# terraform-azurerm-function-app
Terraform Module to create a function app with a storage account and application insights

## Prerequisites

- A resource group must pre-exist and the name and location should be passed (e.g. using `terraform apply -var resource_group_name=myrg -var location=westeurope`)

## Objects

This module will create the following objects:

- Storage account to be used as a backend for the function app
- App service plan
- Application Insights
- Function App with MSI

## Modifications

Each resource have it's own defaults and a corresponding `map` variable that can be used to pass the different values to the resource

For example, to modify the default runtime stack of the `azurerm_function_app.app` object to `powershell`, create a `terraform.tfvars` file and set the following values:

```json
function_app_spec = {
  runtime_stack = "powershell"
}
```

## Service Plan Note

By default, a *consumption service plan* will get created with the following specs:

|  Tier   | Size  | Capacity |
| :-----: | :---: | :------: |
| Dynamic |  Y1   |    0     |
