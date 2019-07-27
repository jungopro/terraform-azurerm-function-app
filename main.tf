locals {
  tags = {
    "terraform managed"   = "true"
    "terraform workspace" = terraform.workspace
  }
}



resource "azurerm_storage_account" "storage_account" {
  name                      = "${substr(format("%ssa", lower(replace("${var.resource_group_name}", "/[[:^alnum:]]/", ""))), 0, 24)}"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = lookup(var.storage_account_spec, "account_tier", "Standard")
  account_replication_type  = lookup(var.storage_account_spec, "account_replication_type", "LRS")
  enable_https_traffic_only = lookup(var.storage_account_spec, "enable_https_traffic_only", false)
  tags                      = local.tags
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.resource_group_name}-${lookup(var.function_app_spec, "name", "function-app")}"
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
/*
resource "azurerm_application_insights" "insights" {
  name                = "${var.resource_group_name}-${var.function_app_name}-insights"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  application_type    = "${var.application_insights_type}"
  tags                = "${var.tags}"
}

resource "azurerm_function_app" "app" {
  name                      = "${var.resource_group_name}-${var.function_app_name}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  app_service_plan_id       = "${azurerm_app_service_plan.plan.id}"
  storage_connection_string = "${azurerm_storage_account.storage_account.primary_connection_string}"
  version                   = "~2"

  app_settings {
    APPINSIGHTS_INSTRUMENTATIONKEY                = "${azurerm_application_insights.insights.instrumentation_key }"
    Auth0ClientId                                 = "${lookup("${var.function_app_settings}", "Auth0ClientId", "")}"
    Auth0Domain                                   = "${lookup("${var.function_app_settings}", "Auth0Domain", "")}"
    KeyVaultUrl                                   = "${lookup("${var.function_app_settings}", "KeyVaultUrl", "")}"
    ProvisioningCertificateName                   = "${lookup("${var.function_app_settings}", "ProvisioningCertificateName", "provisioning-root-certificate")}"
    ProvisioningCertificateSecret                 = "${lookup("${var.function_app_settings}", "ProvisioningCertificateSecret", "")}"
    ProvisioningCertificateIssuerName             = "${lookup("${var.function_app_settings}", "ProvisioningCertificateIssuerName", "CN=www.kornit.com")}"
    ProvisioningCertificateValidityPeriodInMonths = "${lookup("${var.function_app_settings}", "ProvisioningCertificateValidityPeriodInMonths", "36")}"
    StorageConnectionString                       = "${lookup("${var.function_app_settings}", "StorageConnectionString", "")}"
    DpsConnectionString                           = "${lookup("${var.function_app_settings}", "DpsConnectionString", "")}"
    DefaultIotHub                                 = "${lookup("${var.function_app_settings}", "DefaultIotHub", "")}"
    DefaultIotHubConnectionString                 = "${lookup("${var.function_app_settings}", "DefaultIotHubConnectionString", "")}"
    DefaultPortalQueueConnectionString            = "${lookup("${var.function_app_settings}", "DefaultPortalQueueConnectionString", "")}"
    DefaultPortalQueueName                        = "${lookup("${var.function_app_settings}", "DefaultPortalQueueName", "")}"
    DefaultServiceAddress                         = "${lookup("${var.function_app_settings}", "DefaultServiceAddress", "WestUS")}"
    IotMessagesHubConnectionString                = "${lookup("${var.function_app_settings}", "IotMessagesHubConnectionString", "")}"
    IotMessagesHubCheckConnectionEventName        = "${lookup("${var.function_app_settings}", "IotMessagesHubCheckConnectionEventName", "checkconnectionevent")}"
    SiteUpdateQueueName                           = "${lookup("${var.function_app_settings}", "SiteUpdateQueueName", "")}"
    PrinterUpdateQueueName                        = "${lookup("${var.function_app_settings}", "PrinterUpdateQueueName", "")}"
    CustomerUpdateQueueName                       = "${lookup("${var.function_app_settings}", "CustomerUpdateQueueName", "")}"
    ProvisioningToolCompletionQueueName           = "${lookup("${var.function_app_settings}", "ProvisioningToolCompletionQueueName", "")}"
    ProvisioningToolActivationQueueName           = "${lookup("${var.function_app_settings}", "ProvisioningToolActivationQueueName", "")}"
    CustomerDbUpdatesTimerInterval                = "${lookup("${var.function_app_settings}", "CustomerDbUpdatesTimerInterval", "* * 1 * * *")}"
    CustomerDbConnectionString                    = "${lookup("${var.function_app_settings}", "CustomerDbConnectionString", "")}"
    UseAccessTokenWhenDeployed                    = "${lookup("${var.function_app_settings}", "UseAccessTokenWhenDeployed", "true")}"
    SendToQueueVisibilityDelaySec                 = "${lookup("${var.function_app_settings}", "SendToQueueVisibilityDelaySec", "30")}"
    MaxDequeueCount                               = "${lookup("${var.function_app_settings}", "MaxDequeueCount", "3")}"
  }

  tags = "${var.tags}"

  identity {
    type = "SystemAssigned"
  }
}
*/