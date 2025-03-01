targetScope = 'subscription'

@description('Required. The name of the Resource Group')
param resourceGroupName string

@description('Optional. Location of the Resource Group. It uses the deployment\'s location when not provided.')
param location string = deployment().location

@allowed([
  'CanNotDelete'
  'NotSpecified'
  'ReadOnly'
])
@description('Optional. Specify the type of lock.')
param lock string = 'NotSpecified'

@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'')
param roleAssignments array = []

@description('Optional. Tags of the storage account resource.')
param tags object = {}

var builtInRoleNames = {
  AcrDelete: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c2f4ef07-c644-48eb-af81-4b1b4947fb11')
  AcrImageSigner: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '6cef56e8-d556-48e5-a04f-b8e64114680f')
  AcrPull: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d')
  AcrPush: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8311e382-0749-4cb8-b61a-304f252e45ec')
  AcrQuarantineReader: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'cdda3590-29a3-44f6-95f2-9f980659eb04')
  AcrQuarantineWriter: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c8d4ff99-41c3-41a8-9f60-21dfdad59608')
  'API Management Service Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '312a565d-c81f-4fd8-895a-4e21e48d571c')
  'API Management Service Operator Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e022efe7-f5ba-4159-bbe4-b44f577e9b61')
  'API Management Service Reader Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '71522526-b88f-4d52-b57f-d31fc3546d0d')
  'App Configuration Data Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5ae67dd6-50cb-40e7-96ff-dc2bfa4b606b')
  'App Configuration Data Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '516239f1-63e1-4d78-a4de-a74fb236a071')
  'Application Insights Component Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ae349356-3a1b-4a5e-921d-050484c6347e')
  'Application Insights Snapshot Debugger': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '08954f03-6346-4c2e-81c0-ec3a5cfae23b')
  'Attestation Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'bbf86eb8-f7b4-4cce-96e4-18cddf81d86e')
  'Attestation Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'fd1bd22b-8476-40bc-a0bc-69b95687b9f3')
  'Automation Job Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4fe576fe-1146-4730-92eb-48519fa6bf9f')
  'Automation Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'd3881f73-407a-4167-8283-e981cbba0404')
  'Automation Runbook Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5fb5aef8-1081-4b8e-bb16-9d5d0385bab5')
  'Avere Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4f8fab4f-1852-4a58-a46a-8eaf358af14a')
  'Avere Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c025889f-8102-4ebf-b32c-fc0c6f0c6bd9')
  'Azure Connected Machine Onboarding': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b64e21ea-ac4e-4cdf-9dc9-5b892992bee7')
  'Azure Connected Machine Resource Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'cd570a14-e51a-42ad-bac8-bafd67325302')
  'Azure Digital Twins Owner (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'bcd981a7-7f74-457b-83e1-cceb9e632ffe')
  'Azure Digital Twins Reader (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'd57506d4-4c8d-48b1-8587-93c323f6a5a3')
  'Azure Event Hubs Data Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f526a384-b230-433a-b45c-95f59c4a2dec')
  'Azure Event Hubs Data Receiver': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a638d3c7-ab3a-418d-83e6-5f17a39d4fde')
  'Azure Event Hubs Data Sender': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2b629674-e913-4c01-ae53-ef4638d8f975')
  'Azure Kubernetes Service Cluster Admin Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '0ab0b1a8-8aac-4efd-b8c2-3ee1fb270be8')
  'Azure Kubernetes Service Cluster User Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4abbcc35-e782-43d8-92c5-2d3f1bd2253f')
  'Azure Kubernetes Service Contributor Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8')
  'Azure Maps Data Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8f5e0ce6-4f7b-4dcf-bddf-e6f48634a204')
  'Azure Maps Data Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '423170ca-a8f6-4b0f-8487-9e4eb8f49bfa')
  'Azure Sentinel Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ab8e14d6-4a74-4a29-9ba8-549422addade')
  'Azure Sentinel Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8d289c81-5878-46d4-8554-54e1e3d8b5cb')
  'Azure Sentinel Responder': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3e150937-b8fe-4cfb-8069-0eaf05ecd056')
  'Azure Service Bus Data Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '090c5cfd-751d-490a-894a-3ce6f1109419')
  'Azure Service Bus Data Receiver': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4f6d3b9b-027b-4f4c-9142-0e5a2a2247e0')
  'Azure Service Bus Data Sender': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '69a216fc-b8fb-44d8-bc22-1f3c2cd27a39')
  'Azure Stack Registration Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '6f12a6df-dd06-4f3e-bcb1-ce8be600526a')
  'Backup Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5e467623-bb1f-42f4-a55d-6e525e11384b')
  'Backup Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '00c29273-979b-4161-815c-10b084fb9324')
  'Backup Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a795c7a0-d4a2-40c1-ae25-d81f01202912')
  'Billing Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'fa23ad8b-c56e-40d8-ac0c-ce449e1d2c64')
  'BizTalk Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5e3c6656-6cfa-4708-81fe-0de47ac73342')
  'Blockchain Member Node Access (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '31a002a1-acaf-453e-8a5b-297c9ca1ea24')
  'Blueprint Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '41077137-e803-4205-871c-5a86e6a753b4')
  'Blueprint Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '437d2ced-4a38-4302-8479-ed2bcb43d090')
  'CDN Endpoint Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '426e0c7f-0c7e-4658-b36f-ff54d6c29b45')
  'CDN Endpoint Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '871e35f6-b5c1-49cc-a043-bde969a0f2cd')
  'CDN Profile Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ec156ff8-a8d1-4d15-830c-5b80698ca432')
  'CDN Profile Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8f96442b-4075-438f-813d-ad51ab4019af')
  'Classic Network Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b34d265f-36f7-4a0d-a4d4-e158ca92e90f')
  'Classic Storage Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '86e8f5dc-a6e9-4c67-9d15-de283e8eac25')
  'Classic Storage Account Key Operator Service Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '985d6b00-f706-48f5-a6fe-d0ca12fb668d')
  'Classic Virtual Machine Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'd73bb868-a0df-4d4d-bd69-98a00b01fccb')
  'ClearDB MySQL DB Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '9106cda0-8a86-4e81-b686-29a22c54effe')
  'Cognitive Services Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '25fbc0a9-bd7c-42a3-aa1a-3b75d497ee68')
  'Cognitive Services Custom Vision Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c1ff6cc2-c111-46fe-8896-e0ef812ad9f3')
  'Cognitive Services Custom Vision Deployment': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5c4089e1-6d96-4d2f-b296-c1bc7137275f')
  'Cognitive Services Custom Vision Labeler': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '88424f51-ebe7-446f-bc41-7fa16989e96c')
  'Cognitive Services Custom Vision Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '93586559-c37d-4a6b-ba08-b9f0940c2d73')
  'Cognitive Services Custom Vision Trainer': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '0a5ae4ab-0d65-4eeb-be61-29fc9b54394b')
  'Cognitive Services Data Reader (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b59867f0-fa02-499b-be73-45a86b5b3e1c')
  'Cognitive Services QnA Maker Editor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f4cc2bf9-21be-47a1-bdf1-5c5804381025')
  'Cognitive Services QnA Maker Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '466ccd10-b268-4a11-b098-b4849f024126')
  'Cognitive Services User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a97b65f3-24c7-4388-baec-2e87135dc908')
  Contributor: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  'Cosmos DB Account Reader Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'fbdf93bf-df7d-467e-a4d2-9458aa1360c8')
  'Cosmos DB Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '230815da-be43-4aae-9cb4-875f7bd000aa')
  CosmosBackupOperator: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'db7b14f2-5adf-42da-9f96-f2ee17bab5cb')
  'Cost Management Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '434105ed-43f6-45c7-a02f-909b2ba83430')
  'Cost Management Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '72fafb9e-0641-4937-9268-a91bfd8191a3')
  'Data Box Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'add466c9-e687-43fc-8d98-dfcf8d720be5')
  'Data Box Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '028f4ed7-e2a9-465e-a8f4-9c0ffdfdc027')
  'Data Factory Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '673868aa-7521-48a0-acc6-0f60742d39f5')
  'Data Lake Analytics Developer': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '47b7735b-770e-4598-a7da-8b91488b4c88')
  'Data Purger': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '150f5e0c-0603-4f03-8c7f-cf70034c4e90')
  'Desktop Virtualization User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '1d18fff3-a72a-46b5-b4a9-0b38a3cd7e63')
  'DevTest Labs User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '76283e04-6283-4c54-8f91-bcf1374a3c64')
  'DNS Zone Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'befefa01-2a29-4197-83a8-272ff33ce314')
  'DocumentDB Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5bd9cd88-fe45-4216-938b-f97437e15450')
  'EventGrid EventSubscription Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '428e0ff0-5e57-4d9c-a221-2c70d0e0a443')
  'EventGrid EventSubscription Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2414bbcf-6497-4faf-8c65-045460748405')
  'Experimentation Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f646f1b-fa08-80eb-a33b-edd6ce5c915c')
  'Experimentation Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f646f1b-fa08-80eb-a22b-edd6ce5c915c')
  'Experimentation Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '49632ef5-d9ac-41f4-b8e7-bbe587fa74a1')
  'FHIR Data Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5a1fc7df-4bf1-4951-a576-89034ee01acd')
  'FHIR Data Exporter': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3db33094-8700-4567-8da5-1501d4e7e843')
  'FHIR Data Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4c8d0bbc-75d3-4935-991f-5f3c56d81508')
  'FHIR Data Writer': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3f88fce4-5892-4214-ae73-ba5294559913')
  'Graph Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b60367af-1334-4454-b71e-769d9a4f83d9')
  'HDInsight Cluster Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '61ed4efc-fab3-44fd-b111-e24485cc132a')
  'HDInsight Domain Services Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8d8d5a11-05d3-4bda-a417-a08778121c7c')
  'Hierarchy Settings Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '350f8d15-c687-4448-8ae1-157740a3936d')
  'Hybrid Server Onboarding': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5d1e5ee4-7c68-4a71-ac8b-0739630a3dfb')
  'Hybrid Server Resource Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '48b40c6e-82e0-4eb3-90d5-19e40f49b624')
  'Integration Service Environment Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a41e2c5b-bd99-4a07-88f4-9bf657a760b8')
  'Integration Service Environment Developer': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c7aa55d3-1abb-444a-a5ca-5e51e485d6ec')
  'Intelligent Systems Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '03a6d094-3444-4b3d-88af-7477090a9e5e')
  'Key Vault Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f25e0fa2-a7c8-4377-a976-54943a77a395')
  'Knowledge Consumer': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ee361c5d-f7b5-4119-b4b6-892157c8f64c')
  'Kubernetes Cluster - Azure Arc Onboarding': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '34e09817-6cbe-4d01-b1a2-e0eac5743d41')
  'Lab Creator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b97fb8bc-a8b2-4522-a38b-dd33c7e65ead')
  'Log Analytics Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '92aaf0da-9dab-42b6-94a3-d43ce8d16293')
  'Log Analytics Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '73c42c96-874c-492b-b04d-ab87d138a893')
  'Logic App Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '87a39d53-fc1b-424a-814c-f7e04687dc9e')
  'Logic App Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '515c2055-d9d4-4321-b1b9-bd0c9a0f79fe')
  'Managed Application Contributor Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '641177b8-a67a-45b9-a033-47bc880bb21e')
  'Managed Application Operator Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c7393b34-138c-406f-901b-d8cf2b17e6ae')
  'Managed Applications Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b9331d33-8a36-4f8c-b097-4f54124fdb44')
  'Managed Identity Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e40ec5ca-96e0-45a2-b4ff-59039f2c2b59')
  'Managed Identity Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f1a07417-d97a-45cb-824c-7a7467783830')
  'Managed Services Registration assignment Delete ': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '91c1777a-f3dc-4fae-b103-61d183457e46')
  'Management Group Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5d58bcaf-24a5-4b20-bdb6-eed9f69fbe4c')
  'Management Group Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ac63b705-f282-497d-ac71-919bf39d939d')
  'Marketplace Admin': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'dd920d6d-f481-47f1-b461-f338c46b2d9f')
  'Monitoring Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '749f88d5-cbae-40b8-bcfc-e573ddc772fa')
  'Monitoring Metrics Publisher': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')
  'Monitoring Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '43d0d8ad-25c7-4714-9337-8ba259a9fe05')
  'Network Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4d97b98b-1d4f-4787-a291-c67834d212e7')
  'New Relic APM Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5d28c62d-5b37-4476-8438-e587778df237')
  'Object Understanding Account Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4dd61c23-6743-42fe-a388-d8bdd41cb745')
  Owner: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  'Policy Insights Data Writer (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '66bb4e9e-b016-4a94-8249-4c0511c2be84')
  'Private DNS Zone Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b12aa53e-6015-4669-85d0-8515ebb3ae7f')
  Reader: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  'Reader and Data Access': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c12c1c16-33a1-487b-954d-41c89c60f349')
  'Redis Cache Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e0f68234-74aa-48ed-b826-c38b57376e17')
  'Remote Rendering Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3df8b902-2a6f-47c7-8cc5-360e9b272a7e')
  'Remote Rendering Client': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'd39065c4-c120-43c9-ab0a-63eed9795f0a')
  'Resource Policy Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '36243c78-bf99-498c-9df9-86d9f8d28608')
  'Scheduler Job Collections Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '188a0f2f-5c9e-469b-ae67-2aa5ce574b94')
  'Search Service Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7ca78c08-252a-4471-8644-bb5ff32d4ba0')
  'Security Admin': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'fb1c8493-542b-48eb-b624-b4c8fea62acd')
  'Security Assessment Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '612c2aa1-cb24-443b-ac28-3ab7272de6f5')
  'Security Manager (Legacy)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e3d13bf0-dd5a-482e-ba6b-9b8433878d10')
  'Security Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '39bc4728-0917-49c7-9d2c-d95423bc2eb4')
  'SignalR AccessKey Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '04165923-9d83-45d5-8227-78b77b0a687e')
  'SignalR Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8cf5e20a-e4b2-4e9d-b3a1-5ceb692c2761')
  'Site Recovery Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '6670b86e-a3f7-4917-ac9b-5d6ab1be4567')
  'Site Recovery Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '494ae006-db33-4328-bf46-533a6560a3ca')
  'Site Recovery Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'dbaa88c4-0c30-4179-9fb3-46319faa6149')
  'Spatial Anchors Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8bbe83f1-e2a6-4df7-8cb4-4e04d4e5c827')
  'Spatial Anchors Account Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '70bbe301-9835-447d-afdd-19eb3167307c')
  'Spatial Anchors Account Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '5d51204f-eb77-4b1c-b86a-2ec626c49413')
  'SQL DB Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '9b7fa17d-e63e-47b0-bb0a-15c516ac86ec')
  'SQL Managed Instance Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4939a1f6-9ae0-4e48-a1e0-f2cbe897382d')
  'SQL Security Manager': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '056cd41c-7e88-42e1-933e-88ba6a50c9c3')
  'SQL Server Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '6d8ee4ec-f05a-4a1d-8b00-a9b17e38b437')
  'Storage Account Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '17d1049b-9a84-46fb-8f53-869881c3d3ab')
  'Storage Account Key Operator Service Role': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '81a9662b-bebf-436f-a333-f67b29880f12')
  'Storage Blob Data Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
  'Storage Blob Data Owner': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b')
  'Storage Blob Data Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1')
  'Storage Blob Delegator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'db58b8e5-c6ad-4a2a-8342-4190687cbf4a')
  'Storage File Data SMB Share Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '0c867c2a-1d8c-454a-a3db-ab2ea1bdc8bb')
  'Storage File Data SMB Share Elevated Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a7264617-510b-434b-a828-9731dc254ea7')
  'Storage File Data SMB Share Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'aba4ae5f-2193-4029-9191-0cb91df5e314')
  'Storage Queue Data Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '974c5e8b-45b9-4653-ba55-5f855dd0fb88')
  'Storage Queue Data Message Processor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8a0f0c08-91a1-4084-bc3d-661d67233fed')
  'Storage Queue Data Message Sender': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'c6a89b2d-59bc-44d0-9896-0f6e12d7b80a')
  'Storage Queue Data Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '19e7f393-937e-4f77-808e-94535e297925')
  'Support Request Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'cfd33db0-3dd1-45e3-aa9d-cdbdf3b6f24e')
  'Tag Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4a9ae827-6dc8-4573-8ac7-8239d42aa03f')
  'Traffic Manager Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'a4b10055-b0c7-44c2-b00f-c7b5b3550cf7')
  'User Access Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9')
  'Virtual Machine Administrator Login': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '1c0163c0-47e6-4577-8991-ea5c82e286e4')
  'Virtual Machine Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '9980e02c-c2be-4d73-94e8-173b1dc7cf3c')
  'Virtual Machine User Login': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'fb879df8-f326-4884-b1cf-06f3ad86be52')
  'Web Plan Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2cc479cb-7b4d-49a8-b449-8c00fd0f0a4b')
  'Website Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'de139f84-1756-47ae-9be6-808fbbe84772')
  'Workbook Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e8ddcd69-c73f-4f9f-9844-4100522f16ad')
  'Workbook Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b279062a-9be3-42a0-92ae-8b3cf002ec4d')
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2019-05-01' = {
  location: location
  name: resourceGroupName
  tags: tags
  properties: {}
}

module resourceGroup_lock './.bicep/nested_lock.bicep' = if (lock != 'NotSpecified') {
  scope: resourceGroup
  name: '${resourceGroup.name}-${lock}-lock-deployment'
  params: {
    name: '${resourceGroup.name}-${lock}-lock'
    level: lock
  }
}

module resourceGroup_rbac './.bicep/nested_rbac.bicep' = [for (roleAssignment, index) in roleAssignments: {
  name: 'rbac-${deployment().name}-${index}'
  scope: resourceGroup
  params: {
    roleAssignmentObj: roleAssignment
    builtInRoleNames: builtInRoleNames
    resourceGroupName: resourceGroup.name
  }
}]

output resourceGroupName string = resourceGroup.name
output resourceGroupResourceId string = resourceGroup.id
