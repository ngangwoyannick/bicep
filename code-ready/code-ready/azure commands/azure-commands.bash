#create az group:
az group create -g NameOfGroup -l westus3

#Create resource group deployment and deploy
az deployment group create -g MyFirstDemo -f main.bicep
#subscription deployment
az deployment sub create --name <deployment-name> --location <location> --template-file <path-to-bicep>

#management group deployments
az deployment mg create --name <deployment-name> --management-group-id <mgid> --template-file <path-to-bicep>
#az build a json file
az bicep build -f filename.bicep

#upgrade
az bicep upgrade

#version
az bicep version

#
#clean up - delete resource group
az group delete --name exampleGroup

#azure Service principal setup
az ad sp create-for-rbac --name "YourSPName" --role contributor --scopes /subscriptions/yourSubscriptionId
