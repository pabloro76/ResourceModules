@description('Optional. The Name of Vnet Peering resource. If not provided, default value will be localVnetName-remoteVnetName')
param peeringName string = '${localVnetName}-${last(split(remoteVirtualNetworkId, '/'))}'

@description('Required. The Name of the Virtual Network to add the peering to.')
param localVnetName string

@description('Required. The Resource ID of the VNet that is this Local VNet is being peered to. Should be in the format of a Resource ID')
param remoteVirtualNetworkId string

@description('Optional. Whether the forwarded traffic from the VMs in the local virtual network will be allowed/disallowed in remote virtual network. Default is true')
param allowForwardedTraffic bool = true

@description('Optional. If gateway links can be used in remote virtual networking to link to this virtual network. Default is false')
param allowGatewayTransit bool = false

@description('Optional. Whether the VMs in the local virtual network space would be able to access the VMs in remote virtual network space. Default is true')
param allowVirtualNetworkAccess bool = true

@description('Optional. If we need to verify the provisioning state of the remote gateway. Default is true')
param doNotVerifyRemoteGateways bool = true

@description('Optional. If remote gateways can be used on this virtual network. If the flag is set to true, and allowGatewayTransit on remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. Default is false')
param useRemoteGateways bool = false

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

module pid_cuaId './.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource virtualNetworkPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-02-01' = {
  name: '${localVnetName}/${peeringName}'
  properties: {
    allowForwardedTraffic: allowForwardedTraffic
    allowGatewayTransit: allowGatewayTransit
    allowVirtualNetworkAccess: allowVirtualNetworkAccess
    doNotVerifyRemoteGateways: doNotVerifyRemoteGateways
    useRemoteGateways: useRemoteGateways
    remoteVirtualNetwork: {
      id: remoteVirtualNetworkId
    }
  }
}

output virtualNetworkPeeringResourceGroup string = resourceGroup().name
output virtualNetworkPeeringName string = virtualNetworkPeering.name
output virtualNetworkPeeringResourceId string = virtualNetworkPeering.id
