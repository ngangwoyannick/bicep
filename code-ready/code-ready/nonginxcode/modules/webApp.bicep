param location string = 'westus3'

param namePrefix string = 'paulon'
param appPlanId string

resource webApplication 'Microsoft.Web/sites@2022-03-01' = {
  name: '${namePrefix}-site'
  location: location

  properties: {
    serverFarmId: appPlanId
    httpsOnly: true
  }
}
output siteUrl string = webApplication.properties.hostNames[0]
