param location string = 'westus3'
//param location1 string = resourceGroup().location
param namePrefix string = 'paulox'
param dockerImage string = 'nginxdemos/hello'
param dockerImageTag string = 'latest'
param appPlanId string


resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: '${namePrefix}site'
  location: location
  properties: {
    serverFarmId: appPlanId
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVICE_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
      ]
      linuxFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
      //linuxFxVersion: 'DOCKER|yourACRName.azurecr.io/nginx:latest'
      // Additional Web App configurations
    }
  }
}
//output the site url
output siteUrl string = webApp.properties.hostNames[0]
