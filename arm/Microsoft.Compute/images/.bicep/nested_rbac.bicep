param roleAssignmentObj object
param builtInRoleNames object
param resourceName string

resource roleAssigment 'Microsoft.Compute/images/providers/roleAssignments@2018-09-01-preview' = [for principalId in roleAssignmentObj.principalIds: {
  name: '${resourceName}/Microsoft.Authorization/${guid(resourceName, principalId, roleAssignmentObj.roleDefinitionIdOrName)}'
  properties: {
    roleDefinitionId: (contains(builtInRoleNames, roleAssignmentObj.roleDefinitionIdOrName) ? builtInRoleNames[roleAssignmentObj.roleDefinitionIdOrName] : roleAssignmentObj.roleDefinitionIdOrName)
    principalId: principalId
  }
}]
