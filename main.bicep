// command to deploy: az deployment sub create -f ./main.bicep -l eastus
targetScope = 'subscription'

param location string = deployment().location
var baseName = 'forrester22'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aks-rg'
  location: location
}

module sshKey 'br/building-blocks:ssh-keygen:1.0' = {
  scope: rg
  
  name: 'sshKeyGen'
  params: {
    passphrase: 'foobar'
  }
}

module aksDeploy 'br/building-blocks:aks-app:1.1' = {
  scope: rg
  
  name: 'aksDeploy'
  params: {
    // might be good to have these parameters empty and fill them in as part of the demo
    // that will show off intellisense w/o having to author the whole block of code
    baseName: baseName
    adminUsername: 'admin001'
    sshKey: sshKey.outputs.publicKey
  }
}
