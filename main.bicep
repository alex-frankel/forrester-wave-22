targetScope = 'subscription'

param location string = deployment().location

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aks-rg'
  location: location
}

module sshKey 'ssh-keygen.bicep' = {
  scope: rg
  
  name: 'sshKeyGen'
  params: {
    location: location
    passphrase: 'foobar'
  }
}

module aksDeploy 'aks-app.bicep' = {
  scope: rg
  
  name: 'aksDeploy'
  params: {
    location: location
    sshKey: sshKey.outputs.publicKey
  }
}
