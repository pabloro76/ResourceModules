@description('Required. Remote connection name')
param connectionName string

@description('Required. Specifies a VPN shared key. The same value has to be specified on both Virtual Network Gateways')
param vpnSharedKey string

@description('Required. Specifies the remote Virtual Network Gateway/ExpressRoute')
param remoteEntityName string

@description('Required. Specifies the local Virtual Network Gateway name')
param localVirtualNetworkGatewayName string

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Gateway connection type.')
@allowed([
  'Ipsec'
  'VNet2VNet'
  'ExpressRoute'
  'VPNClient'
])
param virtualNetworkGatewayConnectionType string = 'Ipsec'

@description('Optional. Remote Virtual Network Gateway/ExpressRoute resource group name')
param remoteEntityResourceGroup string = ''

@description('Optional. Remote Virtual Network Gateway/ExpressRoute Subscription Id')
param remoteEntitySubscriptionId string = ''

@description('Optional. Value to specify if BGP is enabled or not')
param enableBgp bool = false

@description('Optional. Enable policy-based traffic selectors')
param usePolicyBasedTrafficSelectors bool = false

@description('Optional. The IPSec Policies to be considered by this connection')
param customIPSecPolicy object = {
  saLifeTimeSeconds: 0
  saDataSizeKilobytes: 0
  ipsecEncryption: ''
  ipsecIntegrity: ''
  ikeEncryption: ''
  ikeIntegrity: ''
  dhGroup: ''
  pfsGroup: ''
}

@description('Optional. The weight added to routes learned from this BGP speaker.')
param routingWeight string = ''

@allowed([
  'CanNotDelete'
  'NotSpecified'
  'ReadOnly'
])
@description('Optional. Specify the type of lock.')
param lock string = 'NotSpecified'

@description('Optional. Tags of the resource.')
param tags object = {}

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

var localVirtualNetworkGatewayId = resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworkGateways', localVirtualNetworkGatewayName)
var remoteEntitySubscriptionId_var = (empty(remoteEntitySubscriptionId) ? subscription().subscriptionId : remoteEntitySubscriptionId)
var remoteEntityResourceGroup_var = (empty(remoteEntityResourceGroup) ? resourceGroup().name : remoteEntityResourceGroup)
var virtualNetworkGateway2Id = {
  id: resourceId(remoteEntitySubscriptionId_var, remoteEntityResourceGroup_var, 'Microsoft.Network/virtualNetworkGateways', remoteEntityName)
}
var localNetworkGateway2Id = {
  id: resourceId(remoteEntitySubscriptionId_var, remoteEntityResourceGroup_var, 'Microsoft.Network/localNetworkGateways', remoteEntityName)
}
var peer = {
  id: resourceId(remoteEntitySubscriptionId_var, remoteEntityResourceGroup_var, 'Microsoft.Network/expressRouteCircuits', remoteEntityName)
}
var customIPSecPolicy_var = [
  {
    saLifeTimeSeconds: customIPSecPolicy.saLifeTimeSeconds
    saDataSizeKilobytes: customIPSecPolicy.saDataSizeKilobytes
    ipsecEncryption: customIPSecPolicy.ipsecEncryption
    ipsecIntegrity: customIPSecPolicy.ipsecIntegrity
    ikeEncryption: customIPSecPolicy.ikeEncryption
    ikeIntegrity: customIPSecPolicy.ikeIntegrity
    dhGroup: customIPSecPolicy.dhGroup
    pfsGroup: customIPSecPolicy.pfsGroup
  }
]

module pid_cuaId './.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource connection 'Microsoft.Network/connections@2021-02-01' = {
  name: connectionName
  location: location
  tags: tags
  properties: {
    virtualNetworkGateway1: {
      id: localVirtualNetworkGatewayId
    }
    virtualNetworkGateway2: ((virtualNetworkGatewayConnectionType == 'VNet2VNet') ? virtualNetworkGateway2Id : json('null'))
    localNetworkGateway2: ((virtualNetworkGatewayConnectionType == 'Ipsec') ? localNetworkGateway2Id : json('null'))
    peer: ((virtualNetworkGatewayConnectionType == 'ExpressRoute') ? peer : json('null'))
    enableBgp: enableBgp
    connectionType: virtualNetworkGatewayConnectionType
    routingWeight: routingWeight
    sharedKey: vpnSharedKey
    usePolicyBasedTrafficSelectors: usePolicyBasedTrafficSelectors
    ipsecPolicies: (empty(customIPSecPolicy.ipsecEncryption) ? customIPSecPolicy.ipsecEncryption : customIPSecPolicy_var)
  }
}

resource connection_lock 'Microsoft.Authorization/locks@2016-09-01' = if (lock != 'NotSpecified') {
  name: '${connection.name}-${lock}-lock'
  properties: {
    level: lock
    notes: (lock == 'CanNotDelete') ? 'Cannot delete resource or child resources.' : 'Cannot modify the resource or child resources.'
  }
  scope: connection
}

output remoteConnectionResourceGroup string = resourceGroup().name
output connectionName string = connection.name
output remoteConnectionResourceId string = connection.id
