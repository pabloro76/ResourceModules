param roleAssignmentObj object
param builtInRoleNames object
param resourceName string

resource roleAssignment 'Microsoft.Storage/storageAccounts/blobServices/containers/providers/roleAssignments@2020-04-01-preview' = [for principalId in roleAssignmentObj.principalIds: {
  name: '${resourceName}/Microsoft.Authorization/${(empty(roleAssignmentObj) ? guid(resourceName) : guid(resourceName, principalId, roleAssignmentObj.roleDefinitionIdOrName))}'
  properties: {
    roleDefinitionId: contains(builtInRoleNames, roleAssignmentObj.roleDefinitionIdOrName) ? builtInRoleNames[roleAssignmentObj.roleDefinitionIdOrName] : roleAssignmentObj.roleDefinitionIdOrName
    principalId: principalId
  }
}]
