# AutoManage

This module deploys an AutoManage account and associates VM with it.

## Resource Types

| Resource Type                                                                 | Api Version        |
| :---------------------------------------------------------------------------- | :----------------- |
| `Microsoft.Authorization/roleAssignments`                                     | 2020-04-01-preview |
| `Microsoft.Automanage/accounts`                                               | 2020-06-30-preview |
| `Microsoft.Compute/virtualMachines/providers/configurationProfileAssignments` | 2020-06-30-preview |
| `Microsoft.Resources/deployments`                                             | 2021-01-01         |

## Parameters

| Parameter Name                       | Type   | Default Value                                                                | Possible values          | Description                                                                              |
| :----------------------------------- | :----- | :--------------------------------------------------------------------------- | :----------------------- | :--------------------------------------------------------------------------------------- |
| `location`                           | string |                                                                              |                          | Optional. The location of automanage                                                     |
| `autoManageAccountName`              | string | ${replace(subscription().displayName, ' ', '')}-AutoManage                   |                          | Optional. The name of automanage account                                                 |
| `autoManageAccountResourceGroupName` | string | ${replace(subscription().displayName, ' ', '')}_group'                       |                          | Optional. The resource group name where automanage will be created                       |
| `autoManageAccountSubscriptionId`    | string | subscription().id                                                            |                          | Optional. The Subscription id where automanage will be created                           |
| `configurationProfile`               | string | Production                                                                   | 'Production', 'Dev/Test' | Optional. The configuration profile of automanage                                        |
| `VMName`                             | string |                                                                              |                          | Required. The name of the VM to be associated                                            |
| `VMResourceGroupName`                | string |                                                                              |                          | Required. The name of the VM resource group                                              |
| `cuaId`                              | string | ""                                                                           |                          | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered. |

## Outputs

| Output Name                      | Type   | Description                                                           |
| :------------------------------- | :----- | :-------------------------------------------------------------------- |
| `autoManageAccountName`          | string | The Name of the Auto Manage Account.                                  |
| `autoManageAccountResourceGroup` | string | The name of the Resource Group the AutoManage Account was created in. |
| `autoManageAccountResourceId`    | string | The Resource Id of the AutoManage account                             |

## Considerations

*N/A*

## Additional resources

- [ResourceGroups](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2019-10-01/resourceGroups)
- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2019-10-01/deployments)
- [RoleAssignments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-04-01-preview/roleAssignments)
