@description('Required. The name of Cognitive Services account')
param accountName string

@description('Required. Kind of the Cognitive Services. Use \'Get-AzCognitiveServicesAccountSku\' to determine a valid combinations of \'kind\' and \'sku\' for your Azure region.')
@allowed([
  'AnomalyDetector'
  'Bing.Autosuggest.v7'
  'Bing.CustomSearch'
  'Bing.EntitySearch'
  'Bing.Search.v7'
  'Bing.SpellCheck.v7'
  'CognitiveServices'
  'ComputerVision'
  'ContentModerator'
  'CustomVision.Prediction'
  'CustomVision.Training'
  'Face'
  'FormRecognizer'
  'ImmersiveReader'
  'Internal.AllInOne'
  'LUIS'
  'LUIS.Authoring'
  'Personalizer'
  'QnAMaker'
  'SpeechServices'
  'TextAnalytics'
  'TextTranslation'
])
param kind string

@description('Optional. SKU of the Cognitive Services resource. Use \'Get-AzCognitiveServicesAccountSku\' to determine a valid combinations of \'kind\' and \'sku\' for your Azure region.')
@allowed([
  'C2'
  'C3'
  'C4'
  'F0'
  'F1'
  'S'
  'S0'
  'S1'
  'S10'
  'S2'
  'S3'
  'S4'
  'S5'
  'S6'
  'S7'
  'S8'
  'S9'
])
param sku string = 'S0'

@description('Optional. Location for all Resources.')
param location string = resourceGroup().location

@description('Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.')
@minValue(0)
@maxValue(365)
param diagnosticLogsRetentionInDays int = 365

@description('Optional. Resource identifier of the Diagnostic Storage Account.')
param diagnosticStorageAccountId string = ''

@description('Optional. Resource identifier of Log Analytics.')
param workspaceId string = ''

@description('Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.')
param eventHubAuthorizationRuleId string = ''

@description('Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.')
param eventHubName string = ''

@description('Optional. Subdomain name used for token-based authentication. Required if \'networkAcls\' are set.')
param customSubDomainName string = ''

@description('Optional. Subdomain name used for token-based authentication. Must be set if \'networkAcls\' are set.')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'

@description('Optional. Service endpoint object information')
param networkAcls object = {}

@description('Optional. Type of managed service identity.')
@allowed([
  'None'
  'SystemAssigned'
])
param managedIdentity string = 'None'

@allowed([
  'CanNotDelete'
  'NotSpecified'
  'ReadOnly'
])
@description('Optional. Specify the type of lock.')
param lock string = 'NotSpecified'

@description('Optional. Configuration Details for private endpoints.')
param privateEndpoints array = []

@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'')
param roleAssignments array = []

@description('Optional. Tags of the resource.')
param tags object = {}

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

var diagnosticsMetrics = [
  {
    category: 'AllMetrics'
    timeGrain: null
    enabled: true
    retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
    }
  }
]
var diagnosticsLogs = [
  {
    category: 'Audit'
    enabled: true
    retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
    }
  }
  {
    category: 'RequestResponse'
    enabled: true
    retentionPolicy: {
      enabled: true
      days: diagnosticLogsRetentionInDays
    }
  }
]
var builtInRoleNames = {
  'Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  'Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  'Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  'Azure Service Deploy Release Management Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '21d96096-b162-414a-8302-d8354f9d91b2')
  'Cognitive Services Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '25fbc0a9-bd7c-42a3-aa1a-3b75d497ee68')
  'Cognitive Services Custom Vision Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c1ff6cc2-c111-46fe-8896-e0ef812ad9f3')
  'Cognitive Services Custom Vision Deployment': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5c4089e1-6d96-4d2f-b296-c1bc7137275f')
  'Cognitive Services Custom Vision Labeler': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '88424f51-ebe7-446f-bc41-7fa16989e96c')
  'Cognitive Services Custom Vision Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '93586559-c37d-4a6b-ba08-b9f0940c2d73')
  'Cognitive Services Custom Vision Trainer': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '0a5ae4ab-0d65-4eeb-be61-29fc9b54394b')
  'Cognitive Services Data Reader (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b59867f0-fa02-499b-be73-45a86b5b3e1c')
  'Cognitive Services Face Recognizer': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '9894cab4-e18a-44aa-828b-cb588cd6f2d7')
  'Cognitive Services Metrics Advisor Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'cb43c632-a144-4ec5-977c-e80c4affc34a')
  'Cognitive Services Metrics Advisor User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3b20f47b-3825-43cb-8114-4bd2201156a8')
  'Cognitive Services QnA Maker Editor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f4cc2bf9-21be-47a1-bdf1-5c5804381025')
  'Cognitive Services QnA Maker Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '466ccd10-b268-4a11-b098-b4849f024126')
  'Cognitive Services Speech Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '0e75ca1e-0464-4b4d-8b93-68208a576181')
  'Cognitive Services Speech User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f2dc8367-1007-4938-bd23-fe263f013447')
  'Cognitive Services User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a97b65f3-24c7-4388-baec-2e87135dc908')
  'Log Analytics Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '92aaf0da-9dab-42b6-94a3-d43ce8d16293')
  'Log Analytics Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '73c42c96-874c-492b-b04d-ab87d138a893')
  'Managed Application Contributor Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '641177b8-a67a-45b9-a033-47bc880bb21e')
  'Managed Application Operator Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c7393b34-138c-406f-901b-d8cf2b17e6ae')
  'Managed Applications Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b9331d33-8a36-4f8c-b097-4f54124fdb44')
  'masterreader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a48d7796-14b4-4889-afef-fbb65a93e5a2')
  'Monitoring Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '749f88d5-cbae-40b8-bcfc-e573ddc772fa')
  'Monitoring Metrics Publisher': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')
  'Monitoring Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '43d0d8ad-25c7-4714-9337-8ba259a9fe05')
  'Resource Policy Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '36243c78-bf99-498c-9df9-86d9f8d28608')
  'User Access Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9')
}
var networkAcls_var = {
  defaultAction: ((empty(networkAcls)) ? json('null') : networkAcls.defaultAction)
  virtualNetworkRules: ((empty(networkAcls)) ? json('null') : ((length(networkAcls.virtualNetworkRules) == 0) ? [] : networkAcls.virtualNetworkRules))
  ipRules: ((empty(networkAcls)) ? json('null') : ((length(networkAcls.ipRules) == 0) ? [] : networkAcls.ipRules))
}

