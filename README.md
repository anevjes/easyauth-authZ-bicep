# easyauth-authZ-bicep
Simple example of tightening up the easy auth provider in app services to include some basic authZ against specific objectIDs from AAD



```powershell
az deployment group create --resource-group "bsl-sample-easyauth_group" --name easyauthupdate1 \
    --template-file app-servce-auth.bicep
```