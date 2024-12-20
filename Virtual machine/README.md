# create virtual machine vm1


# preview changes
az deployment group what-if --resource-group user-qbfqmgsngqxr \
   --template-file Create_vm.bicep \
   --parameters vmName='VM1'

# deploy the web app using Bicep
az deployment group create --resource-group user-qbfqmgsngqxr \
   --template-file Create_vm.bicep \
   --parameters vmName='VM1'