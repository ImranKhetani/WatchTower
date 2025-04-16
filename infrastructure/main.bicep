// Parameters
param location string = 'Central India'
param appServicePlanName string = 'WatchTower-CI-ASP01'
param webAppName string = 'WatchTower-CI-WebApp01'
param prometheusAppName string = 'WatchTower-CI-prometheusApp01'
param grafanaAppName string = 'WatchTower-CI-grafanaApp01'

// App Service Plan (Free Tier)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
    capacity: 1
  }
}

// Web App for E-commerce
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  serverFarmId: appServicePlan.id
  siteConfig: {
    linuxFxVersion: 'DOTNET|8.0' // Hosting .NET 8 app
    appSettings: [
      {
        name: 'WEBSITE_RUN_FROM_PACKAGE'
        value: '1'
      }
    ]
  }
}

// Web App for Prometheus (Containerized)
resource prometheusApp 'Microsoft.Web/sites@2022-03-01' = {
  name: prometheusAppName
  location: location
  serverFarmId: appServicePlan.id
  siteConfig: {
    linuxFxVersion: 'DOCKER|prom/prometheus:latest' // Prometheus Docker image
    appSettings: [
      {
        name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
        value: 'false'
      }
      {
        name: 'DOCKER_CUSTOM_IMAGE_NAME'
        value: 'prom/prometheus:latest'
      }
    ]
  }
}

// Web App for Grafana (Containerized)
resource grafanaApp 'Microsoft.Web/sites@2022-03-01' = {
  name: grafanaAppName
  location: location
  serverFarmId: appServicePlan.id
  siteConfig: {
    linuxFxVersion: 'DOCKER|grafana/grafana:latest' // Grafana Docker image
    appSettings: [
      {
        name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
        value: 'false'
      }
      {
        name: 'DOCKER_CUSTOM_IMAGE_NAME'
        value: 'grafana/grafana:latest'
      }
    ]
  }
}
