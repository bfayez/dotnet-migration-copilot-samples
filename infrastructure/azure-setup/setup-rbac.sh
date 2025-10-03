#!/bin/bash
# Azure RBAC (Role-Based Access Control) Setup Script
# This script configures RBAC roles for team members on the ContosoUniversity migration project
#
# Prerequisites:
# - Azure CLI installed and logged in
# - Owner or User Access Administrator role on subscription
# - Resource groups already created
#
# Usage:
#   ./setup-rbac.sh [ENVIRONMENT]
#   ENVIRONMENT: dev (default) or prod

set -e  # Exit on error

# ============================================================================
# Configuration Variables
# ============================================================================

ENVIRONMENT="${1:-dev}"
PROJECT_NAME="contoso-university"
RG_NAME="rg-${PROJECT_NAME}-${ENVIRONMENT}"

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

# ============================================================================
# RBAC Role Definitions
# ============================================================================

# Common Azure built-in roles:
# - Owner: Full access including managing access
# - Contributor: Full access except managing access
# - Reader: View all resources but no changes
# - User Access Administrator: Manage user access
# - Storage Blob Data Contributor: Read, write, delete blob containers and data
# - SQL DB Contributor: Manage SQL databases but not access to them
# - Website Contributor: Manage websites but not access to them

assign_role() {
    local ASSIGNEE_EMAIL="$1"
    local ROLE_NAME="$2"
    local SCOPE="$3"
    
    print_info "Assigning role '${ROLE_NAME}' to '${ASSIGNEE_EMAIL}'"
    
    # Check if user exists
    OBJECT_ID=$(az ad user show --id "${ASSIGNEE_EMAIL}" --query id -o tsv 2>/dev/null || echo "")
    
    if [ -z "$OBJECT_ID" ]; then
        print_error "User not found: ${ASSIGNEE_EMAIL}"
        print_info "Please verify the email address and try again"
        return 1
    fi
    
    # Assign role
    az role assignment create \
        --assignee "${ASSIGNEE_EMAIL}" \
        --role "${ROLE_NAME}" \
        --scope "${SCOPE}" \
        --output none 2>/dev/null || print_info "Role may already be assigned"
    
    print_success "Role assigned successfully"
}

# ============================================================================
# Main Functions
# ============================================================================

setup_team_roles() {
    print_header "Configure Team Member RBAC Roles"
    
    # Get resource group scope
    RG_SCOPE=$(az group show --name "${RG_NAME}" --query id -o tsv)
    
    print_info "Resource Group: ${RG_NAME}"
    print_info "Scope: ${RG_SCOPE}"
    print_info ""
    
    # Interactive role assignment
    print_info "We'll now assign roles to team members interactively"
    print_info ""
    
    # Project Lead / Admin
    print_info "== Project Lead / Admin =="
    read -p "Enter email for Project Lead (or press Enter to skip): " LEAD_EMAIL
    if [ -n "$LEAD_EMAIL" ]; then
        assign_role "$LEAD_EMAIL" "Owner" "$RG_SCOPE"
    fi
    
    # Developers
    print_info ""
    print_info "== Developers =="
    while true; do
        read -p "Enter developer email (or press Enter to finish): " DEV_EMAIL
        if [ -z "$DEV_EMAIL" ]; then
            break
        fi
        assign_role "$DEV_EMAIL" "Contributor" "$RG_SCOPE"
    done
    
    # DevOps Engineers
    print_info ""
    print_info "== DevOps Engineers =="
    while true; do
        read -p "Enter DevOps engineer email (or press Enter to finish): " DEVOPS_EMAIL
        if [ -z "$DEVOPS_EMAIL" ]; then
            break
        fi
        assign_role "$DEVOPS_EMAIL" "Contributor" "$RG_SCOPE"
    done
    
    # Testers (Read-only access)
    print_info ""
    print_info "== Testers =="
    while true; do
        read -p "Enter tester email (or press Enter to finish): " TESTER_EMAIL
        if [ -z "$TESTER_EMAIL" ]; then
            break
        fi
        assign_role "$TESTER_EMAIL" "Reader" "$RG_SCOPE"
    done
    
    print_success "Team roles configured"
}

list_current_assignments() {
    print_header "Current Role Assignments"
    
    print_info "Role assignments for resource group: ${RG_NAME}"
    print_info ""
    
    az role assignment list \
        --resource-group "${RG_NAME}" \
        --output table \
        --query "[].{Principal:principalName, Role:roleDefinitionName, Scope:scope}"
}

