@description('This is a description for namePrefix')
param namePrefix string
param location string = resourceGroup().location
param sku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${namePrefix}-website'
  location: location
  kind: 'linux'
  sku: {
    name: sku
  }
  properties: {
    reserved: true
  }

}
output planId string = appServicePlan.id
