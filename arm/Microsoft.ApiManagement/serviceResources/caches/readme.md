# Api Management Service Cache

This module deploys an Api Management Service Cache.

## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.ApiManagement/service/caches` | 2020-06-01-preview |       
| `Microsoft.Resources/deployments` | 2020-06-01 ||

### Resource dependency

The following resources are required to be able to deploy this resource.

- `Microsoft.ApiManagement/service`

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `apiManagementServiceName` | string |  |  | Required. The name of the of the Api Management service. |
| `cacheName` | string |  |  | Required. Identifier of the Cache entity. Cache identifier (should be either 'default' or valid Azure region identifier). |
| `connectionString` | string |  |  | Required. Runtime connection string to cache. Can be referenced by a named value like so, {{<named-value>}} |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `cacheDescription` | string |  |  | Optional. Cache description |
| `resourceId` | string |  |  | Optional. Original uri of entity in external system cache points to. |
| `useFromLocation` | string |  |  | Required. Location identifier to use cache from (should be either 'default' or valid Azure region identifier) |



## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `cacheResourceId` | string | The Api Management Service Cache Id |
| `cacheResourceName` | string | The Api Management Service Cache Name |
| `cacheResourceGroup` | string | The name of the Resource Group with the Api Management Service Cache |

## Considerations

- *None*

## Additional resources

- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
- [Azure Resource Manager template reference](https://docs.microsoft.com/en-us/azure/templates/)
- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2020-06-01/deployments)
- [Service/cacheS](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service/caches)