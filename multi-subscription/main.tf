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
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
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
  subscription_id_management = var.managementSubscriptionId
  configure_management_resources = local.configure_management_resources

  # step 3) identity policy to identity management group( no resource)
  deploy_identity_resources    = true
  subscription_id_identity     = var.identitySubscriptionId
  configure_identity_resources = local.configure_identity_resources

  # step 4) connectivity resource (hub & spoke topoly, firewall,gateway,dns,ddos)
  deploy_connectivity_resources    = true
  subscription_id_connectivity     = var.connectivitySubscriptionId
  configure_connectivity_resources = local.configure_connectivity_resources

  # step 5) landing zones deployment 
  deploy_corp_landing_zones = true
  deploy_online_landing_zones = true

  # step 6) deploy customize landing zones
  custom_landing_zones = {
    "${var.root_id}-cncustomers" = {
      display_name               = "${upper(var.root_id)} CnCustomers"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = ["ddbda02a-f62c-4122-88eb-cf31d772cc1f","55e756f4-3a21-4b0a-88c3-ae4ff3fe912f"]
      archetype_config = {
        archetype_id   = "cn_customer"
        parameters     = {}
        access_control = {}
      }
    }
  }

  # step 7) move subscription and deploy sap landing zone
  deploy_sap_landing_zones = true
  subscription_id_overrides = {
    sandboxes = ["cc2fb595-1a97-4bc0-b33e-8955f43d1b05"]
    sap = ["60a43a8b-348b-4e0f-a5d7-eff5f5f72125"]
    #management = []
    #root = []
  }

}

