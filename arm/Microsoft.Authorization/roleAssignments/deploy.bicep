targetScope = 'managementGroup'

@description('Required. You can provide either the display name of the role definition, or it\'s fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'')
param roleDefinitionIdOrName string

@description('Required. The Principal or Object ID of the Security Principal (User, Group, Service Principal, Managed Identity)')
param principalId string

@description('Optional. Name of the Resource Group to assign the RBAC role to. If no Resource Group name is provided, and Subscription ID is provided, the module deploys at subscription level, therefore assigns the provided RBAC role to the subscription.')
param resourceGroupName string = ''

@description('Optional. ID of the Subscription to assign the RBAC role to. If no Resource Group name is provided, the module deploys at subscription level, therefore assigns the provided RBAC role to the subscription.')
param subscriptionId string = ''

@description('Optional. ID of the Management Group to assign the RBAC role to. If no Subscription is provided, the module deploys at management group level, therefore assigns the provided RBAC role to the management group.')
param managementGroupId string = ''

@description('Optional. Location for all resources.')
param location string = deployment().location

module roleAssignment_mg './.bicep/nested_rbac_mg.bicep' = if (!empty(managementGroupId) && empty(subscriptionId) && empty(resourceGroupName)) {
  name: 'roleAssignment-mg-${guid(roleDefinitionIdOrName,principalId)}'
  scope: managementGroup(managementGroupId)
  params: {
    roleDefinitionIdOrName: roleDefinitionIdOrName
    principalId: principalId
    managementGroupId: managementGroupId
    location: location
  }
}

module roleAssignment_sub './.bicep/nested_rbac_sub.bicep' = if (empty(managementGroupId) && !empty(subscriptionId) && empty(resourceGroupName)) {
  name: 'roleAssignment-sub-${guid(roleDefinitionIdOrName,principalId)}'
  scope: subscription(subscriptionId)
  params: {
    roleDefinitionIdOrName: roleDefinitionIdOrName
    principalId: principalId
    subscriptionId: subscriptionId
    location: location
  }
}

module roleAssignment_rg './.bicep/nested_rbac_rg.bicep' = if (empty(managementGroupId) && !empty(resourceGroupName) && !empty(subscriptionId)) {
  name: 'roleAssignment-${guid(roleDefinitionIdOrName,principalId)}'
  scope: resourceGroup(subscriptionId, resourceGroupName)
  params: {
    roleDefinitionIdOrName: roleDefinitionIdOrName
    principalId: principalId
    subscriptionId: subscriptionId
    resourceGroupName: resourceGroupName
    location: location
  }
}

output roleAssignmentName string = !empty(managementGroupId) ? roleAssignment_mg.outputs.roleAssignmentName : (!empty(resourceGroupName) ? roleAssignment_rg.outputs.roleAssignmentName : roleAssignment_sub.outputs.roleAssignmentName)
output roleAssignmentId string = !empty(managementGroupId) ? roleAssignment_mg.outputs.roleAssignmentId : (!empty(resourceGroupName) ? roleAssignment_rg.outputs.roleAssignmentId : roleAssignment_sub.outputs.roleAssignmentId)
output roleAssignmentScope string = !empty(managementGroupId) ? roleAssignment_mg.outputs.roleAssignmentScope : (!empty(resourceGroupName) ? roleAssignment_rg.outputs.roleAssignmentScope : roleAssignment_sub.outputs.roleAssignmentScope)
