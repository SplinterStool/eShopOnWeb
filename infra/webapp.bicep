param sku string = 'F1' // The SKU of App Service Plan

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'AppServicePlan-devops-webapp-westus2-199622013'
  location: 'westus2'
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
}
resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: 'devops-webapp-westus2-199622013'
  location: 'westus2'
  kind: 'app'
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
