@description('Optional. The collation of the database.')
param collation string

@description('Required. The name of the database.')
param databaseName string

@description('Optional. The tier or edition of the particular SKU.')
param tier string

@description('Required. The name of the SKU.')
param skuName string

@description('Optional. The max size of the database expressed in bytes.')
param maxSizeBytes int

@description('Required. The Name of SQL Server')
param serverName string

@description('Optional. The name of the sample schema to apply when creating this database.')
param sampleName string = ''

@description('Optional. Whether or not this database is zone redundant.')
param zoneRedundant bool = false

@description('Optional. The license type to apply for this database.')
param licenseType string = ''

@description('Optional. The state of read-only routing.')
param readScaleOut string = 'Disabled'

@description('Optional. The number of readonly secondary replicas associated with the database.')
param numberOfReplicas int = 0

@description('Optional. Minimal capacity that database will always have allocated.')
param minCapacity string = ''

@description('Optional. Time in minutes after which database is automatically paused.')
param autoPauseDelay string = ''

@description('Optional. Tags of the resource.')
param tags object = {}

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

@description('Optional. The storage account type to be used to store backups for this database.')
@allowed([
  'Geo'
  'Local'
  'Zone'
  ''
])
param requestedBackupStorageRedundancy string = ''

@description('Optional. Whether or not this database is a ledger database, which means all tables in the database are ledger tables. Note: the value of this property cannot be changed after the database has been created.')
param enableSqlLedger bool = false

@description('Optional. Maintenance configuration id assigned to the database. This configuration defines the period when the maintenance updates will occur.')
param maintenanceConfigurationId string = ''

module pid_cuaId './.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  location: location
  tags: tags
  name: '${serverName}/${databaseName}'
  properties: {
    collation: collation
    maxSizeBytes: maxSizeBytes
    sampleName: sampleName
    zoneRedundant: zoneRedundant
    licenseType: licenseType
    readScale: readScaleOut
    minCapacity: !empty(minCapacity) ? json(minCapacity) : 0
    autoPauseDelay: !empty(autoPauseDelay) ? json(autoPauseDelay) : 0
    highAvailabilityReplicaCount: numberOfReplicas
    requestedBackupStorageRedundancy: any(requestedBackupStorageRedundancy)
    isLedgerOn: enableSqlLedger
    maintenanceConfigurationId: !empty(maintenanceConfigurationId) ? maintenanceConfigurationId : null 
  }
  sku: {
    name: skuName
    tier: tier
  }
}

output databaseName string = databaseName
output databaseResourceGroup string = resourceGroup().name
output serverName string = serverName
