targetScope = 'subscription'

@description('Required. The full Azure ID of the workspace to save the data in.')
param workspaceId string

@description('Required. All the VMs in this scope will send their security data to the mentioned workspace unless overridden by a setting with more specific scope.')
param scope string

@description('Optional. Describes what kind of security agent provisioning action to take. - On or Off')
@allowed([
  'On'
  'Off'
])
param autoProvision string = 'On'

@description('Optional. Indicates whether Advanced Threat Protection is enabled.')
param enableAtp bool = false

@description('Optional. Device Security group data')
param deviceSecurityGroupProperties object = {}

@description('Optional. Security Solution data')
param ioTSecuritySolutionProperties object = {}

@description('Optional. The pricing tier value for VMs. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param virtualMachinesPricingTier string = 'Free'

@description('Optional. The pricing tier value for SqlServers. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param sqlServersPricingTier string = 'Free'

@description('Optional. The pricing tier value for AppServices. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param appServicesPricingTier string = 'Free'

@description('Optional. The pricing tier value for StorageAccounts. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param storageAccountsPricingTier string = 'Free'

@description('Optional. The pricing tier value for SqlServerVirtualMachines. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param sqlServerVirtualMachinesPricingTier string = 'Free'

@description('Optional. The pricing tier value for KubernetesService. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param kubernetesServicePricingTier string = 'Free'

@description('Optional. The pricing tier value for ContainerRegistry. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param containerRegistryPricingTier string = 'Free'

@description('Optional. The pricing tier value for KeyVaults. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param keyVaultsPricingTier string = 'Free'

@description('Optional. The pricing tier value for DNS. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param dnsPricingTier string = 'Free'

@description('Optional. The pricing tier value for ARM. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param armPricingTier string = 'Free'

@description('Optional. The pricing tier value for OpenSourceRelationalDatabases. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard')
@allowed([
  'Free'
  'Standard'
])
param openSourceRelationalDatabasesTier string = 'Free'

@description('Optional. Security contact data')
param securityContactProperties object = {}

resource advancedThreatProtectionSettings 'Microsoft.Security/advancedThreatProtectionSettings@2019-01-01' = {
  name: 'current'
  properties: {
    isEnabled: enableAtp
  }
}

resource autoProvisioningSettings 'Microsoft.Security/autoProvisioningSettings@2017-08-01-preview' = {
  name: 'autoProvisioningSettings'
  properties: {
    autoProvision: autoProvision
  }
}

resource deviceSecurityGroups 'Microsoft.Security/deviceSecurityGroups@2019-08-01' = if (!empty(deviceSecurityGroupProperties)) {
  name: 'deviceSecurityGroups'
  properties: {
    thresholdRules: deviceSecurityGroupProperties.thresholdRules
    timeWindowRules: deviceSecurityGroupProperties.timeWindowRules
    allowlistRules: deviceSecurityGroupProperties.allowlistRules
    denylistRules: deviceSecurityGroupProperties.denylistRules
  }
}

module iotSecuritySolutions './.bicep/nested_iotSecuritySolutions.bicep' = if (!empty(ioTSecuritySolutionProperties)) {
  name: '${uniqueString(deployment().name)}-ASC-IotSecuritySolutions'
  scope: resourceGroup(empty(ioTSecuritySolutionProperties) ? 'dummy' : ioTSecuritySolutionProperties.resourceGroup)
  params: {
    ioTSecuritySolutionProperties: ioTSecuritySolutionProperties
  }
}

resource VirtualMachinesPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'VirtualMachinesPricingTier'
  properties: {
    pricingTier: virtualMachinesPricingTier
  }
}

resource SqlServersPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'SqlServersPricingTier'
  properties: {
    pricingTier: sqlServersPricingTier
  }
}

resource AppServicesPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'AppServicesPricingTier'
  properties: {
    pricingTier: appServicesPricingTier
  }
}

resource StorageAccountsPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'StorageAccountsPricingTier'
  properties: {
    pricingTier: storageAccountsPricingTier
  }
}

resource SqlServerVirtualMachinesPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'SqlServerVirtualMachinesPricingTier'
  properties: {
    pricingTier: sqlServerVirtualMachinesPricingTier
  }
}

resource KubernetesServicePricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'KubernetesServicePricingTier'
  properties: {
    pricingTier: kubernetesServicePricingTier
  }
}

resource ContainerRegistryPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'ContainerRegistryPricingTier'
  properties: {
    pricingTier: containerRegistryPricingTier
  }
}

resource KeyVaultsPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'KeyVaultsPricingTier'
  properties: {
    pricingTier: keyVaultsPricingTier
  }
}

resource DnsPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'DnsPricingTier'
  properties: {
    pricingTier: dnsPricingTier
  }
}

resource ArmPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'ArmPricingTier'
  properties: {
    pricingTier: armPricingTier
  }
}

resource OpenSourceRelationalDatabasesPricingTier 'Microsoft.Security/pricings@2018-06-01' = {
  name: 'OpenSourceRelationalDatabasesPricingTier'
  properties: {
    pricingTier: openSourceRelationalDatabasesTier
  }
}

resource securityContacts 'Microsoft.Security/securityContacts@2017-08-01-preview' = if (!empty(securityContactProperties)) {
  name: 'securityContacts'
  properties: {
    email: securityContactProperties.email
    phone: securityContactProperties.phone
    alertNotifications: securityContactProperties.alertNotifications
    alertsToAdmins: securityContactProperties.alertsToAdmins
  }
}

resource workspaceSettings 'Microsoft.Security/workspaceSettings@2017-08-01-preview' = {
  name: 'workspaceSettings'
  properties: {
    workspaceId: workspaceId
    scope: scope
  }
  dependsOn: [
    autoProvisioningSettings
  ]
}

output workspaceId string = workspaceId
