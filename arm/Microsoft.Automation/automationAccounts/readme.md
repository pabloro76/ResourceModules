# AutomationAccounts

This module deploys an Azure Automation Account, with resource lock.

## Resource Types

| Resource Type                                                       | Api Version        |
| :------------------------------------------------------------------ | :----------------- |
| `Microsoft.Automation/automationAccounts`                           | 2020-01-13-preview |
| `Microsoft.Automation/automationAccounts/modules`                   | 2020-01-13-preview |
| `Microsoft.Automation/automationAccounts/schedules`                 | 2020-01-13-preview |
| `Microsoft.Automation/automationAccounts/runbooks`                  | 2019-06-01         |
| `Microsoft.Automation/automationAccounts/jobSchedules`              | 2020-01-13-preview |
| `Microsoft.Authorization/locks`                                     | 2016-09-01         |
| `Microsoft.Insights/diagnosticSettings`                             | 2017-05-01-preview |
| `Microsoft.Network/privateEndpoints`                                | 2020-05-01         |
| `Microsoft.Network/privateEndpoints/privateDnsZoneGroups`           | 2020-05-01         |
| `Microsoft.Automation/automationAccounts/providers/roleAssignments` | 2020-04-01-preview |
| `Microsoft.Resources/deployments`                                   | 2020-06-01         |

## Parameters

