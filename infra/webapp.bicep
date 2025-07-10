//param webAppName string = uniqueString(resourceGroup().id) // Generate unique String for web app name
param sku string = 'S1' // The SKU of App Service Plan
//param location string = resourceGroup().location
param webAppName string
param location string

output echoedWebAppName string = webAppName
output echoedLocation string = location

var appServicePlanName = toLower('AppServicePlan-${webAppName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'AppServicePlan-devops-webapp-eastus-199622013'
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
}
resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: 'devops-webapp-eastus-199622013'
  kind: 'app'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Development'
        }
        {
          name: 'UseOnlyInMemoryDatabase'
          value: 'true'
        }
      ]
    }
  }
}
