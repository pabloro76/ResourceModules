# Api Management Service Named Values

This module deploys Api Management Service Named Values.

## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.ApiManagement/service/namedValues` | 2020-06-01-preview |  
| `Microsoft.Resources/deployments` | 2020-06-01 |

### Resource dependency

The following resources are required to be able to deploy this resource.

- `Microsoft.ApiManagement/service`

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `apiManagementServiceName` | string |  |  | Required. The name of the of the Api Management service. |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `displayName` | string |  |  | Required. Unique name of NamedValue. It may contain only letters, digits, period, dash, and underscore characters. |
| `keyVault` | object |  |  | Optional. KeyVault location details of the namedValue.  |
| `namedValueName` | string |  |  | Required. Named value Name. |
| `namedValueTags` | array | System.Object[] |  | Optional. Tags that when provided can be used to filter the NamedValue list. - string |
| `secret` | bool | False |  | Optional. Determines whether the value is a secret and should be encrypted or not. Default value is false. |
| `value` | string | [newGuid()] |  | Optional. Value of the NamedValue. Can contain policy expressions. It may not be empty or consist only of whitespace. This property will not be filled on 'GET' operations! Use '/listSecrets' POST request to get the value. |

### Parameter Usage: `keyVault`

Product API's name list.

```json
"keyVault": {
    "value":{
         "secretIdentifier":"Key vault secret identifier for fetching secret.",
          "identityClientId":"SystemAssignedIdentity or UserAssignedIdentity Client Id which will be used to access key vault secret."
        }
    }
}
```

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `namedValueResourceId` | string | The Api Management Service named value Id |
| `namedValueResourceName` | string | The Api Management Service named value Name |
| `namedValueResourceGroup` | string | The name of the Resource Group with the Api Management Service named value |

## Considerations

- _None_

## Additional resources

- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
- [Azure Resource Manager template reference](https://docs.microsoft.com/en-us/azure/templates/)
- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2020-06-01/deployments)
- [Service/namedValueS](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service/namedValues)
