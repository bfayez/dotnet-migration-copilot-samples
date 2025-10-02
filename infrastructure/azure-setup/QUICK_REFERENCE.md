# Azure Setup Quick Reference

Quick reference card for common Azure setup tasks and commands.

## Initial Setup

```bash
# 1. Login to Azure
az login

# 2. List subscriptions
az account list --output table

# 3. Set subscription
az account set --subscription "subscription-name-or-id"

# 4. Run setup scripts
cd infrastructure/azure-setup
./setup-azure-subscription.sh dev
./setup-rbac.sh dev
./create-service-principal.sh dev
```

## Common Commands

### Resource Groups

```bash
# List all resource groups
az group list --output table

# Show resource group details
az group show --name rg-contoso-university-dev

# List resources in group
az resource list --resource-group rg-contoso-university-dev --output table

# Update resource group tags
az group update \
  --name rg-contoso-university-dev \
  --tags Environment=dev Project=ContosoUniversity

# Delete resource group (⚠️ DESTRUCTIVE)
az group delete --name rg-contoso-university-dev --yes
```

### RBAC (Role-Based Access Control)

```bash
# List role assignments for resource group
az role assignment list \
  --resource-group rg-contoso-university-dev \
  --output table

# Add Contributor role to user
az role assignment create \
  --assignee user@example.com \
  --role "Contributor" \
  --resource-group rg-contoso-university-dev

# Add Reader role to user
az role assignment create \
  --assignee user@example.com \
  --role "Reader" \
  --resource-group rg-contoso-university-dev

# Remove role assignment
az role assignment delete \
  --assignee user@example.com \
  --role "Contributor" \
  --resource-group rg-contoso-university-dev

# List all available roles
az role definition list --output table
```

### Service Principals

```bash
# List service principals
az ad sp list --display-name "sp-contoso-university" --output table

# Show service principal details
az ad sp show --id <CLIENT_ID>

# List role assignments for service principal
az role assignment list --assignee <CLIENT_ID> --output table

# Reset service principal credentials
az ad sp credential reset --name sp-contoso-university-dev-cicd

# Delete service principal
az ad sp delete --id <CLIENT_ID>
```

### Cost Management

```bash
# View current month costs
az consumption usage list \
  --start-date $(date -d "first day of this month" +%Y-%m-%d) \
  --end-date $(date +%Y-%m-%d)

# List budgets
az consumption budget list

# Show budget details
az consumption budget show \
  --budget-name budget-contoso-university-dev
```

### Tags

```bash
# Show tags for resource group
az group show \
  --name rg-contoso-university-dev \
  --query tags

# Update tags (merge with existing)
az group update \
  --name rg-contoso-university-dev \
  --tags CostCenter=Engineering

# Replace all tags
az group update \
  --name rg-contoso-university-dev \
  --set tags.Environment=dev tags.Project=ContosoUniversity

# Query resources by tag
az resource list --tag Environment=dev --output table
```

### Locks

```bash
# Create CanNotDelete lock
az lock create \
  --name CannotDelete-RG \
  --resource-group rg-contoso-university-prod \
  --lock-type CanNotDelete

# Create ReadOnly lock
az lock create \
  --name ReadOnly-RG \
  --resource-group rg-contoso-university-prod \
  --lock-type ReadOnly

# List locks
az lock list --resource-group rg-contoso-university-prod

# Delete lock
az lock delete \
  --name CannotDelete-RG \
  --resource-group rg-contoso-university-prod
```

## Resource Naming Patterns

```bash
# Resource Groups
rg-contoso-university-dev
rg-contoso-university-prod

# Storage Accounts (no hyphens, lowercase only)
stcontosounivdev
stcontosounivprod

# SQL Server
sql-contoso-univ-dev
sql-contoso-univ-prod

# SQL Database
sqldb-contoso-univ-dev

# Key Vault (3-24 chars)
kv-contoso-univ-dev

# Container Apps Environment
cae-contoso-univ-dev

# Container App
ca-contoso-univ-web-dev

# Service Bus Namespace
sbns-contoso-univ-dev

# Virtual Network
vnet-contoso-univ-dev

# Log Analytics
log-contoso-univ-dev

# Service Principal
sp-contoso-univ-dev-cicd
```

