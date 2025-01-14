# Api Management Service Apis

This module deploys Api Management Service Apis.

## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.ApiManagement/service/apis/policies` | 2020-06-01-preview | 
| `Microsoft.ApiManagement/service/apis` | 2020-06-01-preview |
| `Microsoft.ApiManagement/service/apiVersionSets` | 2020-06-01-preview |
| `Microsoft.Resources/deployments` | 2020-06-01 |

### Resource dependency

The following resources are required to be able to deploy this resource.

- `Microsoft.ApiManagement/service`

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `apiManagementServiceApiName` | string |  |  | Required. API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. |
| `apiManagementServiceApiPolicy` | object |  |  | Optional. Policies to apply to the Service Api. |
| `apiManagementServiceName` | string |  |  | Required. The name of the of the Api Management service. |
| `apiRevision` | string |  |  | Optional. Describes the Revision of the Api. If no value is provided, default revision 1 is created |
| `apiRevisionDescription` | string |  |  | Optional. Description of the Api Revision. |
| `apiType` | string | http | System.Object[] | Optional. Type of Api to create. * http creates a SOAP to REST API * soap creates a SOAP pass-through API. |
| `apiVersion` | string |  |  | Optional. Indicates the Version identifier of the API if the API is versioned |
| `apiVersionDescription` | string |  |  | Optional. Description of the Api Version. |
| `apiVersionSet` | object |  |  | Optional. Version set details |
| `authenticationSettings` | object |  |  | Optional. Collection of authentication settings included into this API. |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `apiDescription` | string |  |  | Optional. Description of the API. May include HTML formatting tags. |
| `displayName` | string |  |  | Required. API name. Must be 1 to 300 characters long. |
| `format` | string | openapi | System.Object[] | Optional. Format of the Content in which the API is getting imported. |
| `isCurrent` | bool | True |  | Optional. Indicates if API revision is current api revision. |
| `location` | string | [resourceGroup().location] |  | Optional. Location for all Resources. |
| `path` | string |  |  | Required. Relative URL uniquely identifying this API and all of its resource paths within the API Management service instance. It is appended to the API endpoint base URL specified during the service instance creation to form a public URL for this API. |
| `protocols` | array | System.Object[] |  | Optional. Describes on which protocols the operations in this API can be invoked. - http or https |
| `serviceUrl` | string |  |  | Optional. Absolute URL of the backend service implementing this API. Cannot be more than 2000 characters long. |
| `sourceApiId` | string |  |  | Optional. API identifier of the source API. |
| `subscriptionKeyParameterNames` | object |  |  | Optional. Protocols over which API is made available. |
| `subscriptionRequired` | bool | False |  | Optional. Specifies whether an API or Product subscription is required for accessing the API. |
| `type` | string | http | System.Object[] | Optional. Type of API. |
| `value` | string |  |  | Optional. Content value when Importing an API. |
| `wsdlSelector` | object |  |  | Optional. Criteria to limit import of WSDL to a subset of the document. |

### Parameter Usage: `apiVersionSet`

```json
"apiVersionSet":{
    "value":{
        "name":"", //Required. Api Version Set identifier. Must be unique in the current API Management service instance.
        "properties":{
            "description": "string", //Description of API Version Set.
            "versionQueryName": "string", //Optional. Name of query parameter that indicates the API Version if versioningScheme is set to query.
            "versionHeaderName": "string", //Optional. Name of HTTP header parameter that indicates the API Version if versioningScheme is set to header.
            "displayName": "string", //Required. Name of API Version Set
            "versioningScheme": "string" //Required. An value that determines where the API Version identifer will be located in a HTTP request. - Segment, Query, Header
        }
    }
}
```

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `apimServiceApiName` | string | The Api Management Service API Name |
| `apimServiceApiResourceGroup` | string | The name of the Resource Group with the Api Management Service API |
| `apimServiceApiResourceId` | string | The Resource Id of the Api Management Service API |

## Considerations

- _None_

## Additional resources

- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
- [Azure Resource Manager template reference](https://docs.microsoft.com/en-us/azure/templates/)
- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2020-06-01/deployments)
- [Service/apiVerSionSetS](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service/apiVersionSets)
- [Service/apiS](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service/apis)
- [Service/apiS/policieS](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service/apis/policies)