param location string = resourceGroup().location

@description('Used as a prefix for resource creations')
param baseName string
param adminUsername string
param sshKey string

@description('Controls ability to govern Kubernetes control plane with Azure Policy')
param policyEnabled bool = false

@description('Determines if cost management resources for budgeting, alerting and cost dashboards will be deployed')
param costControlsEnabled bool = false

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



output costEnabled bool = costControlsEnabled
