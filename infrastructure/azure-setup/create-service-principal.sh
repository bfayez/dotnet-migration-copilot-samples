#!/bin/bash
# Service Principal Creation Script for CI/CD
# This script creates Azure service principals for automated deployments
#
# Prerequisites:
# - Azure CLI installed and logged in
# - Owner or User Access Administrator role on subscription
# - Resource groups already created
#
# Usage:
#   ./create-service-principal.sh [ENVIRONMENT]
#   ENVIRONMENT: dev (default) or prod

set -e  # Exit on error

# ============================================================================
# Configuration Variables
# ============================================================================

ENVIRONMENT="${1:-dev}"
PROJECT_NAME="contoso-university"
RG_NAME="rg-${PROJECT_NAME}-${ENVIRONMENT}"
SP_NAME="sp-${PROJECT_NAME}-${ENVIRONMENT}-cicd"

# ============================================================================
# Helper Functions
# ============================================================================

print_header() {
    echo ""
    echo "========================================================================"
    echo "$1"
    echo "========================================================================"
}

print_info() {
    echo "[INFO] $1"
}

print_success() {
    echo "[SUCCESS] $1"
}

print_error() {
    echo "[ERROR] $1" >&2
}

print_warning() {
    echo "[WARNING] $1"
}

# ============================================================================
# Main Functions
# ============================================================================

create_service_principal() {
    print_header "Create Service Principal for CI/CD"
    
    print_info "Service Principal Name: ${SP_NAME}"
    print_info "Environment: ${ENVIRONMENT}"
    
    # Get subscription and resource group scope
    SUBSCRIPTION_ID=$(az account show --query id -o tsv)
    RG_SCOPE=$(az group show --name "${RG_NAME}" --query id -o tsv)
    
    print_info "Subscription ID: ${SUBSCRIPTION_ID}"
    print_info "Resource Group Scope: ${RG_SCOPE}"
    
    # Create service principal with Contributor role on resource group
    print_info "Creating service principal..."
    print_info "This will create credentials that should be stored securely"
    
    SP_OUTPUT=$(az ad sp create-for-rbac \
        --name "${SP_NAME}" \
        --role "Contributor" \
        --scopes "${RG_SCOPE}" \
        --sdk-auth)
    
    print_success "Service principal created successfully"
    
    # Extract values
    CLIENT_ID=$(echo $SP_OUTPUT | jq -r '.clientId')
    CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.clientSecret')
    TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenantId')
    
    print_info "Service Principal Details:"
    print_info "  Application (client) ID: ${CLIENT_ID}"
    print_info "  Client Secret: [REDACTED - see secure output below]"
    print_info "  Tenant ID: ${TENANT_ID}"
    
    # Save credentials securely
    save_credentials "$SP_OUTPUT" "$CLIENT_ID" "$CLIENT_SECRET" "$TENANT_ID"
    
    # Document service principal
    document_service_principal "$CLIENT_ID" "$TENANT_ID"
}