## Required Tags

```bash
Environment=dev          # dev, staging, prod
Project=ContosoUniversity
Owner=DevOps Team
CostCenter=IT-Migration
```

## File Locations

```
infrastructure/azure-setup/
├── setup-azure-subscription.sh    # Main setup script
├── setup-azure-subscription.ps1   # PowerShell version
├── setup-rbac.sh                  # RBAC configuration
├── create-service-principal.sh    # Create service principal
├── naming-conventions.md          # Naming guide
├── README.md                      # Full documentation
├── GITHUB_ACTIONS_EXAMPLES.md     # CI/CD examples
└── .gitignore                     # Sensitive files

Generated files (not committed):
├── subscription-details.txt
├── budget-config.json
├── governance-policies.txt
├── network-topology.md
├── rbac-documentation.md
├── rbac-assignments-{env}.json
├── service-principal-{env}.md
├── github-secrets-{env}.md
├── sp-credentials-{env}.json      # ⚠️ SENSITIVE - DELETE AFTER USE
└── .env.{env}                     # ⚠️ SENSITIVE - DO NOT COMMIT
```

## Troubleshooting Quick Fixes

### Not Logged In
```bash
az login
az account show  # Verify login
```

### Wrong Subscription
```bash
az account list --output table
az account set --subscription "correct-subscription-id"
```

### Permission Denied
```bash
# Check your roles
az role assignment list --assignee $(az account show --query user.name -o tsv)

# Contact subscription owner to grant permissions
```

### Resource Already Exists
```bash
# Use existing resource
az group show --name rg-contoso-university-dev

# Or delete and recreate (⚠️ DESTRUCTIVE)
az group delete --name rg-contoso-university-dev --yes
./setup-azure-subscription.sh dev
```

### Service Principal Issues
```bash
# Check if service principal exists
az ad sp list --display-name "sp-contoso-university-dev-cicd"

# Reset credentials
az ad sp credential reset --name sp-contoso-university-dev-cicd

# Recreate from scratch
az ad sp delete --id <CLIENT_ID>
./create-service-principal.sh dev
```

## Environment Variables

After setup, these environment variables are available in `.env.{environment}`:

```bash
AZURE_CLIENT_ID=<service-principal-client-id>
AZURE_CLIENT_SECRET=<service-principal-secret>
AZURE_TENANT_ID=<azure-tenant-id>
AZURE_SUBSCRIPTION_ID=<subscription-id>
AZURE_RESOURCE_GROUP=rg-contoso-university-dev
```

Usage:
```bash
# Load variables
source .env.dev

# Use in commands
az login --service-principal \
  --username $AZURE_CLIENT_ID \
  --password $AZURE_CLIENT_SECRET \
  --tenant $AZURE_TENANT_ID
```

## Next Steps

1. ✅ Run initial setup scripts
2. ✅ Verify resource group and tags
3. ✅ Configure team member access (RBAC)
4. ✅ Create service principal for CI/CD
5. ✅ Add credentials to GitHub Secrets
6. ⏭️ Create Azure resources (SQL, Storage, Service Bus)
7. ⏭️ Set up monitoring and alerts
8. ⏭️ Configure GitHub Actions for deployment

## Support

- 📖 [Full Documentation](./README.md)
- 🔧 [GitHub Actions Examples](./GITHUB_ACTIONS_EXAMPLES.md)
- 📝 [Naming Conventions](./naming-conventions.md)
- 🌐 [Azure CLI Reference](https://docs.microsoft.com/en-us/cli/azure/)
