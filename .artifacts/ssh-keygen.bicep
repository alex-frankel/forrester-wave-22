// from this quickstart example:
// https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.resources/deployment-script-ssh-key-gen

param location string = resourceGroup().location
param passphrase string

resource scriptName 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'createSshKey'
  location: location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.0.80'
    timeout: 'PT30M'
    retentionInterval: 'P1D' // script will not re-run for 24 hours
    cleanupPreference: 'OnSuccess'
    arguments: passphrase
    scriptContent: loadTextContent('keygen.sh')
  }
}

@description('SSH Public Key that can be used to with an AKS cluster or Virtual Machine')
output publicKey string = scriptName.properties.outputs.keyinfo.publicKey
output status object = scriptName.properties.status
