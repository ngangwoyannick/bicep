# create vnet name Vnet1
az group create --name net1 --location East US

# preview changes
az deployment group what-if --resource-group user-qbfqmgsngqxr \
   --template-file Create_Vnet.bicep \
   --parameters vnetName='VNet1'

# deploy the web app using Bicep
az deployment group create --resource-group user-qbfqmgsngqxr \
   --template-file Create_Vnet.bicep \
   --parameters vnetName='VNet1'