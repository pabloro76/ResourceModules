param roleAssignmentObj object
param builtInRoleNames object
param parentResourceName string
param resourceName string

resource roleAssigment 'Microsoft.ServiceBus/namespaces/providers/queues/roleAssignments@2020-04-01-preview' = [for principalId in roleAssignmentObj.principalIds: {
  name: '${parentResourceName}/${resourceName}/Microsoft.Authorization/${guid(resourceName, principalId, roleAssignmentObj.roleDefinitionIdOrName)}'
  properties: {
    roleDefinitionId: (contains(builtInRoleNames, roleAssignmentObj.roleDefinitionIdOrName) ? builtInRoleNames[roleAssignmentObj.roleDefinitionIdOrName] : roleAssignmentObj.roleDefinitionIdOrName)
    principalId: principalId
  }
}]