document_rbac() {
    print_header "Document RBAC Configuration"
    
    # Export current role assignments to file
    az role assignment list \
        --resource-group "${RG_NAME}" \
        --output json > rbac-assignments-${ENVIRONMENT}.json
    
    # Create human-readable documentation
    cat > rbac-documentation.md << EOF
# RBAC Configuration for ContosoUniversity Migration

## Environment: ${ENVIRONMENT}
## Resource Group: ${RG_NAME}
## Date: $(date)

## Role Assignment Strategy

### Principle of Least Privilege
All role assignments follow the principle of least privilege, granting users only the permissions necessary to perform their job functions.

### Role Definitions

#### Owner
- **Who**: Project Lead, Azure Administrators
- **Permissions**: Full access to all resources including the ability to manage access
- **Use Case**: Resource group management, access control, policy assignment

#### Contributor
- **Who**: Developers, DevOps Engineers
- **Permissions**: Create and manage all types of Azure resources but cannot grant access
- **Use Case**: Day-to-day development and deployment activities

#### Reader
- **Who**: Testers, Stakeholders, Auditors
- **Permissions**: View all resources but cannot make changes
- **Use Case**: Monitoring, testing, compliance review

#### Specialized Roles (when needed)
- **SQL DB Contributor**: Manage SQL databases
- **Storage Blob Data Contributor**: Manage blob storage data
- **Key Vault Secrets User**: Read secrets from Key Vault
- **Monitoring Reader**: View monitoring data

## Current Role Assignments

To view current assignments:
\`\`\`bash
az role assignment list --resource-group ${RG_NAME} --output table
\`\`\`

Detailed assignments are stored in: rbac-assignments-${ENVIRONMENT}.json

## Custom Roles

If built-in roles don't meet requirements, custom roles can be created.
See: https://docs.microsoft.com/en-us/azure/role-based-access-control/custom-roles

## Access Review

- **Frequency**: Quarterly
- **Process**: Review all role assignments and remove unnecessary access
- **Owner**: Project Lead

## Adding New Team Members

To add a new team member:
\`\`\`bash
# Contributor role (most common for developers)
az role assignment create \\
    --assignee user@example.com \\
    --role "Contributor" \\
    --resource-group ${RG_NAME}

# Reader role (for testers/stakeholders)
az role assignment create \\
    --assignee user@example.com \\
    --role "Reader" \\
    --resource-group ${RG_NAME}
\`\`\`

## Removing Access

To remove a team member's access:
\`\`\`bash
az role assignment delete \\
    --assignee user@example.com \\
    --role "Contributor" \\
    --resource-group ${RG_NAME}
\`\`\`

## Azure AD Groups (Recommended)

For larger teams, create Azure AD groups and assign roles to groups:
1. Create Azure AD group for each role (e.g., "ContosoUniversity-Developers")
2. Assign role to the group
3. Add/remove users from the group

Benefits:
- Easier management
- Consistent permissions
- Audit trail

## Security Best Practices

1. **Regular Reviews**: Review access quarterly and remove unnecessary permissions
2. **Just-In-Time Access**: Use Azure AD Privileged Identity Management for temporary elevated access
3. **Separation of Duties**: Different people for development and production deployments
4. **Monitoring**: Enable logging and monitoring of role assignments
5. **Documentation**: Keep this document updated with changes

## References

- [Azure RBAC Documentation](https://docs.microsoft.com/en-us/azure/role-based-access-control/)
- [Built-in Roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
- [Best Practices](https://docs.microsoft.com/en-us/azure/role-based-access-control/best-practices)
EOF
    
    print_success "RBAC documentation created: rbac-documentation.md"
    print_success "Role assignments exported: rbac-assignments-${ENVIRONMENT}.json"
}

display_summary() {
    print_header "RBAC Setup Summary"
    
    print_info "RBAC configuration completed for: ${RG_NAME}"
    print_info ""
    print_info "Files created:"
    print_info "  - rbac-documentation.md"
    print_info "  - rbac-assignments-${ENVIRONMENT}.json"
    print_info ""
    print_info "To view current assignments:"
    print_info "  az role assignment list --resource-group ${RG_NAME} --output table"
    print_info ""
    print_info "To add a new team member:"
    print_info "  az role assignment create --assignee user@example.com --role Contributor --resource-group ${RG_NAME}"
}

# ============================================================================
# Main Execution
# ============================================================================

main() {
    print_header "Azure RBAC Configuration for ContosoUniversity"
    print_info "Environment: ${ENVIRONMENT}"
    print_info "Resource Group: ${RG_NAME}"
    
    # Check if resource group exists
    if ! az group show --name "${RG_NAME}" &> /dev/null; then
        print_error "Resource group '${RG_NAME}' does not exist"
        print_error "Please run setup-azure-subscription.sh first"
        exit 1
    fi
    
    # Setup team roles
    setup_team_roles
    
    # List current assignments
    list_current_assignments
    
    # Document RBAC
    document_rbac
    
    # Display summary
    display_summary
}

# Run main function
main
