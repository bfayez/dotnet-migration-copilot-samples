# Azure Setup - Infrastructure Automation Scripts

This directory contains automation scripts and documentation for setting up Azure subscription, resource groups, and initial configuration for the ContosoUniversity migration project.

## 📋 Contents

- [Quick Start](#quick-start)
- [Scripts Overview](#scripts-overview)
- [Documentation](#documentation)
- [Prerequisites](#prerequisites)
- [Step-by-Step Guide](#step-by-step-guide)
- [Directory Structure](#directory-structure)

---

## Quick Start

```bash
# 1. Login to Azure
az login

# 2. Set up subscription and resource groups (interactive)
./setup-azure-subscription.sh dev

# 3. Configure RBAC roles for team members
./setup-rbac.sh dev

# 4. Create service principal for CI/CD
./create-service-principal.sh dev
```

After running these scripts, you'll have:
- ✅ Resource group configured with proper tags
- ✅ Cost management and budgets set up
- ✅ Governance policies applied
- ✅ RBAC roles assigned to team members
- ✅ Service principal for automated deployments
- ✅ Complete documentation

---

## Scripts Overview

### 1. `setup-azure-subscription.sh`

**Purpose**: Sets up Azure subscription, creates resource groups, configures governance and monitoring.

**What it does**:
- Verifies Azure CLI installation and login
- Creates resource groups with proper naming and tags
- Configures cost management and budgets
- Sets up governance policies and management locks
- Creates Log Analytics workspace (optional)
- Generates network topology documentation

**Usage**:
```bash
./setup-azure-subscription.sh [ENVIRONMENT]
# ENVIRONMENT: dev (default), staging, or prod
```

**Output files**:
- `subscription-details.txt` - Subscription information
- `budget-config.json` - Budget configuration
- `governance-policies.txt` - Applied governance policies
- `network-topology.md` - Network architecture plan
- `.env` - Environment variables (if Log Analytics created)

---

### 2. `setup-rbac.sh`

**Purpose**: Configures Role-Based Access Control (RBAC) for team members.

**What it does**:
- Assigns Azure roles to team members interactively
- Supports Owner, Contributor, and Reader roles
- Documents all role assignments
- Exports role configuration to JSON

**Usage**:
```bash
./setup-rbac.sh [ENVIRONMENT]
```

**Output files**:
- `rbac-documentation.md` - Complete RBAC documentation
- `rbac-assignments-{env}.json` - Current role assignments

**Recommended role assignments**:
- **Owner**: Project Lead, Azure Administrators
- **Contributor**: Developers, DevOps Engineers
- **Reader**: Testers, Stakeholders

---

### 3. `create-service-principal.sh`

**Purpose**: Creates Azure service principal for CI/CD automation.

**What it does**:
- Creates service principal with Contributor role on resource group
- Generates credentials for GitHub Actions / Azure DevOps
- Creates setup instructions for GitHub Secrets
- Documents service principal details and usage

**Usage**:
```bash
./create-service-principal.sh [ENVIRONMENT]
```

**Output files**:
- `sp-credentials-{env}.json` - **SENSITIVE** - Service principal credentials
- `github-secrets-{env}.md` - Instructions for GitHub Actions setup
- `.env.{env}` - **SENSITIVE** - Environment variables for local testing
- `service-principal-{env}.md` - Service principal documentation

**⚠️ Security Note**: 
- Delete `sp-credentials-{env}.json` after adding to GitHub Secrets
- Keep `.env.{env}` secure and never commit to git
- Rotate credentials every 90 days

---

## Documentation

### `naming-conventions.md`

Comprehensive guide for naming Azure resources and tagging strategy.

**Includes**:
- Standard naming patterns for all Azure resources
- Resource type abbreviations (following Microsoft CAF)
- Environment naming standards (dev, staging, prod)
- Required and optional tags
- Examples for all resource types
- Governance and enforcement guidelines

**Key Naming Pattern**:
```
<resource-type>-<project>-<environment>-<region>-<instance>
```

**Examples**:
```
rg-contoso-university-dev          (Resource Group)
stcontosounivdev                   (Storage Account)
sql-contoso-univ-dev               (SQL Server)
ca-contoso-univ-web-dev            (Container App)
```

**Required Tags**:
- Environment (dev, staging, prod)
- Project (ContosoUniversity)
- Owner (Team or individual)
- CostCenter (Budget allocation)

---

## Prerequisites

### Required Tools

1. **Azure CLI**
   ```bash
   # Install on Linux/WSL
   curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
   
   # Install on macOS
   brew install azure-cli
   
   # Install on Windows
   # Download from: https://aka.ms/installazurecliwindows
   ```

2. **jq** (JSON processor - for service principal script)
   ```bash
   # Ubuntu/Debian
   sudo apt-get install jq
   
   # macOS
   brew install jq
   
   # Windows (using Chocolatey)
   choco install jq
   ```

3. **Azure Account**
   - Azure subscription with active billing
   - Owner or Contributor role on subscription
   - Azure AD permissions to create service principals

### Verify Installation

```bash
# Check Azure CLI
az --version

# Check jq
jq --version

# Login to Azure
az login

# Verify subscription
az account show
```

---

## Step-by-Step Guide

### Phase 1: Initial Setup (Day 1)

#### 1.1 Review Documentation
```bash
# Read naming conventions
cat naming-conventions.md

# Review network topology plan
# (will be generated after running setup script)
```

#### 1.2 Configure Variables

Edit the scripts to customize for your environment:

**In `setup-azure-subscription.sh`**:
```bash
PROJECT_NAME="contoso-university"    # Your project name
LOCATION="eastus"                    # Your preferred region
BUDGET_AMOUNT="500"                  # Monthly budget in USD
ALERT_EMAIL="your-email@example.com" # Your email for alerts
```

#### 1.3 Run Subscription Setup
```bash
# For development environment
./setup-azure-subscription.sh dev

# Follow the prompts to:
# - Confirm subscription
# - Create resource groups
# - Set up cost management
# - Configure monitoring
```

**Expected Output**:
- Resource group created: `rg-contoso-university-dev`
- Documentation files generated
- Confirmation messages for each step

#### 1.4 Verify Resource Group
```bash
# View resource group
az group show --name rg-contoso-university-dev

# Check tags
az group show --name rg-contoso-university-dev --query tags
```

---

### Phase 2: Access Control (Day 1-2)

#### 2.1 Configure RBAC
```bash
./setup-rbac.sh dev
```

Follow prompts to add team members:
- **Project Lead**: Enter email when prompted (gets Owner role)
- **Developers**: Enter each developer's email (gets Contributor role)
- **Testers**: Enter each tester's email (gets Reader role)

#### 2.2 Verify Role Assignments
```bash
# List all role assignments
az role assignment list \
  --resource-group rg-contoso-university-dev \
  --output table

# Check specific user
az role assignment list \
  --assignee user@example.com \
  --output table
```

---

### Phase 3: CI/CD Setup (Day 2)

#### 3.1 Create Service Principal
```bash
./create-service-principal.sh dev
```

**Important**: This creates sensitive credentials!

#### 3.2 Add to GitHub Secrets

Follow instructions in generated `github-secrets-dev.md`:

1. Go to GitHub repository → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Create secret: `AZURE_CREDENTIALS_DEV`
4. Paste contents of `sp-credentials-dev.json`

#### 3.3 Clean Up Sensitive Files
```bash
# After adding to GitHub Secrets, delete the credentials file
rm sp-credentials-dev.json

# Keep other files for reference
# .env.dev - for local testing (keep secure)
# github-secrets-dev.md - setup instructions
# service-principal-dev.md - documentation
```

#### 3.4 Test Service Principal
```bash
# Load credentials from .env file
source .env.dev

# Login with service principal
az login --service-principal \
  --username $AZURE_CLIENT_ID \
  --password $AZURE_CLIENT_SECRET \
  --tenant $AZURE_TENANT_ID

# Verify access
az group show --name $AZURE_RESOURCE_GROUP

# Logout
az logout
```

---

### Phase 4: Production Setup (Later)

When ready for production, repeat all steps with `prod` environment:

```bash
# Production resource group
./setup-azure-subscription.sh prod

# Production RBAC (stricter access control)
./setup-rbac.sh prod

# Production CI/CD service principal
./create-service-principal.sh prod
```

**Production Differences**:
- Management locks applied automatically
- Stricter access control (fewer Contributor roles)
- Higher budget thresholds
- Separate service principal for production deployments

---

## Directory Structure

```
infrastructure/azure-setup/
├── setup-azure-subscription.sh    # Main setup script
├── setup-rbac.sh                  # RBAC configuration
├── create-service-principal.sh    # CI/CD service principal
├── naming-conventions.md          # Naming and tagging guide
├── README.md                      # This file
│
└── Generated files (after running scripts):
    ├── subscription-details.txt
    ├── budget-config.json
    ├── governance-policies.txt
    ├── network-topology.md
    ├── rbac-documentation.md
    ├── rbac-assignments-{env}.json
    ├── service-principal-{env}.md
    ├── github-secrets-{env}.md
    ├── .env                       # From setup script
    └── .env.{env}                 # From service principal script
```

---

## Common Tasks

### View Resource Group Details
```bash
az group show --name rg-contoso-university-dev
```

### List All Resources in Group
```bash
az resource list \
  --resource-group rg-contoso-university-dev \
  --output table
```

### Update Resource Group Tags
```bash
az group update \
  --name rg-contoso-university-dev \
  --tags Environment=dev Project=ContosoUniversity Owner="DevOps Team"
```

### Add New Team Member
```bash
# Contributor role
az role assignment create \
  --assignee newuser@example.com \
  --role "Contributor" \
  --resource-group rg-contoso-university-dev

# Reader role
az role assignment create \
  --assignee viewer@example.com \
  --role "Reader" \
  --resource-group rg-contoso-university-dev
```

### Remove Team Member Access
```bash
az role assignment delete \
  --assignee user@example.com \
  --resource-group rg-contoso-university-dev
```

### Rotate Service Principal Credentials
```bash
# Get service principal name
SP_NAME="sp-contoso-university-dev-cicd"

# Reset credentials
az ad sp credential reset --name $SP_NAME

# Update GitHub Secrets with new credentials
```

### View Cost Analysis
```bash
# View current month costs
az consumption usage list \
  --start-date $(date -d "first day of this month" +%Y-%m-%d) \
  --end-date $(date +%Y-%m-%d)
```

---

## Troubleshooting

### Script Fails with Permission Error
**Problem**: "Insufficient permissions to create resource group"

**Solution**: 
- Ensure you're logged in: `az login`
- Verify you have Contributor or Owner role on subscription
- Check subscription: `az account show`

### Service Principal Creation Fails
**Problem**: "Insufficient privileges to complete the operation"

**Solution**:
- Need Application Administrator or Global Administrator role in Azure AD
- Ask your Azure AD admin to create the service principal
- Alternative: Use managed identity for Azure-hosted CI/CD

### Budget Creation Doesn't Work
**Problem**: Budget commands fail or return errors

**Solution**:
- Budget creation requires specific subscription permissions
- Some subscription types don't support budgets (e.g., MSDN, Free tier)
- Create budget manually in Azure Portal: Cost Management + Billing → Budgets

### Resource Group Already Exists
**Problem**: "Resource group already exists"

**Solution**:
```bash
# Use existing resource group
az group show --name rg-contoso-university-dev

# Or delete and recreate (WARNING: deletes all resources!)
az group delete --name rg-contoso-university-dev
./setup-azure-subscription.sh dev
```

---

## Security Best Practices

1. **Principle of Least Privilege**
   - Grant minimum required permissions
   - Use Reader role when write access not needed
   - Limit Owner role to admins only

2. **Service Principal Management**
   - Rotate credentials every 90 days
   - Use separate service principals for dev and prod
   - Never commit credentials to source control
   - Delete credentials files after use

3. **Credential Storage**
   - Store in GitHub Secrets for CI/CD
   - Use Azure Key Vault for application secrets
   - Never hardcode credentials in scripts

4. **Access Review**
   - Review role assignments quarterly
   - Remove access for team members who left
   - Audit service principal usage

5. **Resource Protection**
   - Apply management locks on production resources
   - Enable Azure Policy for governance
   - Configure activity logging and alerts

---

## Next Steps

After completing the Azure setup:

1. ✅ **Review Generated Documentation**
   - Check all generated `.md` and `.txt` files
   - Verify settings match your requirements

2. ✅ **Test Access**
   - Verify all team members can access Azure Portal
   - Test service principal authentication
   - Confirm GitHub Actions can deploy

3. ✅ **Create Azure Resources**
   - Follow Task 04: Create Azure Resources
   - Provision SQL Database, Service Bus, Storage
   - Use naming conventions from this setup

4. ✅ **Set Up Monitoring**
   - Configure Application Insights
   - Create custom dashboards
   - Set up additional alerts

5. ✅ **Document Everything**
   - Update team wiki with setup details
   - Share access information securely
   - Schedule regular access reviews

---

## References

- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)
- [Azure RBAC Best Practices](https://docs.microsoft.com/en-us/azure/role-based-access-control/best-practices)
- [Service Principal Authentication](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
- [Azure Naming Conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- [Azure Cost Management](https://docs.microsoft.com/en-us/azure/cost-management-billing/)
- [GitHub Actions for Azure](https://github.com/Azure/actions)

---

## Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review Azure CLI documentation
3. Contact the DevOps team
4. Open an issue in the project repository
