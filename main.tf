locals {
  tags = {
    "terraform managed"   = "true"
    "terraform workspace" = terraform.workspace
  }
}



resource "azurerm_storage_account" "storage_account" {
  name                      = "${substr(format("%ssa", lower(replace("${var.resource_group_name}${lookup(var.function_app_spec, "name", "function-app")}", "/[[:^alnum:]]/", ""))), 0, 24)}"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = lookup(var.storage_account_spec, "account_tier", "Standard")
  account_replication_type  = lookup(var.storage_account_spec, "account_replication_type", "LRS")
  enable_https_traffic_only = lookup(var.storage_account_spec, "enable_https_traffic_only", false)
  tags                      = local.tags
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.resource_group_name}-${lookup(var.function_app_spec, "name", "function-app")}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = lookup(var.service_plan_spec, "kind", "FunctionApp")
  tags                = local.tags

  sku {
    tier     = lookup(var.service_plan_spec, "tier", "Dynamic")
    size     = lookup(var.service_plan_spec, "size", "Y1")
    capacity = lookup(var.service_plan_spec, "capacity", 0)
  }
}

resource "azurerm_application_insights" "insights" {
  name                = "${var.resource_group_name}-${lookup(var.function_app_spec, "name", "function-app")}-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = lookup(var.application_insights_spec, "application_type", "other")
  tags                = local.tags
}

resource "azurerm_function_app" "app" {
  name                      = "${var.resource_group_name}-${lookup(var.function_app_spec, "name", "function-app")}"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  app_service_plan_id       = azurerm_app_service_plan.plan.id
  storage_connection_string = azurerm_storage_account.storage_account.primary_connection_string
  version                   = lookup(var.function_app_spec, "runtime_version", "~2")
  tags                      = local.tags

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.insights.instrumentation_key
    FUNCTIONS_WORKER_RUNTIME       = lookup(var.function_app_spec, "runtime_stack", "dotnet")
  }
}
