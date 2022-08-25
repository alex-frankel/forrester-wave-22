param baseName string

// has to be a param...
param startDate string = '${utcNow('yyyy')}-${utcNow('MM')}-01T00:00:00Z'
resource budget 'Microsoft.Consumption/budgets@2019-05-01' = {
  name: '${baseName}budget'
  properties: {
    category: 'Cost'
    amount: 500
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: startDate
      endDate: ''
    }
    filter: {}
    notifications: {
      basic: {
        contactEmails: [
          'adminemail@contoso.org'
        ]
        enabled: true
        operator: 'GreaterThan'
        threshold: 100
        thresholdType: 'Actual'
      }
    }
  }
}
