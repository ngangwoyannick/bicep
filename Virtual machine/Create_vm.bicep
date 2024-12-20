
@description('Nom de la machine virtuelle')
param vmName string = 'VM1'

@description('Nom du réseau virtuel')
param vnetName string = 'VM1'

@description('Espace d\'adressage du réseau virtuel')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Nom du sous-réseau')
param subnetName string = 'mySubnet'

@description('Espace d\'adressage du sous-réseau')
param subnetAddressPrefix string = '10.0.1.0/24'

@description('Nom de l\'interface réseau')
param nicName string = 'myNIC'

@description('Nom du compte de stockage pour le disque de système d\'exploitation')
param storageAccountName string = 'myvmstorage'

@description('Taille de la machine virtuelle')
param vmSize string = 'Standard_DS1_v2'

@description('Nom d\'utilisateur administrateur')
param adminUsername string = 'azureuser'

@description('Mot de passe administrateur')
@secure()
param adminPassword string

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

resource nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
  }
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-03-01' = {
  name: 'myPublicIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

output vmId string = vm.id
output nicId string = nic.id
output publicIPId string = publicIP.id
