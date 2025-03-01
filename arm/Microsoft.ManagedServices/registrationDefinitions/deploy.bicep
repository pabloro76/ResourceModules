targetScope = 'subscription'

@description('Required. Specify a unique name for your offer/registration. i.e \'<Managing Tenant> - <Remote Tenant> - <ResourceName>\'')
param registrationDefinitionName string

@description('Required. Description of the offer/registration. i.e. \'Managed by <Managing Org Name>\'')
param registrationDescription string

@description('Required. Specify the tenant ID of the tenant which homes the principals you are delegating permissions to.')
param managedByTenantId string

@description('Required. Specify an array of objects, containing object of Azure Active Directory principalId, a Azure roleDefinitionId, and an optional principalIdDisplayName. The roleDefinition specified is granted to the principalId in the provider\'s Active Directory and the principalIdDisplayName is visible to customers.')
param authorizations array

@description('Optional. Specify the name of the Resource Group to delegate access to. If not provided, delegation will be done on the targeted subscription.')
param resourceGroupName string = ''

var registrationId = empty(resourceGroupName) ? guid(managedByTenantId, subscription().tenantId, subscription().subscriptionId) : guid(managedByTenantId, subscription().tenantId, subscription().subscriptionId, resourceGroupName)

resource registrationDefinition 'Microsoft.ManagedServices/registrationDefinitions@2019-09-01' = {
  name: registrationId
  properties: {
    registrationDefinitionName: registrationDefinitionName
    description: registrationDescription
    managedByTenantId: managedByTenantId
    authorizations: authorizations
  }
}

resource registrationAssignment_sub 'Microsoft.ManagedServices/registrationAssignments@2019-09-01' = if (empty(resourceGroupName)) {
  name: registrationId
  properties: {
    registrationDefinitionId: registrationDefinition.id
  }
}

module registrationAssignment_rg '.bicep/nested_registrationAssignment.bicep' = if (!empty(resourceGroupName)) {
  name: 'assignment-${uniqueString(registrationId)}'
  scope: resourceGroup(resourceGroupName)
  params: {
    registrationDefinitionId: registrationDefinition.id
    registrationAssignmentId: registrationId
  }
}

output registrationDefinitionName string = registrationDefinition.name
output registrationDefinitionId string = registrationDefinition.id
output registrationAssignmentId string = empty(resourceGroupName) ? registrationAssignment_sub.id : registrationAssignment_rg.outputs.registrationAssignmentId
