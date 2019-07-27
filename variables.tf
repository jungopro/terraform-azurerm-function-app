variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the objects. Changing this forces a new resource to be created"
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}

variable "storage_account_spec" {
  description = "map of key-values for the storage account object. See main.tf for valid keys"
  type        = "map"
  default     = {}
}

variable "service_plan_spec" {
  description = "map of key-values for the service plan object. See main.tf for valid keys"
  type        = "map"
  default     = {}
}

variable "function_app_spec" {
  description = "map of key-values for the function app object. See main.tf for valid keys"
  type        = "map"
  default     = {}
}

variable "application_insights_spec" {
  description = "map of key-values for the application insights object. See main.tf for valid keys"
  type        = "map"
  default     = {}
}
