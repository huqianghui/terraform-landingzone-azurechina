# Get the current client configuration from the AzureRM provider.
# This is used to populate the root_parent_id variable with the
# current Tenant ID used as the ID for the "Tenant Root Group"
# Management Group.

data "azurerm_client_config" "core" {}

# Declare the Terraform Module for Cloud Adoption Framework
# Enterprise-scale and provide a base configuration.

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "1.1.4"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
   }
  
  default_location = var.default_location
  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name
  library_path   = "${path.root}/lib"
  # step1) deploy core (management group,policy)
  deploy_core_landing_zones = true

  # step 2) deploy management resource(log analytics, security center,sentinel)
  deploy_management_resources = true
  subscription_id_management = data.azurerm_client_config.core.subscription_id
  configure_management_resources = local.configure_management_resources

  # step 3) identity policy to identity management group( no resource)
  deploy_identity_resources    = true
  subscription_id_identity     = data.azurerm_client_config.core.subscription_id
  configure_identity_resources = local.configure_identity_resources

  # step 4) connectivity resource (hub & spoke topoly, firewall,gateway,dns,ddos)
  deploy_connectivity_resources    = true
  subscription_id_connectivity     = data.azurerm_client_config.core.subscription_id
  configure_connectivity_resources = local.configure_connectivity_resources

  # step 5) landing zones deployment 
  deploy_corp_landing_zones = true
  deploy_online_landing_zones = true

  # step 6) deploy customize landing zones
  custom_landing_zones = {
    "${var.root_id}-cncustomers" = {
      display_name               = "${upper(var.root_id)} CnCustomers"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = ["d47ca95a-ba37-4fa3-95f5-f7dd75b919f6"]
      archetype_config = {
        archetype_id   = "cn_customer"
        parameters     = {}
        access_control = {}
      }
    }
  }

}

