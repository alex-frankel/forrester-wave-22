param location string = resourceGroup().location
param newGuid string = sys.newGuid()
param passphrase string

resource scriptName 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'createSshKey'
  location: location
  kind: 'AzureCLI'
  properties: {
    forceUpdateTag: newGuid
    azCliVersion: '2.0.80'
    timeout: 'PT30M'
    retentionInterval: 'P1D'
    cleanupPreference: 'OnSuccess'
    arguments: passphrase
    scriptContent: loadTextContent('keygen.sh')
  }
}

output publicKey string = scriptName.properties.outputs.keyinfo.publicKey
output status object = scriptName.properties.status
