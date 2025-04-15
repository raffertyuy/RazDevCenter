@description('Name of the app')
param name string = ''

@description('Location to deploy the environment resources')
param location string = resourceGroup().location

var resourceName = !empty(name) ? replace(name, ' ', '-') : 'a${uniqueString(resourceGroup().id)}'

@description('Tags to apply to environment resources')
param tags object = {}

var uniqueName = uniqueString(resourceGroup().id, subscription().id)
var sqlAdministratorUser = 'eshopOnWebAdmin'
var sqlAdministratorLoginPassword = '${uniqueName}${uniqueName}5!'
var keyVaultName = 'vault-${uniqueName}'
var databaseNames = [
  'Catalog'
  'Identity'
]

module sql 'modules/sql.bicep' = {
  name: 'sql'
  params: {
    sqlAdministratorLoginUser: sqlAdministratorUser
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
    tags: tags
    databaseNames: databaseNames
  }
}

module appInsights 'modules/applicationInsights.bicep' ={
  name: 'appInsights'
  params: {
    tags: tags
  }  
}

module keyVault 'modules/keyVault.bicep' = {
  name: 'keyVault'
  params: {
    keyVaultName: keyVaultName
    sqlAdministratorLoginUser: sqlAdministratorUser
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
    databaseNames: databaseNames
    sqlServerFullyQualifiedDomainName: sql.outputs.sqlServerFullyQualifiedDomainName
    tags: tags
  }
}

module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    tags: tags
    databaseNames: databaseNames
    keyVaultUri: keyVault.outputs.endpoint
    applicationInsightsConnectionString: appInsights.outputs.connectionString
  }
}

module keyVaultAssignment 'modules/keyVaultAssignment.bicep' = {
  name: 'keyVaultAssignment'
  params: {
    keyVaultName: keyVaultName
    appServicePrincipalId: appService.outputs.principalId
  }
}


output AZURE_APP_URL string = appService.outputs.webAppUrl
output AZURE_SQL_FQDN string = sql.outputs.sqlServerFullyQualifiedDomainName
output SQL_ADMIN_LOGIN string = sqlAdministratorUser
#disable-next-line outputs-should-not-contain-secrets
output SQL_ADMIN_PASSWORD string = sqlAdministratorLoginPassword
