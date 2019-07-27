# terraform-azurerm-function-app
Terraform Module to create a function app with a storage account and application insights

## Service Plan Note

By default, a *consumption service plan* will get created with the following specs:

| Tier    | Size | Capacity |
| ------- | ---- | -------- |
| Dynamic | Y1   | 0        |

To override the defaults, add your inputs to the `service_plan_spec` map variable like so:

```
service_plan_spec = {
  tier = "Standard"
  size = "S1"
  capacity = "3"
}