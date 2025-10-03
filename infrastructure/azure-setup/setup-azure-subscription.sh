#!/bin/bash
# Azure Subscription and Resource Groups Setup Script
# This script sets up the Azure subscription, resource groups, and initial configuration
# for the ContosoUniversity migration project.
#
# Prerequisites:
# - Azure CLI installed (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
# - Azure account with appropriate permissions (Owner or Contributor on subscription)
# - Logged in to Azure CLI: az login
#
# Usage:
#   ./setup-azure-subscription.sh [ENVIRONMENT]
#   ENVIRONMENT: dev (default) or prod

set -e  # Exit on error

# ============================================================================
# Configuration Variables
# ============================================================================

ENVIRONMENT="${1:-dev}"
PROJECT_NAME="contoso-university"
LOCATION="eastus"  # Change to your preferred Azure region

# Naming conventions based on Azure best practices
# Format: <resource-type>-<project>-<environment>
RG_NAME="rg-${PROJECT_NAME}-${ENVIRONMENT}"

# Tags for resource management
TAG_ENVIRONMENT="${ENVIRONMENT}"
TAG_PROJECT="ContosoUniversity"
TAG_OWNER="DevOps Team"
TAG_COST_CENTER="IT-Migration"
TAG_MANAGED_BY="Terraform"  # Change if using other IaC tools

# Cost Management
BUDGET_NAME="budget-${PROJECT_NAME}-${ENVIRONMENT}"
BUDGET_AMOUNT="500"  # Monthly budget in USD
ALERT_THRESHOLD_1="50"  # Alert at 50%
ALERT_THRESHOLD_2="75"  # Alert at 75%
ALERT_THRESHOLD_3="90"  # Alert at 90%
ALERT_EMAIL="your-email@example.com"  # Update with your email

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

check_azure_cli() {
    if ! command -v az &> /dev/null; then
        print_error "Azure CLI is not installed. Please install it from:"
        print_error "https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
        exit 1
    fi
    print_success "Azure CLI is installed"
}

check_azure_login() {
    if ! az account show &> /dev/null; then
        print_error "Not logged in to Azure. Please run: az login"
        exit 1
    fi
    print_success "Logged in to Azure"
}

# ============================================================================
# Main Setup Functions
# ============================================================================

setup_subscription() {
    print_header "1. Azure Subscription Setup"
    
    # Get current subscription
    SUBSCRIPTION_ID=$(az account show --query id -o tsv)
    SUBSCRIPTION_NAME=$(az account show --query name -o tsv)
    
    print_info "Current Subscription:"
    print_info "  ID: ${SUBSCRIPTION_ID}"
    print_info "  Name: ${SUBSCRIPTION_NAME}"
    
    # Confirm subscription
    read -p "Continue with this subscription? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Listing available subscriptions..."
        az account list --output table
        read -p "Enter the subscription ID to use: " SELECTED_SUB
        az account set --subscription "${SELECTED_SUB}"
        print_success "Switched to subscription: ${SELECTED_SUB}"
    fi
    
    # Document subscription details
    cat > subscription-details.txt << EOF
Azure Subscription Details
==========================
Subscription ID: $(az account show --query id -o tsv)
Subscription Name: $(az account show --query name -o tsv)
Tenant ID: $(az account show --query tenantId -o tsv)
Environment: ${ENVIRONMENT}
Setup Date: $(date)
EOF
    
    print_success "Subscription details documented in subscription-details.txt"
}

create_resource_groups() {
    print_header "2. Create Resource Groups"
    
    print_info "Creating resource group: ${RG_NAME}"
    
    # Create resource group
    az group create \
        --name "${RG_NAME}" \
        --location "${LOCATION}" \
        --tags \
            Environment="${TAG_ENVIRONMENT}" \
            Project="${TAG_PROJECT}" \
            Owner="${TAG_OWNER}" \
            CostCenter="${TAG_COST_CENTER}" \
            ManagedBy="${TAG_MANAGED_BY}" \
        --output table
    
    print_success "Resource group created: ${RG_NAME}"
    
    # Display resource group details
    print_info "Resource group details:"
    az group show --name "${RG_NAME}" --output table
}

