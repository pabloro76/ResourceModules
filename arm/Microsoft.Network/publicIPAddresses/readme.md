# Public IP Addresses

## Resource types

|Resource Type|ApiVersion|
|:--|:--|
|`Microsoft.Resources/deployments`|2018-02-01|
|`Microsoft.Network/publicIPAddresses`|2021-02-01|
|`Microsoft.Authorization/locks`|2016-09-01|
|`Microsoft.Insights/diagnosticsettings`|2017-05-01-preview|
|`Microsoft.Network/publicIPAddresses/providers/roleAssignments`|2018-09-01-preview||

### Resource dependency

The following resources are required to be able to deploy this resource.


## Parameters

| Parameter Name | Type | Description | DefaultValue | Possible values |
| :-- | :-- | :-- | :-- | :-- |
| `cuaId` | string | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |  |  |
| `diagnosticLogsRetentionInDays` | int | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely. | 365 |  |
| `diagnosticStorageAccountId` | string | Optional. Resource identifier of the Diagnostic Storage Account. |  |  |
| `eventHubAuthorizationRuleId` | string | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to. |  |  |
| `eventHubName` | string | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. |  |  |
| `location` | string | Optional. Location for all resources. | [resourceGroup().location] |  |
| `lock` | string | Optional. Specify the type of lock. | 'NotSpecified' | 'CanNotDelete', 'NotSpecified', 'ReadOnly' |
| `publicIPAddressName` | string | Required. The name of the Public IP Address |  |  |
| `publicIPAllocationMethod` | string | Optional. The public IP address allocation method. - Static or Dynamic. | Dynamic |  |
| `publicIPPrefixId` | string | Optional. Resource Id of the Public IP Prefix object. This is only needed if you want your Public IPs created in a PIP Prefix. |  |  |
| `roleAssignments` | array | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11' | System.Object[] |  |
| `skuName` | string | Optional. Public IP Address sku Name | Basic |  |
| `skuTier` | string | Optional. Public IP Address pricing tier | Regional |  |
| `tags` | object | Optional. Tags of the resource. |  |  |
| `workspaceId` | string | Optional. Resource identifier of Log Analytics. |  |  |

### Parameter Usage: `<ParameterPlaceholder>`

// TODO: Fill in Parameter usage

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
```
## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `publicIPAddressName` | string | The name of the resource deployed. |
| `publicIPAddressResourceGroup` | string | The name of the Resource Group the resources was deployed to. |
| `publicIPAddressResourceId` | string | The Resource id of the resource deployed. |

### References
### Template references

- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2018-02-01/deployments)
- [PublicIPAddresses](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Network/2019-04-01/publicIPAddresses)

## Considerations

## Additional resources

- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2018-02-01/deployments)
- [PublicIPAddresses](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Network/2021-02-01/publicIPAddresses)
