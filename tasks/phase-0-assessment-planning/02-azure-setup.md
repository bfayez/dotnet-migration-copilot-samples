# Task: Set Up Azure Subscription and Resource Groups

## Phase
Phase 0: Assessment and Planning (Week 1, Day 3-4)

## Description
Set up the Azure subscription, resource groups, and initial configuration for the migration project.

## Objectives
- Create or configure Azure subscription
- Establish resource group structure
- Set up naming conventions and tagging strategy
- Configure access control and permissions
- Establish cost management and monitoring

## Prerequisites
- Azure account with appropriate permissions
- Approved budget for Azure resources
- Project team identified

## Dependencies
- Task 01: Application Inventory and Dependency Analysis (to understand resource requirements)

## Tasks
1. **Azure Subscription Setup:**
   - Create or configure Azure subscription
   - Set up billing alerts and budget limits
   - Configure cost management policies
   - Document subscription details

2. **Resource Group Structure:**
   - Create resource group for Development environment
   - Create resource group for Production environment (optional at this stage)
   - Apply naming conventions (e.g., rg-contoso-university-dev, rg-contoso-university-prod)
   - Set up resource group tags (Environment, Project, Owner, CostCenter)

3. **Access Control:**
   - Configure Azure AD/Entra ID access
   - Set up RBAC roles for team members
   - Create service principals for CI/CD
   - Document access control policies

4. **Network Configuration:**
   - Plan virtual network topology (if needed)
   - Configure network security groups
   - Plan private endpoints strategy
   - Document network architecture

5. **Governance Setup:**
   - Apply Azure policies for compliance
   - Set up management locks for production resources
   - Configure activity logging
   - Set up Azure Monitor for resource tracking

## Deliverables
- [ ] Azure subscription configured and accessible
- [ ] Resource groups created (dev and prod)
- [ ] Naming conventions and tagging strategy documented
- [ ] RBAC roles assigned to team members
- [ ] Service principals created for automation
- [ ] Cost alerts configured
- [ ] Governance policies applied
- [ ] Network topology documented

## Acceptance Criteria
- All team members can access Azure subscription with appropriate permissions
- Resource groups created with proper naming and tags
- Cost alerts trigger at defined thresholds
- Service principals can authenticate and access resources
- Governance policies enforce compliance requirements
- Documentation complete and accessible to team

## Estimated Effort
2 days

## Implementation Resources

All automation scripts and documentation for this task are available in the `/infrastructure/azure-setup/` directory:

### Scripts
- **setup-azure-subscription.sh** - Bash script for Azure subscription and resource group setup
- **setup-azure-subscription.ps1** - PowerShell script (alternative for Windows users)
- **setup-rbac.sh** - Configure Role-Based Access Control for team members
- **create-service-principal.sh** - Create service principal for CI/CD automation

### Documentation
- **README.md** - Complete guide with step-by-step instructions and troubleshooting
- **naming-conventions.md** - Comprehensive naming and tagging strategy guide
- **network-topology.md** - Generated network architecture documentation (after running setup)

### Quick Start
```bash
cd infrastructure/azure-setup

# 1. Login to Azure
az login

# 2. Set up subscription and resource groups
./setup-azure-subscription.sh dev

# 3. Configure RBAC roles
./setup-rbac.sh dev

# 4. Create service principal for CI/CD
./create-service-principal.sh dev
```

For detailed instructions, see `/infrastructure/azure-setup/README.md`

## Notes
- Follow Azure naming conventions: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging
- Consider using Azure landing zones for enterprise deployments
- Set up separate resource groups for shared resources (networking, monitoring)
- Use least-privilege principle for RBAC assignments
- Document all credentials securely (use Azure Key Vault or password manager)
- All scripts are idempotent and can be re-run safely
- Generated credentials files are automatically excluded from git via .gitignore
