param appSvcName string = 'anevjes-sample-easyauth'
param clientId string = 'insertYourClientId'
param clientSecretSettingName string = 'MICROSOFT_PROVIDER_AUTHENTICATION_SECRET'
param allowedGroupObjectIds array = [
  'objectIdofGroup'
]
param allowedIdentityObjectIds array = []




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
      }
      identityProviders: {
        azureActiveDirectory: {
          enabled: true
          login: {
            loginParameters: []
          }
          registration: {
            clientId: clientId
            clientSecretSettingName: clientSecretSettingName
            openIdIssuer: 'https://sts.windows.net/${tenant().tenantId}/v2.0'
          }
          validation: {
                    allowedAudiences: [
                    ]
                    defaultAuthorizationPolicy: {
                      allowedApplications: [
                      ]
                      allowedPrincipals: {
                        groups: allowedGroupObjectIds
                        
                        identities: allowedIdentityObjectIds
                      }
                    }
                  }
      }
    }
  }
}
}
