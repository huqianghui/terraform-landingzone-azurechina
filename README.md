# terraform-landingzone-azurechina

因为一些built-in policy还没有发布到azure china cloud上，包括一些功能的确实，默认的terraform enterprise scale模块会出现错误。如下几个，还有其他的：

│ Error: creating/updating Policy Definition "Deploy-Budget": policy.DefinitionsClient#CreateOrUpdateAtManagementGroup: Failure responding to request: StatusCode=400 -- Original Error: autorest/azure: Service returned an error. Status=400 Code="InvalidPolicyRuleIfNotExistsDetails" Message="The policy definition 'Deploy-Budget' rule is invalid. The policy effect 'type' field references an invalid resource provider 'Microsoft.Consumption'."
│ 
│   with module.enterprise_scale.azurerm_policy_definition.enterprise_scale["/providers/Microsoft.Management/managementGroups/tf-es/providers/Microsoft.Authorization/policyDefinitions/Deploy-Budget"],
│   on .terraform/modules/enterprise_scale/resources.policy_definitions.tf line 1, in resource "azurerm_policy_definition" "enterprise_scale":
│    1: resource "azurerm_policy_definition" "enterprise_scale" {
│ 

.terraform/modules/enterprise_scale/modules/archetypes/lib/policy_assignments/policy_assignment_es_deploy_ws_arc_monitoring.tmpl.json

{
  "name": "Deploy-WS-Arc-Monitoring",
  "type": "Microsoft.Authorization/policyAssignments",
  "apiVersion": "2019-09-01",
  "properties": {
    "description": "Deploys the Log Analytics agent to Windows Azure Arc machines if the agent isn't installed.",
    "displayName": "Deploy-Windows-Arc-Monitoring",
    "notScopes": [],
    "parameters": {
      "logAnalytics": {
        "value": "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/${root_scope_id}-mgmt/providers/Microsoft.OperationalInsights/workspaces/${root_scope_id}-la"
      }
    },
    "policyDefinitionId": "/providers/Microsoft.Authorization/policyDefinitions/69af7d4a-7b18-4044-93a9-2651498ef203",
    "scope": "${current_scope_resource_id}",
    "enforcementMode": null
  },
  "location": "${default_location}",
  "identity": {
    "type": "SystemAssigned"
  }
}

******************************** 还有一些action 和 policy rule错误****************************

基于版本1.1.4把其中的错误都删除了，同时把一些built-in policy转成了 custom policy在root tenant下面。
这样不管single subcription 还是 multi subscription都可以部署成功。
<img width="1399" alt="Screen Shot 2022-04-15 at 12 31 26 PM" src="https://user-images.githubusercontent.com/7360524/163526711-b550e109-2a0e-46a8-bf6a-bacd471dbb56.png">
<img width="1440" alt="Screen Shot 2022-04-15 at 12 30 02 PM" src="https://user-images.githubusercontent.com/7360524/163526724-1124337c-7295-44a2-b086-dd9ccabdd9d2.png">

<img width="1440" alt="Screen Shot 2022-04-15 at 12 31 10 PM" src="https://user-images.githubusercontent.com/7360524/163526735-dd61f157-3dd4-4469-b80a-5b45286571ff.png">