configure_cost_management() {
    print_header "3. Configure Cost Management and Budgets"
    
    print_info "Setting up budget: ${BUDGET_NAME}"
    
    # Note: Budget creation requires specific permissions and may not work in all subscriptions
    # This is a placeholder - actual implementation may vary based on subscription type
    
    SUBSCRIPTION_ID=$(az account show --query id -o tsv)
    
    # Create budget (requires Cost Management permissions)
    cat > budget-config.json << EOF
{
  "category": "Cost",
  "amount": ${BUDGET_AMOUNT},
  "timeGrain": "Monthly",
  "timePeriod": {
    "startDate": "$(date -d "first day of this month" +%Y-%m-01)",
    "endDate": "$(date -d "last day of next year" +%Y-12-31)"
  },
  "notifications": {
    "Actual_GreaterThan_${ALERT_THRESHOLD_1}_Percent": {
      "enabled": true,
      "operator": "GreaterThan",
      "threshold": ${ALERT_THRESHOLD_1},
      "contactEmails": ["${ALERT_EMAIL}"],
      "contactRoles": ["Owner", "Contributor"],
      "thresholdType": "Actual"
    },
    "Actual_GreaterThan_${ALERT_THRESHOLD_2}_Percent": {
      "enabled": true,
      "operator": "GreaterThan",
      "threshold": ${ALERT_THRESHOLD_2},
      "contactEmails": ["${ALERT_EMAIL}"],
      "contactRoles": ["Owner", "Contributor"],
      "thresholdType": "Actual"
    },
    "Actual_GreaterThan_${ALERT_THRESHOLD_3}_Percent": {
      "enabled": true,
      "operator": "GreaterThan",
      "threshold": ${ALERT_THRESHOLD_3},
      "contactEmails": ["${ALERT_EMAIL}"],
      "contactRoles": ["Owner", "Contributor"],
      "thresholdType": "Actual"
    }
  }
}
EOF
    
    print_info "Budget configuration saved to budget-config.json"
    print_info "Note: Budget creation requires Cost Management permissions"
    print_info "To create budget manually, use Azure Portal or run:"
    print_info "  az consumption budget create --resource-group ${RG_NAME} --budget-name ${BUDGET_NAME} --amount ${BUDGET_AMOUNT} --time-grain Monthly --time-period start-date=$(date -d 'first day of this month' +%Y-%m-01) end-date=$(date -d 'last day of next year' +%Y-12-31) --category Cost"
    
    # Create cost alert action group (for more granular alerts)
    print_info "Cost alerts will be configured through Azure Monitor"
}

configure_governance() {
    print_header "4. Configure Governance and Policies"
    
    print_info "Setting up Azure Policy assignments for resource group: ${RG_NAME}"
    
    # Enable Activity Log
    print_info "Activity logging is enabled by default for all Azure resources"
    
    # Set up diagnostic settings for resource group (requires Log Analytics workspace)
    print_info "Diagnostic settings will be configured after Log Analytics workspace is created"
    
    # Apply management locks for production
    if [[ "${ENVIRONMENT}" == "prod" ]]; then
        print_info "Applying management lock to production resource group"
        az lock create \
            --name "CannotDelete-${RG_NAME}" \
            --resource-group "${RG_NAME}" \
            --lock-type CannotDelete \
            --notes "Prevent accidental deletion of production resources"
        print_success "Management lock applied to ${RG_NAME}"
    else
        print_info "Skipping management lock for ${ENVIRONMENT} environment"
    fi
    
    # Document governance policies
    cat > governance-policies.txt << EOF
Governance Policies Applied
===========================
Environment: ${ENVIRONMENT}
Resource Group: ${RG_NAME}
Date: $(date)

1. Activity Logging: Enabled (default for all Azure resources)
2. Management Locks: $([ "${ENVIRONMENT}" == "prod" ] && echo "CanNotDelete lock applied" || echo "Not applied (dev environment)")
3. Azure Policies: To be configured based on compliance requirements
4. RBAC: To be configured in next step

Recommended Policies to Apply:
- Enforce tagging on resources
- Restrict allowed locations
- Enforce encryption for storage accounts
- Require secure transfer for storage accounts
- Audit VMs without managed disks
- Require backup on VMs
EOF
    
    print_success "Governance policies documented in governance-policies.txt"
}

configure_monitoring() {
    print_header "5. Configure Azure Monitor"
    
    print_info "Setting up Azure Monitor for resource tracking"
    
    # Create Log Analytics Workspace (optional but recommended)
    read -p "Create Log Analytics workspace for monitoring? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        LOG_WORKSPACE="log-${PROJECT_NAME}-${ENVIRONMENT}"
        
        print_info "Creating Log Analytics workspace: ${LOG_WORKSPACE}"
        az monitor log-analytics workspace create \
            --resource-group "${RG_NAME}" \
            --workspace-name "${LOG_WORKSPACE}" \
            --location "${LOCATION}" \
            --tags \
                Environment="${TAG_ENVIRONMENT}" \
                Project="${TAG_PROJECT}" \
            --output table
        
        print_success "Log Analytics workspace created: ${LOG_WORKSPACE}"
        
        # Get workspace ID for later use
        WORKSPACE_ID=$(az monitor log-analytics workspace show \
            --resource-group "${RG_NAME}" \
            --workspace-name "${LOG_WORKSPACE}" \
            --query id -o tsv)
        
        echo "WORKSPACE_ID=${WORKSPACE_ID}" >> .env
        print_info "Workspace ID saved to .env file"
    else
        print_info "Skipping Log Analytics workspace creation"
    fi
    
    print_info "Monitor configuration complete"
}

