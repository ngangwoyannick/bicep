
@description('Nom du réseau virtuel')
param vnetName string = 'VNet1'

@description('Espace d\'adressage du réseau virtuel')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Nom du sous-réseau')
param subnetName string = 'Subnet1'

@description('Espace d\'adressage du sous-réseau')
param subnetAddressPrefix string = '10.0.1.0/24'

@description('Emplacement des ressources')
param location string = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output subnetId string = vnet.properties.subnets[0].id
