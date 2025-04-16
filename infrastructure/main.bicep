// Parameters
param location string = 'Central India'
param appServicePlanName string = 'WatchTower-CI-ASP01'
param webAppName string = 'WatchTower-CI-WebApp01'
param prometheusAppName string = 'WatchTower-CI-prometheusApp01'
param grafanaAppName string = 'WatchTower-CI-grafanaApp01'
param prometheusImage string = 'prom/prometheus:latest' // Prometheus container image
param grafanaImage string = 'grafana/grafana:latest' // Grafana container image

// App Service Plan (Free Tier)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'P1V3'
  }
  properties: {
    reserved: true
  }
}

// Web App for E-commerce
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0' // Hosting .NET 8 app
    }
    httpsOnly: true
  }
}

// Web App for Prometheus (Containerized)
resource prometheusApp 'Microsoft.Web/sites@2022-03-01' = {
  name: prometheusAppName
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${prometheusImage}' // Prometheus Docker image
      appSettings: [
        {
          name: 'WEBSITES_PORT'
          value: '9090'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io'
        }
      ]
    }
    httpsOnly: true
  }
}

// Web App for Grafana (Containerized)
resource grafanaApp 'Microsoft.Web/sites@2022-03-01' = {
  name: grafanaAppName
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${grafanaImage}' // Grafana Docker image
      appSettings: [
        {
          name: 'WEBSITES_PORT'
          value: '3000'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io'
        }
      ]
    }
    httpsOnly: true
  }
}

// Outputs for reference
output ecommerceWebAppUrl string = 'https://${webApp.properties.defaultHostName}'
output prometheusAppUrl string = 'https://${prometheusApp.properties.defaultHostName}'
output grafanaAppUrl string = 'https://${grafanaApp.properties.defaultHostName}'
