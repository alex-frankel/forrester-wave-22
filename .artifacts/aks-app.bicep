param location string = resourceGroup().location
param baseName string
param adminUsername string
param sshKey string
param policyEnabled bool = false

resource aks 'Microsoft.ContainerService/managedClusters@2022-06-01' = {
  name: '${baseName}app'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    kubernetesVersion: '1.24.3'
    dnsPrefix: baseName
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 3
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: adminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshKey
          }
        ]
      }
    }
    addonProfiles: {
      azurepolicy: {
        enabled: policyEnabled
      }
    }
  }
}