module pid_cuaId './.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource cognitiveServices 'Microsoft.CognitiveServices/accounts@2017-04-18' = {
  name: accountName
  kind: kind
  identity: {
    type: managedIdentity
  }
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    customSubDomainName: (empty(customSubDomainName) ? json('null') : customSubDomainName)
    networkAcls: ((empty(networkAcls)) ? json('null') : networkAcls_var)
    publicNetworkAccess: publicNetworkAccess
  }
}

resource cognitiveServices_lock 'Microsoft.Authorization/locks@2016-09-01' = if (lock != 'NotSpecified') {
  name: '${cognitiveServices.name}-${lock}-lock'
  properties: {
    level: lock
    notes: (lock == 'CanNotDelete') ? 'Cannot delete resource or child resources.' : 'Cannot modify the resource or child resources.'
  }
  scope: cognitiveServices
}

resource cognitiveServices_diagnosticSettingName 'Microsoft.Insights/diagnosticsettings@2017-05-01-preview' = {
  name: '${cognitiveServices.name}-diagnosticSettings'
  properties: {
    storageAccountId: (empty(diagnosticStorageAccountId) ? json('null') : diagnosticStorageAccountId)
    workspaceId: (empty(workspaceId) ? json('null') : workspaceId)
    eventHubAuthorizationRuleId: (empty(eventHubAuthorizationRuleId) ? json('null') : eventHubAuthorizationRuleId)
    eventHubName: (empty(eventHubName) ? json('null') : eventHubName)
    metrics: ((empty(diagnosticStorageAccountId) && empty(workspaceId) && empty(eventHubAuthorizationRuleId) && empty(eventHubName)) ? json('null') : diagnosticsMetrics)
    logs: ((empty(diagnosticStorageAccountId) && empty(workspaceId) && empty(eventHubAuthorizationRuleId) && empty(eventHubName)) ? json('null') : diagnosticsLogs)
  }
  scope: cognitiveServices
}

module cognitiveServices_privateEndpoints './.bicep/nested_privateEndpoints.bicep' = [for privateEndpoint in privateEndpoints: {
  name: '${uniqueString(deployment().name, privateEndpoint.name)}-privateEndpoint'
  params: {
    privateEndpointResourceId: cognitiveServices.id
    privateEndpointVnetLocation: (empty(privateEndpoints) ? 'dummy' : reference(split(privateEndpoint.subnetResourceId, '/subnets/')[0], '2020-06-01', 'Full').location)
    privateEndpoint: privateEndpoint
    tags: tags
  }
}]

module cognitiveServices_rbac './.bicep/nested_rbac.bicep' = [for (roleAssignment, index) in roleAssignments: {
  name: 'rbac-${deployment().name}${index}'
  params: {
    roleAssignmentObj: roleAssignment
    builtInRoleNames: builtInRoleNames
    resourceName: cognitiveServices.name
  }
}]

output cognitiveServicesName string = cognitiveServices.name
output cognitiveServicesResourceId string = cognitiveServices.id
output cognitiveServicesResourceGroup string = resourceGroup().name
output cognitiveServicesEndpoint string = cognitiveServices.properties.endpoint
output principalId string = cognitiveServices.identity.principalId
