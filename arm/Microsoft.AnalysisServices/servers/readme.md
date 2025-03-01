# Analysis Services

## Resource Types

| Resource Type                                                     | Api Version        |
| :---------------------------------------------------------------- | :----------------- |
| `Microsoft.Resources/deployments`                                 | 2018-02-01         |
| `Microsoft.AnalysisServices/servers`                              | 2017-08-01         |
| `Microsoft.Authorization/locks`                                   | 2016-09-01         |
| `Microsoft.AnalysisServices/servers/providers/diagnosticsettings` | 2017-05-01-preview |
| `Microsoft.AnalysisServices/servers/providers/roleAssignments`    | 2020-04-01-preview |

### Resource dependency

The following resources are required to be able to deploy this resource.

- Virtual Network

## Parameters

| Parameter Name                  | Type   | Description                                                                                                                                                                                                                                                                                                                                                                                                     | DefaultValue                                             | Possible values               |
| :------------------------------ | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------- | :---------------------------- |
| `analysisServicesName`          | string | Required. The name of the Azure Analysis Services server to create.                                                                                                                                                                                                                                                                                                                                             |                                                          |                               |
| `cuaId`                         | string | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered                                                                                                                                                                                                                                                                                                                         |                                                          |                               |
| `diagnosticLogsRetentionInDays` | int    | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.                                                                                                                                                                                                                                                                                                  | 365                                                      |                               |
| `diagnosticStorageAccountId`    | string | Optional. Resource identifier of the Diagnostic Storage Account.                                                                                                                                                                                                                                                                                                                                                |                                                          |                               |
| `eventHubAuthorizationRuleId`   | string | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.                                                                                                                                                                                                                                                                 |                                                          |                               |
| `eventHubName`                  | string | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.                                                                                                                                                                                                                                                                   |                                                          |                               |
| `firewallSettings`              | object | Optional. The inbound firewall rules to define on the server. If not specified, firewall is disabled.                                                                                                                                                                                                                                                                                                           | firewallRules=System.Object[]; enablePowerBIService=True |                               |
| `location`                      | string | Optional. Location for all Resources.                                                                                                                                                                                                                                                                                                                                                                           | [resourceGroup().location]                               |                               |
| `lock` | string | Optional. Specify the type of lock. | 'NotSpecified' | 'CanNotDelete', 'NotSpecified', 'ReadOnly' |
| `roleAssignments`               | array  | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or it's fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11' | []                                                       | Complex structure, see below. |
| `skuCapacity`                   | int    | Optional. The total number of query replica scale-out instances.                                                                                                                                                                                                                                                                                                                                                | 1                                                        |                               |
| `skuName`                       | string | Optional. The sku name of the Azure Analysis Services server to create.                                                                                                                                                                                                                                                                                                                                         | S0                                                       |                               |
| `tags`                          | object | Optional. Tags of the resource.                                                                                                                                                                                                                                                                                                                                                                                 |                                                          |                               |
| `workspaceId`                   | string | Optional. Resource identifier of Log Analytics.                                                                                                                                                                                                                                                                                                                                                                 |                                                          |                               |

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
```

## Outputs

| Output Name                     | Type   | Description                                                |
| :------------------------------ | :----- | :--------------------------------------------------------- |
| `analysisServicesName`          | string | The Name of the Analysis Services.                         |
| `analysisServicesResourceGroup` | string | The name of the Resource Group with the Analysis Services. |
| `analysisServicesResourceId`    | string | The Resource Id of the Analysis Services.                  |

### References

### Template references

- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2018-02-01/deployments)
- [Servers](https://docs.microsoft.com/en-us/azure/templates/Microsoft.AnalysisServices/2017-08-01/servers)

## Considerations

## Additional resources

- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2018-02-01/deployments)
- [Servers](https://docs.microsoft.com/en-us/azure/templates/Microsoft.AnalysisServices/2017-08-01/servers)