save_credentials() {
    local SP_OUTPUT="$1"
    local CLIENT_ID="$2"
    local CLIENT_SECRET="$3"
    local TENANT_ID="$4"
    
    print_header "Save Service Principal Credentials"
    
    # Save full JSON output for GitHub Actions
    echo "$SP_OUTPUT" > "sp-credentials-${ENVIRONMENT}.json"
    chmod 600 "sp-credentials-${ENVIRONMENT}.json"
    
    print_success "Credentials saved to: sp-credentials-${ENVIRONMENT}.json"
    print_warning "This file contains sensitive credentials!"
    print_warning "Store it securely and delete after use"
    
    # Create GitHub Actions secrets instructions
    cat > "github-secrets-${ENVIRONMENT}.md" << EOF
# GitHub Actions Secrets for ${ENVIRONMENT}

## Setting up GitHub Secrets

Add the following secrets to your GitHub repository:

### Method 1: Using Azure Credentials JSON (Recommended)
1. Go to your GitHub repository
2. Navigate to Settings > Secrets and variables > Actions
3. Click "New repository secret"
4. Create a secret named: \`AZURE_CREDENTIALS_${ENVIRONMENT^^}\`
5. Paste the entire contents of \`sp-credentials-${ENVIRONMENT}.json\` as the value

### Method 2: Individual Secrets
Alternatively, create separate secrets:

1. \`AZURE_CLIENT_ID_${ENVIRONMENT^^}\`
   Value: \`${CLIENT_ID}\`

2. \`AZURE_CLIENT_SECRET_${ENVIRONMENT^^}\`
   Value: \`${CLIENT_SECRET}\`

3. \`AZURE_TENANT_ID_${ENVIRONMENT^^}\`
   Value: \`${TENANT_ID}\`

4. \`AZURE_SUBSCRIPTION_ID_${ENVIRONMENT^^}\`
   Value: \`$(az account show --query id -o tsv)\`

## Using in GitHub Actions

### Using JSON credentials:
\`\`\`yaml
- name: Azure Login
  uses: azure/login@v1
  with:
    creds: \${{ secrets.AZURE_CREDENTIALS_${ENVIRONMENT^^} }}
\`\`\`

### Using individual secrets:
\`\`\`yaml
- name: Azure Login
  uses: azure/login@v1
  with:
    client-id: \${{ secrets.AZURE_CLIENT_ID_${ENVIRONMENT^^} }}
    client-secret: \${{ secrets.AZURE_CLIENT_SECRET_${ENVIRONMENT^^} }}
    tenant-id: \${{ secrets.AZURE_TENANT_ID_${ENVIRONMENT^^} }}
    subscription-id: \${{ secrets.AZURE_SUBSCRIPTION_ID_${ENVIRONMENT^^} }}
\`\`\`

## Security Best Practices

1. **Rotate Credentials Regularly**: Create a new service principal every 90 days
2. **Limit Scope**: Service principal only has Contributor access to ${RG_NAME}
3. **Monitor Usage**: Review service principal activity in Azure AD sign-in logs
4. **Use Managed Identities**: For Azure-based CI/CD, use managed identities instead
5. **Delete File After Use**: Delete sp-credentials-${ENVIRONMENT}.json after adding to GitHub

## Credential Rotation

To rotate credentials:
\`\`\`bash
# Create new credentials
az ad sp credential reset --name ${SP_NAME} --create-cert

# Update GitHub secrets with new values
# Revoke old credentials after verification
\`\`\`
EOF
    
    print_success "GitHub Actions setup guide created: github-secrets-${ENVIRONMENT}.md"
    
    # Create environment variables file (for local testing)
    cat > ".env.${ENVIRONMENT}" << EOF
# Azure Service Principal Credentials for ${ENVIRONMENT}
# WARNING: Keep this file secure and never commit to version control
AZURE_CLIENT_ID=${CLIENT_ID}
AZURE_CLIENT_SECRET=${CLIENT_SECRET}
AZURE_TENANT_ID=${TENANT_ID}
AZURE_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
AZURE_RESOURCE_GROUP=${RG_NAME}
EOF
    chmod 600 ".env.${ENVIRONMENT}"
    
    print_success "Environment variables file created: .env.${ENVIRONMENT}"
}

document_service_principal() {
    local CLIENT_ID="$1"
    local TENANT_ID="$2"
    
    print_header "Document Service Principal"
    
    cat > "service-principal-${ENVIRONMENT}.md" << EOF
# Service Principal Documentation

## Environment: ${ENVIRONMENT}
## Created: $(date)

## Service Principal Details

- **Name**: ${SP_NAME}
- **Application (Client) ID**: ${CLIENT_ID}
- **Tenant ID**: ${TENANT_ID}
- **Resource Group**: ${RG_NAME}
- **Role**: Contributor
- **Scope**: Resource Group (${RG_NAME})

## Purpose

This service principal is used for automated CI/CD deployments to the ${ENVIRONMENT} environment.

## Permissions

The service principal has the following permissions:
- **Contributor** role on resource group ${RG_NAME}
  - Can create, update, and delete resources
  - Cannot manage access (no role assignments)
  - Cannot modify resource group itself

## Usage

### Azure CLI Login
\`\`\`bash
az login --service-principal \\
  --username ${CLIENT_ID} \\
  --password <CLIENT_SECRET> \\
  --tenant ${TENANT_ID}
\`\`\`

### GitHub Actions
See \`github-secrets-${ENVIRONMENT}.md\` for setup instructions

### Azure DevOps
1. Create a service connection
2. Use "Service Principal (manual)" authentication
3. Enter the client ID and secret

## Security Considerations

1. **Credential Storage**:
   - Client secret stored in GitHub Secrets
   - Never commit credentials to source control
   - Rotate credentials every 90 days

2. **Access Control**:
   - Limited to resource group scope
   - Cannot access other resource groups
   - Cannot modify subscription-level settings

3. **Monitoring**:
   - Review sign-in logs in Azure AD
   - Monitor resource changes in Activity Log
   - Set up alerts for suspicious activity

## Maintenance

### Rotating Credentials
Credentials should be rotated every 90 days:
\`\`\`bash
# Method 1: Reset password
az ad sp credential reset --name ${SP_NAME}

# Method 2: Create new service principal
./create-service-principal.sh ${ENVIRONMENT}
# Then delete the old one after verification
\`\`\`

### Viewing Service Principal
\`\`\`bash
# Show service principal details
az ad sp show --id ${CLIENT_ID}

# List role assignments
az role assignment list --assignee ${CLIENT_ID} --output table
\`\`\`

### Deleting Service Principal
When no longer needed:
\`\`\`bash
az ad sp delete --id ${CLIENT_ID}
\`\`\`

## Troubleshooting

### Login Fails
- Verify credentials are correct
- Check service principal still exists: \`az ad sp show --id ${CLIENT_ID}\`
- Verify role assignments: \`az role assignment list --assignee ${CLIENT_ID}\`

### Insufficient Permissions
- Service principal only has Contributor role
- Cannot assign roles or manage access
- Cannot modify resource group tags or locks

## References

- [Azure Service Principals](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals)
- [GitHub Actions for Azure](https://github.com/Azure/actions)
- [Azure CLI Service Principal Authentication](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli)
EOF
    
    print_success "Service principal documentation created: service-principal-${ENVIRONMENT}.md"
}

verify_service_principal() {
    print_header "Verify Service Principal"
    
    print_info "Verifying service principal was created correctly..."
    
    # Get app ID from service principal name
    APP_ID=$(az ad sp list --display-name "${SP_NAME}" --query "[0].appId" -o tsv)
    
    if [ -z "$APP_ID" ]; then
        print_error "Service principal not found!"
        return 1
    fi
    
    print_success "Service principal found: ${APP_ID}"
    
    # List role assignments
    print_info "Role assignments for service principal:"
    az role assignment list --assignee "${APP_ID}" --output table
    
    print_success "Verification complete"
}

display_summary() {
    print_header "Service Principal Creation Summary"
    
    print_info "Service principal created for environment: ${ENVIRONMENT}"
    print_info "Name: ${SP_NAME}"
    print_info ""
    print_info "Files created:"
    print_info "  - sp-credentials-${ENVIRONMENT}.json (SENSITIVE - delete after use)"
    print_info "  - github-secrets-${ENVIRONMENT}.md"
    print_info "  - .env.${ENVIRONMENT} (SENSITIVE - for local testing)"
    print_info "  - service-principal-${ENVIRONMENT}.md"
    print_info ""
    print_warning "IMPORTANT SECURITY STEPS:"
    print_info "  1. Add credentials to GitHub Secrets (see github-secrets-${ENVIRONMENT}.md)"
    print_info "  2. Delete sp-credentials-${ENVIRONMENT}.json after adding to GitHub"
    print_info "  3. Keep .env.${ENVIRONMENT} secure and never commit to git"
    print_info "  4. Add *.env.* to .gitignore if not already present"
    print_info ""
    print_info "Next steps:"
    print_info "  1. Follow instructions in github-secrets-${ENVIRONMENT}.md"
    print_info "  2. Test service principal authentication"
    print_info "  3. Set up GitHub Actions workflows for deployment"
    print_info "  4. Schedule credential rotation (90 days)"
}

# ============================================================================
# Main Execution
# ============================================================================

main() {
    print_header "Create Service Principal for CI/CD"
    print_info "Environment: ${ENVIRONMENT}"
    print_info "Resource Group: ${RG_NAME}"
    
    # Check prerequisites
    if ! command -v jq &> /dev/null; then
        print_error "jq is not installed. Please install it:"
        print_error "  Ubuntu/Debian: sudo apt-get install jq"
        print_error "  macOS: brew install jq"
        exit 1
    fi
    
    # Check if resource group exists
    if ! az group show --name "${RG_NAME}" &> /dev/null; then
        print_error "Resource group '${RG_NAME}' does not exist"
        print_error "Please run setup-azure-subscription.sh first"
        exit 1
    fi
    
    # Create service principal
    create_service_principal
    
    # Verify creation
    verify_service_principal
    
    # Display summary
    display_summary
}

# Run main function
main
