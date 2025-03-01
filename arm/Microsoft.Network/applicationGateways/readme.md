# ApplicationGateway

# Resource

This template deploys Application Gateway.

## Resource types

| Resource Type                                                        | Api Version        |
|----------------------------------------------------------------------|--------------------|
| `Microsoft.Insights/diagnosticsettings` | 2017-05-01-preview |
| `Microsoft.Network/applicationGateways/providers/roleAssignments`    | 2018-09-01-preview |
| `Microsoft.Network/applicationGateways`                              | 2021-02-01         |
| `Microsoft.Resources/deployments`                                    | 2020-06-01         |
| `Microsoft.Authorization/locks`                                                    | 2016-09-01         |

### Resource dependency

The following resources are required to be able to deploy this resource.

## Parameters

| Parameter Name                   | Type   | Description                                                                                                                                                                                                                                                                                                                                                                                                    | DefaultValue                    | Possible values |
|----------------------------------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------|-----------------|
| `applicationGatewayName`         | string | Required. The name to be used for the Application Gateway.                                                                                                                                                                                                                                                                                                                                                     |                                 |                 |
| `backendHttpConfigurations`      | array  | Required. The backend HTTP settings to be configured. These HTTP settings will be used to rewrite the incoming HTTP requests for the backend pools.                                                                                                                                                                                                                                                            |                                 |                 |
| `backendPools`                   | array  | Required. The backend pools to be configured.                                                                                                                                                                                                                                                                                                                                                                  |                                 |                 |
| `capacity`                       | int    | Optional. The number of Application instances to be configured.                                                                                                                                                                                                                                                                                                                                                | 2                               |                 |
| `cuaId`                          | string | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered.                                                                                                                                                                                                                                                                                                                       |                                 |                 |
| `diagnosticLogsRetentionInDays`  | int    | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.                                                                                                                                                                                                                                                                                                 | 365                             |                 |
| `diagnosticStorageAccountId`     | string | Optional. Resource identifier of the Diagnostic Storage Account.                                                                                                                                                                                                                                                                                                                                               |                                 |                 |
| `eventHubAuthorizationRuleId`    | string | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to.                                                                                                                                                                                                                                                                |                                 |                 |
| `eventHubName`                   | string | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category.                                                                                                                                                                                                                                                                  |                                 |                 |
| `frontendHttpRedirects`          | array  | Optional. The http redirects to be configured. Each redirect will route http traffic to a pre-defined frontEnd https listener.                                                                                                                                                                                                                                                                                 | System.Object[]                 |                 |
| `frontendHttpListeners`          | array  | Optional. The frontend http listeners to be configured.                                                                                                                                                                                                                                                                                                                                                        |                                 |                 |
| `frontendHttpsListeners`         | array  | Optional. The frontend https listeners to be configured.                                                                                                                                                                                                                                                                                                                                                       |                                 |                 |
| `frontendPrivateIpAddress`       | string | Optional. The private IP within the Application Gateway subnet to be used as frontend private address.                                                                                                                                                                                                                                                                                                         |                                 |                 |
| `frontendPublicIpResourceId`     | string | Required. PublicIP Resource Id used in Public Frontend.                                                                                                                                                                                                                                                                                                                                                        |                                 |                 |
| `gatewayIpConfigurationName`     | string | Optional. Application Gateway IP configuration name.                                                                                                                                                                                                                                                                                                                                                           | gatewayIpConfiguration01        |                 |
| `http2Enabled`                   | bool   | Optional. Enables HTTP/2 support.                                                                                                                                                                                                                                                                                                                                                                              | True                            |                 |
| `location`                       | string | Optional. Location for all Resources.                                                                                                                                                                                                                                                                                                                                                                          | [resourceGroup().location]      |                 |
| `lock` | string | Optional. Specify the type of lock. | 'NotSpecified' | 'CanNotDelete', 'NotSpecified', 'ReadOnly' || `managedIdentityResourceId`      | string | Optional. Resource Id of an User assigned managed identity which will be associated with the Application Gateway.                                                                                                                                                                                                                                                                                              |                                 |                 |
| `probes`                         | string | Optional. The backend HTTP settings probes to be configured.                                                                                                                                                                                                                                                                                                                                                   |                                 |                 |
| `roleAssignments`                | array  | Optional. Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11' | System.Object[]                 |                 |
| `routingRules`                   | array  | Required. The routing rules to be configured. These rules will be used to route requests from frontend listeners to backend pools using a backend HTTP configuration.                                                                                                                                                                                                                                          |                                 |                 |
| `sku`                            | string | Optional. The name of the SKU for the Application Gateway.                                                                                                                                                                                                                                                                                                                                                     | WAF_Medium                      | System.Object[] |
| `sslCertificateKeyVaultSecretId` | string | Optional. Secret Id of the SSL certificate stored in the Key Vault that will be used to configure the HTTPS listeners.                                                                                                                                                                                                                                                                                         |                                 |                 |
| `sslCertificateName`             | string | Optional. SSL certificate reference name for a certificate stored in the Key Vault to configure the HTTPS listeners.                                                                                                                                                                                                                                                                                           | sslCertificate01                |                 |
| `subnetName`                     | string | Required. The name of Gateway Subnet Name where the Application Gateway will be deployed.                                                                                                                                                                                                                                                                                                                      |                                 |                 |
| `tags`                           | object | Optional. Tags of the resource.                                                                                                                                                                                                                                                                                                                                                                                |                                 |                 |
| `vNetName`                       | string | Required. The name of the Virtual Network where the Application Gateway will be deployed.                                                                                                                                                                                                                                                                                                                      |                                 |                 |
| `vNetResourceGroup`              | string | Optional. The name of the Virtual Network Resource Group where the Application Gateway will be deployed.                                                                                                                                                                                                                                                                                                       | [resourceGroup().name]          |                 |
| `vNetSubscriptionId`             | string | Optional. The Subscription Id of the Virtual Network where the Application Gateway will be deployed.                                                                                                                                                                                                                                                                                                           | [subscription().subscriptionId] |                 |
| `workspaceId`                    | string | Optional. Resource identifier of Log Analytics.                                                                                                                                                                                                                                                                                                                                                                |                                 |                 |

