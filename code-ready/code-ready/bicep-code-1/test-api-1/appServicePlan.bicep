param namePrefix string
param location string = resourceGroup().location
param sku string = 'B1'
//service plan (what is this and why we need this?)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${namePrefix}-website'
  location: location
  kind: 'linux'
  sku: {
    name: sku //B1-basic tiers need to learn about this!
  }
  properties: {
    reserved: true //so that appservice can run on linux

  }

}
output planId string = appServicePlan.id //we output the serviceplan id
