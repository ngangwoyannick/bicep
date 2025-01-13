param location string = 'westus3'
param namePrefix string = 'paulox'
param dockerImage string = 'nginx' //'nginxdemos/hello'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

//consuming modules!
module appPlanDeploy 'appServicePlan.bicep' = {
  name: 'appPlanDeploy'
  params: {
    namePrefix: 'paulo'
    location: location

  }
}

module deploySite 'site.bicep' = {
  name: 'deploy-my-site'
  params: {
    appPlanId: appPlanDeploy.outputs.planId
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
    location: location
    namePrefix: namePrefix

  }

}
output siteurl string = deploySite.outputs.siteUrl

// resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
//   name: sname
//   location: location
//   properties: {

//   }
// }

//service plan (what is this and why we need this?)
//App Service is an HTTP-based service for hosting web applications
// resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
//   name: sname
//   location: location
//   kind: 'linux'
//   sku: {
//     name: 'B1' //B1-basic tiers need to learn about this!
//   }
//   properties: {
//     reserved: true //so that appservice can run on linux

//   }

// }
//output planId string = appServicePlan.id //we output the serviceplan id

// resource webApp 'Microsoft.Web/sites@2021-02-01' = {
//   name: '${namePrefix}site'
//   location: location
//   properties: {
//     serverFarmId: appServicePlan.id
//     siteConfig: {
//       appSettings: [
//         {
//           name: 'DOCKER_REGISTRY_SERVICE_URL'
//           value: 'https://index.docker.io'
//         }
//         {
//           name: 'DOCKER_REGISTRY_SERVER_USERNAME'
//           value: ''
//         }
//         {
//           name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
//           value: ''
//         }
//         {
//           name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
//           value: 'false'
//         }
//       ]
//       linuxFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
//       //linuxFxVersion: 'DOCKER|yourACRName.azurecr.io/nginx:latest'
//       // Additional Web App configurations
//     }
//   }
// }
// //output the site url
// output siteUrl string = webApp.properties.hostNames[0]
