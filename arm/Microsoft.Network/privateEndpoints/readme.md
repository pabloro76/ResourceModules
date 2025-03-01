# PrivateEndpoints

# Resource

This template deploys private Endpoint for a generic service.

## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.Resources/deployments`| 2020-10-01 |
| `Microsoft.Network/privateEndpoints` | 2021-02-01 |
| `Microsoft.Network/privateEndpoints/privateDnsZoneGroups` | 2021-02-01 |
| `Microsoft.Network/privateEndpoints/providers/roleAssignments` | 2018-09-01-preview |
| `Microsoft.Authorization/locks` | 2016-09-01 |

### Resource dependency

The following resources are required to be able to deploy this resource:
- PrivateDNSZone
- VirtualNetwork/subnet
- The service that needs to be connected through private endpoint

**Important**: Destination subnet must be created with the following configuration option - `"privateEndpointNetworkPolicies": "Disabled"`.  Setting this option acknowledges that NSG rules are not applied to Private Endpoints (this capability is coming soon).

## Parameters

| Parameter Name | Type | Description | DefaultValue | Possible values |
| :-- | :-- | :-- | :-- | :-- |
| `privateEndpointName` | string | Required. Name of the private endpoint resource to create | | |
| `targetSubnetId` | string | Required. Resource Id of the subnet where the endpoint needs to be connected |  |  |
| `serviceResourceId` | string | Required. Resource Id of the resource that needs to be connected to the network | |  |
| `groupId` | array | Required. Subtype(s) of the connection to be created. The allowed values depend on the type serviceResourceId refers to. Currently only array of a single element are supported. | | See [here](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource) for possible values (subresources column).<br>For Azure DataFactory: portal, dataFactory |
| `lock` | string | Optional. Specify the type of lock. | 'NotSpecified' | 'CanNotDelete', 'NotSpecified', 'ReadOnly' |
| `roleAssignments` | array | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11' | System.Object[] |  |
| `privateDNSId` | string | Optional. Resource id of the private DNS zone | | |
| `location` | string | Optional. Location for all Resources | resourceGroup().location | |
| `tags` | object | Optional. Tags of the resource |  |  |
| `cuaId` | string | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |  |  |

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

### Parameter Usage: `roleAssignments`

```json
"roleAssignments": {
    "value": [
        {
            "roleDefinitionIdOrName": "Desktop Virtualization User",
            "principalIds": [
                "12345678-1234-1234-1234-123456789012", // object 1
                "78945612-1234-1234-1234-123456789012" // object 2
            ]
        },
        {
            "roleDefinitionIdOrName": "Reader",
            "principalIds": [
                "12345678-1234-1234-1234-123456789012", // object 1
                "78945612-1234-1234-1234-123456789012" // object 2
            ]
        },
        {
            "roleDefinitionIdOrName": "/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11",
            "principalIds": [
                "12345678-1234-1234-1234-123456789012" // object 1
            ]
        }
    ]
}

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `privateEndpointResourceGroup` | string | The name of the Resource Group the resources was deployed to |
| `privateEndpointResourceId` | string | The Resource id of the resource deployed. |
| `privateEndpointName` | string | The Name of the deployed private endpoint. |

## Considerations

*N/A*

## Additional resources

- [Private endpoint](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview)
- [Template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-02-01/privateendpoints/privatednszonegroups)
