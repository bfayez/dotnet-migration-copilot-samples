# Azure Subscription and Resource Groups Setup Script (PowerShell)
# This script sets up the Azure subscription, resource groups, and initial configuration
# for the ContosoUniversity migration project.
#
# Prerequisites:
# - Azure PowerShell module installed (Install-Module -Name Az -AllowClobber -Scope CurrentUser)
# - Azure account with appropriate permissions (Owner or Contributor on subscription)
# - Logged in to Azure: Connect-AzAccount
#
# Usage:
#   .\setup-azure-subscription.ps1 [-Environment <dev|staging|prod>]

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('dev','staging','prod')]
    [string]$Environment = 'dev'
)

# ============================================================================
# Configuration Variables
# ============================================================================

$ProjectName = "contoso-university"
$Location = "eastus"  # Change to your preferred Azure region

# Naming conventions based on Azure best practices
$ResourceGroupName = "rg-$ProjectName-$Environment"

# Tags for resource management
$Tags = @{
    Environment = $Environment
    Project = "ContosoUniversity"
    Owner = "DevOps Team"
    CostCenter = "IT-Migration"
    ManagedBy = "PowerShell"
}

# Cost Management
$BudgetName = "budget-$ProjectName-$Environment"
$BudgetAmount = 500  # Monthly budget in USD
$AlertThresholds = @(50, 75, 90)
$AlertEmail = "your-email@example.com"  # Update with your email

# ============================================================================
# Helper Functions
# ============================================================================

function Write-Header {
    param([string]$Message)
    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor Cyan
    Write-Host "========================================================================" -ForegroundColor Cyan
}

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor White
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

# ============================================================================
# Pre-flight Checks
# ============================================================================

function Test-Prerequisites {
    Write-Header "Checking Prerequisites"
    
    # Check if Az module is installed
    Write-Info "Checking Azure PowerShell module..."
    if (!(Get-Module -ListAvailable -Name Az)) {
        Write-Error "Azure PowerShell module is not installed."
        Write-Info "Install it with: Install-Module -Name Az -AllowClobber -Scope CurrentUser"
        exit 1
    }
    Write-Success "Azure PowerShell module is installed"
    
    # Check if logged in to Azure
    Write-Info "Checking Azure login..."
    try {
        $context = Get-AzContext
        if (!$context) {
            Write-Error "Not logged in to Azure. Please run: Connect-AzAccount"
            exit 1
        }
        Write-Success "Logged in to Azure"
        Write-Info "Subscription: $($context.Subscription.Name)"
    }
    catch {
        Write-Error "Not logged in to Azure. Please run: Connect-AzAccount"
        exit 1
    }
}

# ============================================================================
# Main Setup Functions
# ============================================================================

function Set-AzureSubscription {
    Write-Header "1. Azure Subscription Setup"
    
    $context = Get-AzContext
    Write-Info "Current Subscription:"
    Write-Info "  ID: $($context.Subscription.Id)"
    Write-Info "  Name: $($context.Subscription.Name)"
    
    # Confirm subscription
    $confirmation = Read-Host "Continue with this subscription? (Y/N)"
    if ($confirmation -ne 'Y' -and $confirmation -ne 'y') {
        Write-Info "Listing available subscriptions..."
        Get-AzSubscription | Format-Table -Property Name, Id, State
        $subId = Read-Host "Enter the subscription ID to use"
        Set-AzContext -SubscriptionId $subId
        Write-Success "Switched to subscription: $subId"
    }
    
    # Document subscription details
    $context = Get-AzContext
    $subscriptionDetails = @"
Azure Subscription Details
==========================
Subscription ID: $($context.Subscription.Id)
Subscription Name: $($context.Subscription.Name)
Tenant ID: $($context.Tenant.Id)
Environment: $Environment
Setup Date: $(Get-Date)
"@
    
    $subscriptionDetails | Out-File -FilePath "subscription-details.txt" -Encoding UTF8
    Write-Success "Subscription details documented in subscription-details.txt"
}

