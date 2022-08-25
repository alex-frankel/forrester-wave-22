// command to deploy: az deployment sub create -f ./main.bicep -l eastus
targetScope = 'subscription'

param location string = 'westus'

var baseName = 'forrester-wave-22'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${baseName}-aks-app'
  location: location
}

module sshKey 'br/building-blocks:ssh-keygen:1.3' = {
  scope: rg
  
  name: 'sshKeyGen'
  params: {
    passphrase: baseName
  }
}

module aksDeploy 'br/building-blocks:aks-app:1.5' = {
  scope: rg
  
  name: 'aksDeploy'
  params: {
    adminUsername: 'admin001'
    baseName: baseName
    sshKey: sshKey.outputs.publicKey
    policyEnabled: true
    costControlsEnabled: true
  }
}
