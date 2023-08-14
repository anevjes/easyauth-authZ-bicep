param appSvcName string = '<yourWebAppName>'
param clientId string = '<your-registered-clientid>'
param clientSecretSettingName string = 'AUTH_CLIENT_SECRET'
param allowedIdentityObjectIds array = ['<objectId-For_User>']




resource webApp 'Microsoft.Web/sites@2022-03-01' existing = {
  name: appSvcName

  resource authConfig 'config' = {
    name: 'authsettingsV2'
    properties: {
      globalValidation: {
        redirectToProvider: 'AzureActiveDirectory'
        requireAuthentication: true
        unauthenticatedClientAction: 'RedirectToLoginPage'
      }
      login: {
        tokenStore: {
          enabled: true
        }
      }
      platform: {
        enabled: true
        runtimeVersion:'~1'
      }
      identityProviders: {
        azureActiveDirectory: {
          enabled: true
          login: {
            disableWWWAuthenticate:false
          }
          registration: {
            clientId: clientId
            clientSecretSettingName: clientSecretSettingName
            openIdIssuer: 'https://sts.windows.net/${tenant().tenantId}/v2.0'
          }
          validation: {
            jwtClaimChecks:null
                    allowedAudiences: [clientId]
                    defaultAuthorizationPolicy: {
                      allowedApplications: [clientId]
                      allowedPrincipals: {
                        identities: allowedIdentityObjectIds
                      }
                    }
                  }
      }
    }
  }
}
}