create_network_plan() {
    print_header "6. Document Network Architecture"
    
    # Create network topology documentation
    cat > network-topology.md << EOF
# Network Architecture Plan for ContosoUniversity

## Environment: ${ENVIRONMENT}

## Virtual Network Topology

### Overview
This document outlines the network architecture for the ContosoUniversity application on Azure.

### Virtual Network (VNet)
- **Name**: vnet-${PROJECT_NAME}-${ENVIRONMENT}
- **Address Space**: 10.0.0.0/16
- **Location**: ${LOCATION}

### Subnets

1. **Application Subnet**
   - Name: snet-app-${ENVIRONMENT}
   - Address Range: 10.0.1.0/24
   - Purpose: Host Azure Container Apps
   - Service Endpoints: Microsoft.Sql, Microsoft.Storage

2. **Data Subnet**
   - Name: snet-data-${ENVIRONMENT}
   - Address Range: 10.0.2.0/24
   - Purpose: Private endpoints for Azure SQL, Storage, Service Bus
   - Service Endpoints: Microsoft.Sql, Microsoft.Storage, Microsoft.ServiceBus

3. **Management Subnet**
   - Name: snet-mgmt-${ENVIRONMENT}
   - Address Range: 10.0.3.0/24
   - Purpose: Management and monitoring tools
   - Service Endpoints: Microsoft.KeyVault

### Network Security Groups (NSGs)

#### NSG for Application Subnet
- Allow inbound HTTPS (443) from Internet
- Allow inbound HTTP (80) from Internet (redirect to HTTPS)
- Allow outbound to Data Subnet on SQL port (1433)
- Allow outbound to Internet for Azure services
- Deny all other inbound traffic

#### NSG for Data Subnet
- Allow inbound from Application Subnet on SQL port (1433)
- Allow inbound from Application Subnet for Storage (443)
- Allow inbound from Application Subnet for Service Bus (443)
- Deny all inbound from Internet
- Allow outbound for Azure services

### Private Endpoints Strategy

For production environment, consider implementing private endpoints for:
1. Azure SQL Database
2. Azure Storage Account
3. Azure Service Bus
4. Azure Key Vault

### DNS Configuration
- Use Azure Private DNS zones for private endpoints
- Configure DNS resolution for private endpoints

### Implementation Notes
- Start with public endpoints for development
- Implement private endpoints for production
- Use service endpoints as intermediate step
- Configure firewall rules to restrict access

## Next Steps
1. Create Virtual Network and Subnets
2. Configure Network Security Groups
3. Set up Private Endpoints (production)
4. Configure DNS zones
5. Test connectivity
EOF
    
    print_success "Network topology documented in network-topology.md"
}

display_summary() {
    print_header "Setup Summary"
    
    print_info "Azure Subscription and Resource Groups setup completed!"
    print_info ""
    print_info "Environment: ${ENVIRONMENT}"
    print_info "Resource Group: ${RG_NAME}"
    print_info "Location: ${LOCATION}"
    print_info ""
    print_info "Files created:"
    print_info "  - subscription-details.txt"
    print_info "  - budget-config.json"
    print_info "  - governance-policies.txt"
    print_info "  - network-topology.md"
    [ -f .env ] && print_info "  - .env"
    print_info ""
    print_info "Next steps:"
    print_info "  1. Configure RBAC roles (run setup-rbac.sh)"
    print_info "  2. Create service principals for CI/CD (run create-service-principal.sh)"
    print_info "  3. Create Azure resources (SQL, Service Bus, Storage)"
    print_info "  4. Set up monitoring and alerts"
    print_info ""
    print_info "To view resource group:"
    print_info "  az group show --name ${RG_NAME}"
    print_info ""
    print_info "To list resources in group:"
    print_info "  az resource list --resource-group ${RG_NAME} --output table"
}

# ============================================================================
# Main Execution
# ============================================================================

main() {
    print_header "Azure Subscription and Resource Groups Setup"
    print_info "Environment: ${ENVIRONMENT}"
    print_info "Project: ${PROJECT_NAME}"
    print_info "Location: ${LOCATION}"
    
    # Pre-flight checks
    check_azure_cli
    check_azure_login
    
    # Execute setup steps
    setup_subscription
    create_resource_groups
    configure_cost_management
    configure_governance
    configure_monitoring
    create_network_plan
    
    # Display summary
    display_summary
}

# Run main function
main
