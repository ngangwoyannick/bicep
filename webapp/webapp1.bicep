//creating my first webapp with bicep

//1-Creating an app service plan to deploy my webapp

param location string = resourceGroup().location
param appServicePlanName string ='myserviceplan'
//param appServicePlan string ='myserviceplan'
resource appServicePlan 'microsoft.web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku:{
    name: 'F1'
  }
}


//2-Create my webapp 

resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
  name: 'frondendWeb'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
/*
//define website1 setting

resource website1Setting 'Microsoft.Web/sites/config@2023-01-01' = {
  parent: website1
  name: 'appsettings'
  properties: {
    enableAwesomeFeature: 'true'
  }
}
*/