### Parameter Usage: `backendPools`

```json
"backendPools": {
    "value": [
        {
            "backendPoolName": "appServiceBackendPool",
            "backendAddresses": [
            {
                "fqdn": "aghapp.azurewebsites.net"
            }
            ]
        },
        {
            "backendPoolName": "privateVmBackendPool",
            "backendAddresses": [
            {
                "ipAddress": "10.0.0.4"
            }
            ]
        }
    ]
}
```

### Parameter Usage: `backendHttpConfigurations`

```json
"backendHttpConfigurations": {
    "value": [
        {
            "backendHttpConfigurationName": "appServiceBackendHttpsSetting",
            "port": 443,
            "protocol": "https",
            "cookieBasedAffinity": "Disabled",
            "pickHostNameFromBackendAddress": true,
            "probeEnabled": false
        },
        {
            "backendHttpConfigurationName": "privateVmHttpSetting",
            "port": 80,
            "protocol": "http",
            "cookieBasedAffinity": "Disabled",
            "pickHostNameFromBackendAddress": false,
            "probeEnabled": true
        }
    ]
}
```

### Parameter Usage: `probes`

```json
"probes": {
    "value": [
        {
          "backendHttpConfigurationName": "privateVmHttpSetting",
          "protocol": "http",
          "host": "10.0.0.4",
          "path": "/",
          "interval": 60,
          "timeout": 15,
          "unhealthyThreshold": 5,
          "minServers": 3,
          "statusCodes": [
            "200",
            "401"
          ]
        }
    ]
}
```

### Parameter Usage: `frontendHttpsListeners`

```json
"frontendHttpsListeners": {
    "value": [
        {
            "frontendListenerName": "public443",
            "frontendIPType": "Public",
            "port": 443
        },
        {
            "frontendListenerName": "private4433",
            "frontendIPType": "Private",
            "port": 4433
        }
    ]
}
```

### Parameter Usage: `frontendHttpRedirects`

```json
"frontendHttpRedirects": {
    "value": [
        {
            "frontendIPType": "Public",
            "port": 80,
            "frontendListenerName": "public443"
        },
        {
            "frontendIPType": "Private",
            "port": 8080,
            "frontendListenerName": "private4433"
        }
    ]
}
```

### Parameter Usage: `routingRules`

```json
"routingRules": {
    "value": [
        {
            "frontendListenerName": "public443",
            "backendPoolName": "appServiceBackendPool",
            "backendHttpConfigurationName": "appServiceBackendHttpsSetting"
        },
        {
            "frontendListenerName": "private4433",
            "backendPoolName": "privateVmBackendPool",
            "backendHttpConfigurationName": "privateVmHttpSetting"
        }
    ]
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

| Output Name                       | Type   | Description                                                  |
|-----------------------------------|--------|--------------------------------------------------------------|
| `applicationGatewayName`          | string | The Application Gateway Name.                                |
| `applicationGatewayResourceGroup` | string | The name of the Resource Group with the Application Gateway. |
| `applicationGatewayResourceId`    | string | The Resource Id of the Application Gateway.                  |

## Considerations

*N/A*

## Additional resources

- [ApplicationGateways](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/applicationGateways)
- [What is Azure Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/overview)