function New-AzureResourceGroups {
    Write-Header "2. Create Resource Groups"
    
    Write-Info "Creating resource group: $ResourceGroupName"
    
    # Create resource group
    $rg = New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location $Location `
        -Tag $Tags `
        -Force
    
    Write-Success "Resource group created: $ResourceGroupName"
    
    # Display resource group details
    Write-Info "Resource group details:"
    $rg | Format-List Name, Location, ResourceId, Tags
}

function Set-CostManagement {
    Write-Header "3. Configure Cost Management and Budgets"
    
    Write-Info "Setting up budget: $BudgetName"
    
    # Create budget configuration
    $budgetConfig = @{
        category = "Cost"
        amount = $BudgetAmount
        timeGrain = "Monthly"
        timePeriod = @{
            startDate = (Get-Date -Day 1).ToString("yyyy-MM-dd")
            endDate = (Get-Date -Year ((Get-Date).Year + 1) -Month 12 -Day 31).ToString("yyyy-MM-dd")
        }
        notifications = @{}
    }
    
    # Add notifications for each threshold
    foreach ($threshold in $AlertThresholds) {
        $budgetConfig.notifications["Actual_GreaterThan_${threshold}_Percent"] = @{
            enabled = $true
            operator = "GreaterThan"
            threshold = $threshold
            contactEmails = @($AlertEmail)
            contactRoles = @("Owner", "Contributor")
            thresholdType = "Actual"
        }
    }
    
    $budgetConfig | ConvertTo-Json -Depth 10 | Out-File -FilePath "budget-config.json" -Encoding UTF8
    
    Write-Info "Budget configuration saved to budget-config.json"
    Write-Warning "Note: Budget creation requires Cost Management permissions"
    Write-Info "To create budget in Azure Portal:"
    Write-Info "  1. Go to Cost Management + Billing"
    Write-Info "  2. Select your subscription"
    Write-Info "  3. Select Budgets"
    Write-Info "  4. Click Add and use values from budget-config.json"
}

