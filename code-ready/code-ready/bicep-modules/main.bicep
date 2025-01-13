param location string = 'westus3'
param storageName string = 'spacetestapp'

param namePrefix string = 'paulon'

param dockerImage string = 'nginx' //'nginxdemos/hello'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

//how do consume modules
module storage 'modules/storage.bicep' = {
  name: storageName
  params: {
    storageName: storageName
    location: location
  }
}

module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: '${namePrefix}-appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location

  }
}

module deployWebsite 'modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-website'
  params: {
    location: location
    appPlanId: appPlanDeploy.outputs.planId
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
  }

}
output siteUrl string = deployWebsite.outputs.siteUrl

// param location string = resourceGroup().location
// param storageName string = 'space${uniqueString(resourceGroup().id)}'

// resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
//   name: storageName
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Premium_LRS' //different sizes for our resource
//   }
//   properties: {
//     accessTier: 'Hot'
//   }

// }

// resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
//   name: 'xyz${storageName}'
//   location:location
//   sku:{
//     name: 'F1'
//   }
// }

// resource webApplication 'Microsoft.Web/sites@2022-03-01' = {
//   name: 'zed${storageName}'
//   location: location
//   properties: {
//     serverFarmId: appServicePlan.id
//     httpsOnly: true
//   }
// }

//Data types
// arrays, bool, int, object, string

var nameArray = [
  'James'
  'Andrew'
  3
  0
]
var person = {
  name: 'Jay'
  lastName: 'Rite'
  age: 34
  isMarried: false
  educations: {
    college: 'UW'
    year: 1987
  }
}

output result string = person.educations.college
