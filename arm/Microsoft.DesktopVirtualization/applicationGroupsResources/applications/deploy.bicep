@minLength(1)
@description('Required. List of applications to be created in the Application Group.')
param applications array

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@minLength(1)
@description('Required. Name of the Application Group to create the application(s) in.')
param appGroupName string

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

module pid_cuaId './.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource applications_res 'Microsoft.DesktopVirtualization/applicationGroups/applications@2021-07-12' = [for application in applications: {
  name: '${appGroupName}/${application.name}'
  properties: {
    description: application.description
    friendlyName: application.friendlyName
    filePath: application.filePath
    commandLineSetting: application.commandLineSetting
    commandLineArguments: application.commandLineArguments
    showInPortal: application.showInPortal
    iconPath: application.iconPath
    iconIndex: application.iconIndex
  }
}]

output applicationResourceIds array = [for i in range(0, length(applications)): applications_res[i].id]
output applicationResourceGroup string = resourceGroup().name
output appGroupName string = appGroupName
