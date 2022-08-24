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
    retentionInterval: 'P7D' // script will not re-run for 7 days
    cleanupPreference: 'OnSuccess'
    arguments: passphrase
    scriptContent: loadTextContent('keygen.sh')
  }
}

output publicKey string = scriptName.properties.outputs.keyinfo.publicKey
output status object = scriptName.properties.status
