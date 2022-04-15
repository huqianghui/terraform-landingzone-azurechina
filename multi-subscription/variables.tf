variable "root_id" {
  type    = string
  default = "tf-es"
}

variable "root_name" {
  type    = string
  default = "tf-Enterprise-Scale"
}

variable "primary_location" {
  type = string
  default = "chinanorth3"
}

variable "default_location" {
  type        = string
  description = "If specified, will set the Azure region in which region bound resources will be deployed. Please see: https://azure.microsoft.com/en-gb/global-infrastructure/geographies/"
  default     = "chinanorth3"
}

variable "location" {
  type        = string
  description = "Sets the default location used for resource deployments where needed."
  default     = "chinanorth3"
}

variable "management_resources_location" {  
type    = string  
default = "chinaeast2"
}

variable "management_resources_tags" {  
type = map(string)  
default = {    
BelongsTo = "management"
GenerateBy = "terraform-eslz"	  
}
} 

variable "log_retention_in_days" {
  type    = number
  default = 90
}

variable "security_alerts_email_address" {
  type    = string
  default = "qiah@microsoft.com" 
}

variable "connectivity_resources_location" {
  type    = string
  default = "chinanorth3"
}

variable "connectivity_resources_tags" {
  type = map(string)
  default = {
    BelongsTo = "Connectivity"
    GenerateBy = "terraform-eslz"
  }
}

variable "managementSubscriptionId" {
  type    = string
  default = "d8cabd94-45e2-4dfc-844d-21981127fe08"
}

variable "connectivitySubscriptionId" {
  type    = string
  default = "d47ca95a-ba37-4fa3-95f5-f7dd75b919f6"
}

variable "identitySubscriptionId" {
  type    = string
  default = "e7df11e1-9298-4961-8cb1-ceb123683d34"
}

variable "sandboxSubscriptionId" {
  type    = string
  default = "cc2fb595-1a97-4bc0-b33e-8955f43d1b05"
}

variable "cnlzSubscriptionId" {
  type    = string
  default = "60a43a8b-348b-4e0f-a5d7-eff5f5f72125"
}