function Set-Governance {
    Write-Header "4. Configure Governance and Policies"
    
    Write-Info "Setting up governance for resource group: $ResourceGroupName"
    
    # Activity logging is enabled by default
    Write-Info "Activity logging is enabled by default for all Azure resources"
    
    # Apply management locks for production
    if ($Environment -eq "prod") {
        Write-Info "Applying management lock to production resource group"
        $lock = New-AzResourceLock `
            -LockName "CannotDelete-$ResourceGroupName" `
            -LockLevel CanNotDelete `
            -ResourceGroupName $ResourceGroupName `
            -LockNotes "Prevent accidental deletion of production resources" `
            -Force
        Write-Success "Management lock applied to $ResourceGroupName"
    }
    else {
        Write-Info "Skipping management lock for $Environment environment"
    }
    
    # Document governance policies
    $governancePolicies = @"
Governance Policies Applied
===========================
Environment: $Environment
Resource Group: $ResourceGroupName
Date: $(Get-Date)

1. Activity Logging: Enabled (default for all Azure resources)
2. Management Locks: $(if ($Environment -eq "prod") { "CanNotDelete lock applied" } else { "Not applied (dev environment)" })
3. Azure Policies: To be configured based on compliance requirements
4. RBAC: To be configured in next step

Recommended Policies to Apply:
- Enforce tagging on resources
- Restrict allowed locations
- Enforce encryption for storage accounts
- Require secure transfer for storage accounts
- Audit VMs without managed disks
- Require backup on VMs
"@
    
    $governancePolicies | Out-File -FilePath "governance-policies.txt" -Encoding UTF8
    Write-Success "Governance policies documented in governance-policies.txt"
}

function Set-Monitoring {
    Write-Header "5. Configure Azure Monitor"
    
    Write-Info "Setting up Azure Monitor for resource tracking"
    
    # Ask about Log Analytics workspace
    $createWorkspace = Read-Host "Create Log Analytics workspace for monitoring? (Y/N)"
    if ($createWorkspace -eq 'Y' -or $createWorkspace -eq 'y') {
        $workspaceName = "log-$ProjectName-$Environment"
        
        Write-Info "Creating Log Analytics workspace: $workspaceName"
        $workspace = New-AzOperationalInsightsWorkspace `
            -ResourceGroupName $ResourceGroupName `
            -Name $workspaceName `
            -Location $Location `
            -Tag @{
                Environment = $Environment
                Project = $Tags.Project
            }
        
        Write-Success "Log Analytics workspace created: $workspaceName"
        
        # Save workspace ID
        $workspaceId = $workspace.ResourceId
        "WORKSPACE_ID=$workspaceId" | Out-File -FilePath ".env" -Encoding UTF8
        Write-Info "Workspace ID saved to .env file"
    }
    else {
        Write-Info "Skipping Log Analytics workspace creation"
    }
    
    Write-Info "Monitor configuration complete"
}

function New-NetworkTopologyDoc {
    Write-Header "6. Document Network Architecture"
    
    $networkTopology = @"
# Network Architecture Plan for ContosoUniversity

## Environment: $Environment

## Virtual Network Topology

### Overview
This document outlines the network architecture for the ContosoUniversity application on Azure.

### Virtual Network (VNet)
- **Name**: vnet-$ProjectName-$Environment
- **Address Space**: 10.0.0.0/16
- **Location**: $Location

### Subnets

1. **Application Subnet**
   - Name: snet-app-$Environment
   - Address Range: 10.0.1.0/24
   - Purpose: Host Azure Container Apps
   - Service Endpoints: Microsoft.Sql, Microsoft.Storage

2. **Data Subnet**
   - Name: snet-data-$Environment
   - Address Range: 10.0.2.0/24
   - Purpose: Private endpoints for Azure SQL, Storage, Service Bus
   - Service Endpoints: Microsoft.Sql, Microsoft.Storage, Microsoft.ServiceBus

3. **Management Subnet**
   - Name: snet-mgmt-$Environment
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
"@
    
    $networkTopology | Out-File -FilePath "network-topology.md" -Encoding UTF8
    Write-Success "Network topology documented in network-topology.md"
}

function Show-Summary {
    Write-Header "Setup Summary"
    
    Write-Info "Azure Subscription and Resource Groups setup completed!"
    Write-Info ""
    Write-Info "Environment: $Environment"
    Write-Info "Resource Group: $ResourceGroupName"
    Write-Info "Location: $Location"
    Write-Info ""
    Write-Info "Files created:"
    Write-Info "  - subscription-details.txt"
    Write-Info "  - budget-config.json"
    Write-Info "  - governance-policies.txt"
    Write-Info "  - network-topology.md"
    if (Test-Path ".env") {
        Write-Info "  - .env"
    }
    Write-Info ""
    Write-Info "Next steps:"
    Write-Info "  1. Configure RBAC roles (run setup-rbac.ps1)"
    Write-Info "  2. Create service principals for CI/CD"
    Write-Info "  3. Create Azure resources (SQL, Service Bus, Storage)"
    Write-Info "  4. Set up monitoring and alerts"
    Write-Info ""
    Write-Info "To view resource group:"
    Write-Info "  Get-AzResourceGroup -Name $ResourceGroupName"
    Write-Info ""
    Write-Info "To list resources in group:"
    Write-Info "  Get-AzResource -ResourceGroupName $ResourceGroupName"
}

# ============================================================================
# Main Execution
# ============================================================================

function Main {
    Write-Header "Azure Subscription and Resource Groups Setup"
    Write-Info "Environment: $Environment"
    Write-Info "Project: $ProjectName"
    Write-Info "Location: $Location"
    
    # Pre-flight checks
    Test-Prerequisites
    
    # Execute setup steps
    Set-AzureSubscription
    New-AzureResourceGroups
    Set-CostManagement
    Set-Governance
    Set-Monitoring
    New-NetworkTopologyDoc
    
    # Display summary
    Show-Summary
}

# Run main function
try {
    Main
}
catch {
    Write-Error "An error occurred: $_"
    Write-Error $_.ScriptStackTrace
    exit 1
}
