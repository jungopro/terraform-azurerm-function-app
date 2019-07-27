variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created"
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}

variable "storage_account_spec" {
  description = "map of key-values for the storage account object"
  type        = "map"
  default     = {}
}

variable "service_plan_spec" {
  description = "map of key-values for the service plan object"
  type        = "map"
  default     = {}
}

variable "function_app_spec" {
  description = "map of key-values for the function app object"
  type        = "map"
  default     = {}
}

/*variable "service_plan_kind" {
  description = "The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux and FunctionApp (for a Consumption Plan). Defaults to Windows. Changing this forces a new resource to be created"
}

variable "service_plan_sku" {
  description = "A sku block as documented in https://www.terraform.io/docs/providers/azurerm/r/app_service_plan.html#sku"
  type = "map"
}

variable "function_app_name" {
  description = "Specifies the name of the Function App. Changing this forces a new resource to be created"
}

variable "function_app_settings" {
  description = "A key-value pair of App Settings."
  type        = "map"
  default = {}
}

variable "application_insights_type" {
  description = " Specifies the type of Application Insights to create. Valid values are Java, iOS, MobileCenter, Other, Phone, Store, Web and Node.JS"
}

variable "enable_https" {
  description = "enable https on the storage account"
  default = false
}*/

