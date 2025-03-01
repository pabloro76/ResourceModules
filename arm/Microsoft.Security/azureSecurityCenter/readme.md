# AzureSecurityCenter

This template enables Azure Security Center - Standard tier by default, could be overridden.

## Resource types

| Resource Type                                 | ApiVersion         |
| :-------------------------------------------- | :----------------- |
| `Microsoft.Resources/deployments`             | 2019-10-01         |
| `Microsoft.Security/autoProvisioningSettings` | 2017-08-01-preview |
| `Microsoft.Security/deviceSecurityGroups`     | 2019-08-01         |
| `Microsoft.Security/iotSecuritySolutions`     | 2019-08-01         |
| `Microsoft.Security/pricings`                 | 2018-06-01         |
| `Microsoft.Security/securityContacts`         | 2017-08-01-preview |
| `Microsoft.Security/workspaceSettings`        | 2017-08-01-preview |

## Parameters

| Parameter Name                        | Type   | Description                                                                                                                                                                                                                                                                                                                          | DefaultValue | Possible values    |
| :------------------------------------ | :----- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------- | :----------------- |
| `appServicesPricingTier`              | string | Optional. The pricing tier value for AppServices. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard                   | 'Free'       | 'Free', 'Standard' |
| `autoProvision`                       | string | Optional. Describes what kind of security agent provisioning action to take. - On or Off                                                                                                                                                                                                                                             | On           | System.Object[]    |
| `containerRegistryPricingTier`        | string | Optional. The pricing tier value for ContainerRegistry. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard             | 'Free'       | 'Free', 'Standard' |
| `deviceSecurityGroupProperties`       | object | Optional. Device Security group data                                                                                                                                                                                                                                                                                                 |              |                    |
| `ioTSecuritySolutionProperties`       | object | Optional. Security Solution data                                                                                                                                                                                                                                                                                                     |              |                    |
| `kubernetesServicePricingTier`        | string | Optional. The pricing tier value for KubernetesService. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard             | 'Free'       | 'Free', 'Standard' |
| `scope`                               | string | Required. All the VMs in this scope will send their security data to the mentioned workspace unless overridden by a setting with more specific scope.                                                                                                                                                                                |              |                    |
| `securityContactProperties`           | object | Optional. Security contact data                                                                                                                                                                                                                                                                                                      |              |                    |
| `sqlServersPricingTier`               | string | Optional. The pricing tier value for SqlServers. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard                    | 'Free'       | 'Free', 'Standard' |
| `sqlServerVirtualMachinesPricingTier` | string | Optional. The pricing tier value for SqlServerVirtualMachines. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard      | 'Free'       | 'Free', 'Standard' |
| `storageAccountsPricingTier`          | string | Optional. The pricing tier value for StorageAccounts. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard               | 'Free'       | 'Free', 'Standard' |
| `virtualMachinesPricingTier`          | string | Optional. The pricing tier value for VMs. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard                           | 'Free'       | 'Free', 'Standard' |
| `keyVaultsPricingTier`                | string | Optional. The pricing tier value for KeayVaults. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard                    | 'Free'       | 'Free', 'Standard' |
| `dnsPricingTier`                      | string | Optional. The pricing tier value for DNS. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard                           | 'Free'       | 'Free', 'Standard' |
| `armPricingTier`                      | string | Optional. The pricing tier value for ARM. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard                           | 'Free'       | 'Free', 'Standard' |
| `openSourceRelationalDatabasesTier`   | string | Optional. The pricing tier value for OpenSourceRelationalDatabases. Azure Security Center is provided in two pricing tiers: free and standard, with the standard tier available with a trial period. The standard tier offers advanced security capabilities, while the free tier offers basic security features. - Free or Standard | 'Free'       | 'Free', 'Standard' |
| `workspaceId`                         | string | Required. The full Azure ID of the workspace to save the data in.                                                                                                                                                                                                                                                                    |              |                    |
| `enableAtp`                           | bool   | Optional. Indicates whether Advanced Threat Protection is enabled.                                                                                                                                                                                                                                                                   | False        | bool               |

### Parameter Usage: `deviceSecurityGroupProperties`

```json
"deviceSecurityGroupProperties": {
    "value": {
        "thresholdRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "minThreshold": "integer",
            "maxThreshold": "integer"
          }
        ],
        "timeWindowRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "minThreshold": "integer",
            "maxThreshold": "integer",
            "timeWindowSize": "string"
          }
        ],
        "allowlistRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "allowlistValues": [
              "string"
            ]
          }
        ],
        "denylistRules": [
          {
            "isEnabled": "boolean",
            "ruleType": "string",
            "denylistValues": [
              "string"
            ]
          }
        ]
    }
}
```

### Parameter Usage: `ioTSecuritySolutionProperties`

```json
"ioTSecuritySolutionProperties": {
  "value": {
      "resourceGroup": "string",
      "workspace": "string",
      "displayName": "string",
      "status": "string",
      "export": [
        "RawEvents"
      ],
      "disabledDataSources": [
        "TwinData"
      ],
      "iotHubs": [
        "string"
      ],
      "userDefinedResources": {
        "query": "string",
        "querySubscriptions": [
          "string"
        ]
      },
      "recommendationsConfiguration": [
        {
          "recommendationType": "string",
          "status": "string"
        }
      ]
    }
}
```

### Parameter Usage: `securityContactProperties`

```json
"securityContactProperties": {
  "value": {
      "email": "test@contoso.com",
      "phone": "+12345678",
      "alertNotifications": "On",
      "alertsToAdmins": "Off"
  }
}
```

## Outputs

| Output Name   | Type   | Description             |
| :------------ | :----- | :---------------------- |
| `workspaceId` | string | This is the workspaceid |

## Considerations

## Additional resources

- [What is Azure Security Center?](https://docs.microsoft.com/en-us/azure/security-center/security-center-intro)
- [Microsoft.Security template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.security/allversions)
