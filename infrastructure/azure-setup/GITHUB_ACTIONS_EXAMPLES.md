# GitHub Actions Workflow Example for Azure Setup

This directory contains example GitHub Actions workflows that demonstrate how to use the Azure setup scripts and service principals for CI/CD.

## Example 1: Using Service Principal for Deployment

After running `create-service-principal.sh` and adding credentials to GitHub Secrets, you can use this workflow pattern:

```yaml
name: Deploy to Azure

on:
  push:
    branches: [main]
  workflow_dispatch:

env:
  ENVIRONMENT: dev
  RESOURCE_GROUP: rg-contoso-university-dev

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Azure Login with Service Principal
      uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS_DEV }}
    
    - name: Verify Azure Access
      run: |
        az account show
        az group show --name ${{ env.RESOURCE_GROUP }}
    
    - name: Deploy Application
      run: |
        # Your deployment commands here
        echo "Deploying to ${{ env.RESOURCE_GROUP }}"
    
    - name: Azure Logout
      if: always()
      run: az logout
```

## Example 2: Multi-Environment Deployment

```yaml
name: Multi-Environment Deploy

on:
  push:
    branches:
      - main      # Deploy to production
      - develop   # Deploy to development

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Determine environment
      id: env
      run: |
        if [[ "${{ github.ref }}" == "refs/heads/main" ]]; then
          echo "environment=prod" >> $GITHUB_OUTPUT
          echo "resource_group=rg-contoso-university-prod" >> $GITHUB_OUTPUT
        else
          echo "environment=dev" >> $GITHUB_OUTPUT
          echo "resource_group=rg-contoso-university-dev" >> $GITHUB_OUTPUT
        fi
    
    - name: Azure Login
      uses: azure/login@v1
      with:
        creds: ${{ steps.env.outputs.environment == 'prod' && secrets.AZURE_CREDENTIALS_PROD || secrets.AZURE_CREDENTIALS_DEV }}
    
    - name: Deploy to Azure Container Apps
      run: |
        az containerapp update \
          --name ca-contoso-univ-web-${{ steps.env.outputs.environment }} \
          --resource-group ${{ steps.env.outputs.resource_group }} \
          --image myregistry.azurecr.io/contoso-university:${{ github.sha }}
```

## Example 3: Infrastructure as Code with Bicep/ARM

```yaml
name: Deploy Azure Infrastructure

on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        type: choice
        options:
          - dev
          - staging
          - prod

jobs:
  deploy-infrastructure:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Azure Login
      uses: azure/login@v1
      with:
        creds: ${{ 
          github.event.inputs.environment == 'prod' && secrets.AZURE_CREDENTIALS_PROD ||
          github.event.inputs.environment == 'staging' && secrets.AZURE_CREDENTIALS_STAGING ||
          secrets.AZURE_CREDENTIALS_DEV
        }}
    
    - name: Deploy Bicep template
      uses: azure/arm-deploy@v1
      with:
        subscriptionId: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
        resourceGroupName: rg-contoso-university-${{ github.event.inputs.environment }}
        template: ./infrastructure/main.bicep
        parameters: environment=${{ github.event.inputs.environment }}
```

## Example 4: Terraform with Service Principal

```yaml
name: Terraform Deploy

on:
  push:
    branches: [main]
    paths:
      - 'infrastructure/**'

env:
  TF_VAR_environment: dev

jobs:
  terraform:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
    
    - name: Configure Azure credentials
      env:
        ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID_DEV }}
        ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET_DEV }}
        ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID_DEV }}
        ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID_DEV }}
      run: |
        echo "Azure credentials configured"
    
    - name: Terraform Init
      run: terraform init
      working-directory: ./infrastructure
    
    - name: Terraform Plan
      run: terraform plan
      working-directory: ./infrastructure
      env:
        ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID_DEV }}
        ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET_DEV }}
        ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID_DEV }}
        ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID_DEV }}
    
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'
      run: terraform apply -auto-approve
      working-directory: ./infrastructure
      env:
        ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID_DEV }}
        ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET_DEV }}
        ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID_DEV }}
        ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID_DEV }}
```

## Setting Up GitHub Secrets

After running `create-service-principal.sh`, add these secrets to your GitHub repository:

### For Development Environment

Navigate to: Repository → Settings → Secrets and variables → Actions

Create these secrets:

1. **AZURE_CREDENTIALS_DEV** (Recommended - for azure/login action)
   - Copy entire contents of `sp-credentials-dev.json`

**OR** (Alternative - individual secrets)

2. **AZURE_CLIENT_ID_DEV**
   - From service principal output

3. **AZURE_CLIENT_SECRET_DEV**
   - From service principal output

4. **AZURE_TENANT_ID_DEV**
   - From service principal output

5. **AZURE_SUBSCRIPTION_ID_DEV**
   - Your Azure subscription ID

### For Production Environment

Repeat the same process with `_PROD` suffix after running:
```bash
./create-service-principal.sh prod
```

## GitHub Actions Best Practices

1. **Use Environments**: Configure GitHub Environments for dev/staging/prod with protection rules
2. **Manual Approval**: Require approval for production deployments
3. **Secrets Management**: Never hardcode credentials, always use GitHub Secrets
4. **Least Privilege**: Use separate service principals for each environment
5. **Audit Logging**: Enable GitHub Actions logging and Azure Activity Log
6. **Credential Rotation**: Rotate service principal credentials every 90 days

## Environment Protection Rules

Set up environment protection in GitHub:

1. Go to Repository → Settings → Environments
2. Create environments: `development`, `staging`, `production`
3. For production environment:
   - ✅ Required reviewers: Add team leads
   - ✅ Wait timer: 5 minutes
   - ✅ Deployment branches: Only `main` branch
4. Add environment secrets specific to each environment

## Troubleshooting

### Authentication Fails

**Error**: "Error: Login failed with Error: [object Object]"

**Solution**:
- Verify secret name matches exactly (case-sensitive)
- Ensure JSON format is correct (no extra spaces/newlines)
- Check service principal still exists: `az ad sp list --display-name sp-contoso-university-dev-cicd`

### Insufficient Permissions

**Error**: "Insufficient privileges to complete the operation"

**Solution**:
- Verify service principal has Contributor role on resource group
- Check: `az role assignment list --assignee <CLIENT_ID> --resource-group <RG_NAME>`

### Credentials Expired

**Error**: "AADSTS700016: Application with identifier 'xxx' was not found"

**Solution**:
- Service principal may have been deleted
- Recreate: `./create-service-principal.sh dev`
- Update GitHub secrets with new credentials

## Additional Resources

- [GitHub Actions for Azure](https://github.com/Azure/actions)
- [Azure Login Action](https://github.com/Azure/login)
- [Deploy to Azure Container Apps](https://github.com/Azure/container-apps-deploy-action)
- [Azure ARM Deploy](https://github.com/Azure/arm-deploy)
- [GitHub Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)
