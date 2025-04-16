# WatchTower

**WatchTower** is a lightweight e-commerce application built on ASP.NET Core, designed to showcase real-time monitoring, incident management, and CI/CD integration using cutting-edge tools like Prometheus, Grafana, GitHub Actions, and Azure Bicep.

## Features

- **E-commerce Platform**: A simple online shopping platform with product browsing and cart functionality.
- **CI/CD Pipeline**: GitHub Actions workflow for continuous integration and deployment.
- **Infrastructure as Code**: Infrastructure deployment is automated with Azure Bicep.
- **Real-Time Monitoring**: Prometheus and Grafana for system metrics visualization and anomaly detection.
- **Cloud Deployment**: Hosted on Azure App Services using the Free Tier.

## Prerequisites

1. **.NET Core SDK**: Install the latest .NET 8 SDK.
2. **Azure CLI**: Install and configure Azure CLI to manage resources.
3. **Node.js (optional)**: For managing front-end dependencies.

## Deployment

# Step 1: Deploy Infrastructure

Use the Bicep file to provision the required infrastructure on Azure:

az deployment group create --resource-group <your-resource-group> --template-file infrastructure/main.bicep --parameters infrastructure/parameters.json

# Step 2: Configure GitHub Actions

Add AZURE_CREDENTIALS (service principal) and AZURE_PUBLISH_PROFILE to GitHub Secrets.

GitHub Actions will automatically deploy infrastructure and application code on commits to the main branch.

# Step 3: CI/CD Pipeline

Push your code to the main branch. GitHub Actions will:

Deploy the infrastructure (App Services, Prometheus, Grafana).

Build and deploy the application to the Azure Web App.
