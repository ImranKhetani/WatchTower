# WatchTower

**WatchTower** is a lightweight e-commerce application built on ASP.NET Core, designed to showcase real-time monitoring, incident management, and CI/CD integration using cutting-edge tools like Prometheus, Grafana, GitHub Actions, and Azure Bicep.

## Features

- **E-commerce Platform**: A simple online shopping platform with product browsing and cart functionality.
- **CI/CD Pipeline**: GitHub Actions workflow for continuous integration and deployment.
- **Infrastructure as Code**: Infrastructure deployment is automated with Azure Bicep.
- **Real-Time Monitoring**: Prometheus and Grafana for system metrics visualization and anomaly detection.
- **Cloud Deployment**: Hosted on Azure App Services using the Free Tier.

## Folder Structure

WATCHTOWER/
├── src/                          # Application codebase
│   ├── Controllers/              # API controllers
│   ├── Data/                     # Database context and setup
│   ├── Migrations/               # EF Core migrations
│   ├── Models/                   # Domain models
│   ├── Views/                    # Razor views
│   ├── wwwroot/                  # Static files
│   ├── Program.cs                # App entry point
│   ├── Watchtower.csproj         # Project file
│   ├── appsettings.json          # App settings
├── infrastructure/               # Infrastructure as Code (IaC)
│   ├── main.bicep                # Bicep file for Azure deployment
│   ├── parameters.json           # Parameter values for Bicep
├── .github/                      # CI/CD workflows
│   └── workflows/
│       └── provision-infra.yml   # GitHub Actions workflow
├── README.md                     # Project documentation


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