| Parameter Name                  | Type   | Default Value                | Possible values               | Description                                                                                                                                                                                                                                                                                                                                                                                                     |
| :------------------------------ | :----- | :--------------------------- | :---------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cuaId`                         | string |                              |                               | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered                                                                                                                                                                                                                                                                                                                         |
| `automationAccountName`         | string |                              |                               | Required. Name of the Azure Automation Account                                                                                                                                                                                                                                                                                                                                                                  |
| `location`                      | string | `[resourceGroup().location]` |                               | Optional. Location for all resources.                                                                                                                                                                                                                                                                                                                                                                           |
| `skuName`                       | string | `Basic`                      | `Free`, `Basic`               | Optional. Specifies the SKU for the Automation Account                                                                                                                                                                                                                                                                                                                                                          |
| `modules`                       | array  | []                           |                               | Optional. List of modules to be created in the automation account. Complex structure, see below.                                                                                                                                                                                                                                                                                                                |
| `schedules`                     | array  | []                           |                               | Optional. List of schedules to be created in the automation account. Complex structure, see below.                                                                                                                                                                                                                                                                                                              |
| `runbooks`                      | array  | []                           |                               | Optional. List of runbooks to be created in the automation account. Complex structure, see below.                                                                                                                                                                                                                                                                                                               |
| `jobSchedules`                  | array  | []                           |                               | Optional. List of jobSchedules to be created in the automation account. Complex structure, see below.                                                                                                                                                                                                                                                                                                           |
| `baseTime`                      | string | [utcNow('u')]                |                               | Optional. Time used as a basis for e.g. the schedule start date                                                                                                                                                                                                                                                                                                                                                 |
| `diagnosticLogsRetentionInDays` | int    | `365`                        |                               | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.                                                                                                                                                                                                                                                                                                  |
| `diagnosticStorageAccountId`    | string |                              |                               | Optional. Resource identifier of the Diagnostic Storage Account.                                                                                                                                                                                                                                                                                                                                                |
| `workspaceId`                   | string |                              |                               | Optional. Resource identifier of Log Analytics.                                                                                                                                                                                                                                                                                                                                                                 |
| `privateEndpoints`              | array  | System.Object[]              |                               | Optional. Configuration Details for private endpoints.                                                                                                                                                                                                                                                                                                                                                          |
| `eventHubAuthorizationRuleId`   | string |                              |                               | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.                                                                                                                                                                                                                                                                 |
| `eventHubName`                  | string |                              |                               | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.                                                                                                                                                                                                                                                                   |
| `lock` | string | 'NotSpecified' | 'CanNotDelete', 'NotSpecified', 'ReadOnly' | Optional. Specify the type of lock |
| `roleAssignments`               | array  | []                           | Complex structure, see below. | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or it's fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11' |
| `tags`                          | object |                              |                               | Optional. Tags of the Automation Account resource.                                                                                                                                                                                                                                                                                                                                                              |
| `sasTokenValidityLength`        | string | PT8H                         |                               | Optional. SAS token validity length. Usage: 'PT8H' - valid for 8 hours; 'P5D' - valid for 5 days; 'P1Y' - valid for 1 year. When not provided, the SAS token will be valid for 8 hours.                                                                                                                                                                                                                         |

### Parameter Usage: `modules`

List of modules to be created in the automation account

```json
"modules": {
    "value": [
    {
        "name": "OMSIngestionAPI",                                    // The module name.
        "version": "latest",                                          // The module version or specify latest to get the latest version
        "uri": "https://www.powershellgallery.com/api/v2/package"     // The module package uri, e.g. https://www.powershellgallery.com/api/v2/package
    },
    {
        "name": "PackageManagement",
        "version": "1.4.5",
        "uri": "https://www.powershellgallery.com/api/v2/package"
    }
    ]
}
```

### Parameter Usage: `runbooks`

List of runbooks to be created in the automation account

```json
"runbooks": {
    "value": [
        {
            "runbookName": "ScalingRunbook", // Name for a runbook if you intent to deploy one
            "runbookType": "PowerShell", // Type of script
            "runbookScriptUri": "https://raw.githubusercontent.com/Azure/basicScale.ps1", // The uri where the runbook script is located
            "scriptStorageAccountId": "/subscriptions/62826c76-d304-46d8-a0f6-718dbdcc536c/resourceGroups/AVD-Mgmt-PO-RG/providers/Microsoft.Storage/storageAccounts/avdassetsstore",
            "version": "1.0.0.0" // version of api
        }
    ]
}
```

### Parameter Usage: `schedules`

List of schedules to be created in the automation account

```json
"schedules": {
    "value": [
        {
            "scheduleName": "ScalingRunbook_Schedule", // The schedule name.
            "startTime": "", // Gets or sets the start time of the schedule.
            "expiryTime": "9999-12-31T23:59:00+00:00", // Gets or sets the end time of the schedule.
            "interval": 15, // Gets or sets the interval of the schedule.
            "frequency": "Minute", // Gets or sets the frequency of the schedule. - OneTime, Day, Hour, Week, Month, Minute
            "timeZone": "Europe/Berlin", // Gets or sets the time zone of the schedule.
            "advancedSchedule": "" // Gets or sets the AdvancedSchedule
        }
    ]
}
```

### Parameter Usage: `jobSchedules`

List of jobSchedules to be created in the automation account

```json
"jobSchedules": {
    "value": [
        {
            "jobScheduleName": "ScalingRunbook_JobSchedule", // jobSchedule used to generate unique id
            "scheduleName": "ScalingRunbook_Schedule", // Gets or sets the schedule
            "runbookName": "ScalingRunbook", // Gets or sets the runbook
            "parameters": { // Gets or sets a list of job properties.
                "param1": "value1"
            },
            "runOn": "" // Gets or sets the hybrid worker group that the scheduled job should run on.
        }
    ]
}
```

### Parameter Usage: `privateEndpoints`

To use Private Endpoint the following dependencies must be deployed:

- Destination subnet must be created with the following configuration option - `"privateEndpointNetworkPolicies": "Disabled"`.  Setting this option acknowledges that NSG rules are not applied to Private Endpoints (this capability is coming soon). A full example is available in the Virtual Network Module.
- Although not strictly required, it is highly recommended to first create a private DNS Zone to host Private Endpoint DNS records. See [Azure Private Endpoint DNS configuration](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns) for more information.

```json
"privateEndpoints": {
    "value": [
        // Example showing all available fields
        {
            "name": "sxx-az-sa-cac-y-123-pe", // Optional: Name will be automatically generated if one is not provided here
            "subnetResourceId": "/subscriptions/8629be3b-96bc-482d-a04b-ffff597c65a2/resourceGroups/validation-rg/providers/Microsoft.Network/virtualNetworks/sxx-az-vnet-weu-x-001/subnets/sxx-az-subnet-weu-x-001",
            "service": "blob",
            "privateDnsZoneResourceIds": [ // Optional: No DNS record will be created if a private DNS zone Resource ID is not specified
                "/subscriptions/8629be3b-96bc-482d-a04b-ffff597c65a2/resourceGroups/validation-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
            ],
            "customDnsConfigs": [ // Optional
                {
                    "fqdn": "customname.test.local",
                    "ipAddresses": [
                        "10.10.10.10"
                    ]
                }
            ]
        },
        // Example showing only mandatory fields
        {
            "subnetResourceId": "/subscriptions/8629be3b-96bc-482d-a04b-ffff597c65a2/resourceGroups/validation-rg/providers/Microsoft.Network/virtualNetworks/sxx-az-vnet-weu-x-001/subnets/sxx-az-subnet-weu-x-001",
            "service": "file"
        }
    ]
}
```

### Parameter Usage: `roleAssignments`

```json
"roleAssignments": {
    "value": [
        {
            "roleDefinitionIdOrName": "Automation Contributor",
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

## Outputs

| Output Name                      | Type   | Description                                                |
| :------------------------------- | :----- | :--------------------------------------------------------- |
| `automationAccountName`          | string | The Name of the Automation Account.                        |
| `automationAccountResourceId`    | string | The Resource Id of the Automation Account.                 |
| `automationAccountResourceGroup` | string | The Resource Group the Automation Account was deployed to. |
| `modules`                        | array  | The array of the modules created.                          |
| `schedules`                      | array  | The array of the schedules created.                        |
| `runbooks`                       | array  | The array of the runbooks created.                         |
| `jobSchedules`                   | array  | The array of the jobSchedules created.                     |

## Considerations

*N/A*

## Additional resources

- [An introduction to Azure Automation](https://docs.microsoft.com/en-us/azure/automation/automation-intro)
- [Microsoft.Automation automationAccounts template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.automation/allversions)
- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
