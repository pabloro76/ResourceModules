# Api Management Service Authorization Servers

This module deploys Api Management Service Authorization Servers.

## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.ApiManagement/service/authorizationServers` | 2020-06-01-preview |
| `Microsoft.Resources/deployments` | 2020-06-01 |

### Resource dependency

The following resources are required to be able to deploy this resource.

- `Microsoft.ApiManagement/service`

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `apiManagementServiceAuthorizationServerName` | string |  |  | Required. Identifier of the authorization server. |
| `apiManagementServiceName` | string |  |  | Required. The name of the of the Api Management service. |
| `authorizationEndpoint` | string |  |  | Required. OAuth authorization endpoint. See http://tools.ietf.org/html/rfc6749#section-3.2. |
| `authorizationMethods` | array | System.Object[] |  | Optional. HTTP verbs supported by the authorization endpoint. GET must be always present. POST is optional. - HEAD, OPTIONS, TRACE, GET, POST, PUT, PATCH, DELETE |
| `bearerTokenSendingMethods` | array | System.Object[] |  | Required. Specifies the mechanism by which access token is passed to the API. - authorizationHeader or query |
| `clientAuthenticationMethod` | array | System.Object[] |  | Required. Method of authentication supported by the token endpoint of this authorization server. Possible values are Basic and/or Body. When Body is specified, client credentials and other parameters are passed within the request body in the application/x-www-form-urlencoded format. - Basic or Body |
| `clientId` | string |  |  | Required. Client or app id registered with this authorization server. |
| `clientRegistrationEndpoint` | string |  |  | Required. Optional reference to a page where client or app registration for this authorization server is performed. Contains absolute URL to entity being referenced. |
| `clientSecret` | securestring |  |  | Required. Client or app secret registered with this authorization server. This property will not be filled on 'GET' operations! Use '/listSecrets' POST request to get the value. |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `defaultScope` | string |  |  | Optional. Access token scope that is going to be requested by default. Can be overridden at the API level. Should be provided in the form of a string containing space-delimited values. |
| `serverDescription` | string |  |  | Optional. Description of the authorization server. Can contain HTML formatting tags. |
| `grantTypes` | array | System.Object[] |  | Required. Form of an authorization grant, which the client uses to request the access token. - authorizationCode, implicit, resourceOwnerPassword, clientCredentials |
| `resourceOwnerPassword` | string |  |  | Optional. Can be optionally specified when resource owner password grant type is supported by this authorization server. Default resource owner password. |
| `resourceOwnerUsername` | string |  |  | Optional. Can be optionally specified when resource owner password grant type is supported by this authorization server. Default resource owner username. |
| `supportState` | bool | False |  | Optional. If true, authorization server will include state parameter from the authorization request to its response. Client may use state parameter to raise protocol security. |
| `tokenBodyParameters` | array | System.Object[] |  | Optional. Additional parameters required by the token endpoint of this authorization server represented as an array of JSON objects with name and value string properties, i.e. {"name" : "name value", "value": "a value"}. - TokenBodyParameterContract object |
| `tokenEndpoint` | string |  |  | Optional. OAuth token endpoint. Contains absolute URI to entity being referenced. |                                                                                                                                                                                                              |

### Parameter Usage: `<ParameterPlaceholder>`

// TODO: Fill in Parameter usage

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `apimServiceAuthorizationServerResourceName` | string | The Api Management Service Authorization Server Name |
| `apimServiceAuthorizationServerResourceGroup` | string | The name of the Resource Group with the Api Management Service Authorization Server |
| `apimServiceAuthorizationServerResourceId` | string | The Resource Id of the Api Management Service Authorization Server |

## Considerations

- _None_

## Additional resources

- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
- [Azure Resource Manager template reference](https://docs.microsoft.com/en-us/azure/templates/)
- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2020-06-01/deployments)
- [Service/authorizationServerS](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service/authorizationServers)