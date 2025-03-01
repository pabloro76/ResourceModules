# Role Assignments

This module deploys Role Assignments.

## Resource types

| Resource Type                             | ApiVersion         |
| :---------------------------------------- | :----------------- |
| `Microsoft.Authorization/roleAssignments` | 2020-04-01-preview |
| `Microsoft.Resources/deployments`         | 2018-02-01         |

## Parameters

| Parameter Name      | Type   | Default Value           | Possible values               | Description                                                                                                                                                                                                                                                                                                                                                                                                      |
| :------------------ | :----- | :---------------------- | :---------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `roleAssignments`   | array  | []                      | Complex structure, see below. | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalIds' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or it's fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11' |  |
| `cuaId`             | string | ""                      |                               | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered                                                                                                                                                                                                                                                                                                                          |
| `resourceGroupName` | string | ""                      |                               | Optional. Name of the Resource Group to assign the RBAC role to. If no Resource Group name is provided, and Subscription ID is provided, the module deploys at subscription level, therefore assigns the provided RBAC role to the resource group.                                                                                                                                                               |
| `subscriptionId`    | string | ""                      |                               | Optional. ID of the Subscription to assign the RBAC role to. If no Resource Group name is provided, the module deploys at subscription level, therefore assigns the provided RBAC role to the subscription.                                                                                                                                                                                                      |
| `managementGroupId` | string | ""                      |                               | Optional. ID of the Management Group to assign the RBAC role to. If no Subscription is provided, the module deploys at management group level, therefore assigns the provided RBAC role to the management group.                                                                                                                                                                                                 |
| `location`          | string | [deployment().location] |                               | Optional. Location for all resources.                                                                                                                                                                                                                                                                                                                                                                            |  |

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
            "roleDefinitionIdOrName": "/subscriptions/78945612-1234-1234-1234-123456789012/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11",
            "principalIds": [
                "12345678-1234-1234-1234-123456789012" // object 1
            ]
        }
    ]
}
```

### Parameter Usage: `managementGroupId`

To deploy resource to a Management Group, provide the `managementGroupId` as an input parameter to the module.

```json
"managementGroupId": {
	"value": "contoso-group"
}
```

> The name of the Management Group in the deployment does not have to match the value of the `managementGroupId` in the input parameters.

### Parameter Usage: `subscriptionId`

To deploy resource to an Azure Subscription, provide the `subscriptionId` as an input parameter to the module. **Example**:

```json
"subscriptionId": {
	"value": "12345678-b049-471c-95af-123456789012"
}
```

### Parameter Usage: `resourceGroupName`

To deploy resource to a Resource Group, provide the `subscriptionId` and `resourceGroupName` as an input parameter to the module. **Example**:

```json
"subscriptionId": {
	"value": "12345678-b049-471c-95af-123456789012"
},
"resourceGroupName": {
	"value": "target-resourceGroup"
}
```
> The `subscriptionId` is used to enable deployment to a Resource Group Scope, allowing the use of the `resourceGroup()` function from a Management Group Scope. [Additional Details](https://github.com/Azure/bicep/pull/1420).

## Outputs

| Output Name       | Type   | Description                                                                                                             |
| :---------------- | :----- | :---------------------------------------------------------------------------------------------------------------------- |
| `assignmentScope` | string | The scope (management group, subscription or resource group) of the assignments defined in this module were created on. |
| `roleAssignments` | array  | Array of role assignment objects.                                                                                       |

## Considerations

This module can be deployed both at management group, subscription or resource group level:

- To deploy the module at resource group level, provide a valid name of an existing Resource Group in the `resourceGroupName` parameter, along side the `subscriptionId` parameter.
- To deploy the module at the subscription level, only provide the `subscriptionId` parameter.
- To deploy the module at the management group level, only provide the `managementGroupId` parameter.

## Additional resources

- [What is Azure role-based access control (Azure RBAC)?](https://docs.microsoft.com/en-us/azure/role-based-access-control/overview)
- [Microsoft.Authorization roleAssignments template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.authorization/2018-09-01-preview/roleassignments)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
