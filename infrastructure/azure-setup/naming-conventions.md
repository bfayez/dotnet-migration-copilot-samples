# Azure Naming Conventions and Tagging Strategy

## ContosoUniversity Migration Project

### Document Information
- **Version**: 1.0
- **Last Updated**: 2024
- **Owner**: DevOps Team

---

## Table of Contents
1. [Overview](#overview)
2. [Naming Conventions](#naming-conventions)
3. [Tagging Strategy](#tagging-strategy)
4. [Resource-Specific Guidelines](#resource-specific-guidelines)
5. [Examples](#examples)

---

## Overview

This document defines the naming conventions and tagging strategy for all Azure resources in the ContosoUniversity migration project. These standards ensure:

- **Consistency**: Uniform naming across all resources
- **Clarity**: Easy identification of resource purpose and environment
- **Organization**: Simplified resource management and billing
- **Governance**: Compliance with organizational policies

### Key Principles

1. **Predictable**: Names follow a consistent pattern
2. **Descriptive**: Names clearly indicate resource purpose
3. **Concise**: Names are as short as possible while remaining clear
4. **Lowercase**: Use lowercase with hyphens for readability
5. **Unique**: Names are unique within their scope

---

## Naming Conventions

### General Pattern

```
<resource-type>-<project>-<environment>-<region>-<instance>
```

**Components:**
- `resource-type`: Azure resource abbreviation (see table below)
- `project`: Project name (contoso-university or contoso-univ for brevity)
- `environment`: dev, staging, prod
- `region`: eastus, westus, etc. (optional, use when multi-region)
- `instance`: 001, 002, etc. (optional, use when multiple instances needed)

### Resource Type Abbreviations

Based on [Microsoft's Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations):

| Resource Type | Abbreviation | Example |
|--------------|--------------|---------|
| Resource Group | rg | rg-contoso-university-dev |
| Virtual Network | vnet | vnet-contoso-univ-dev |
| Subnet | snet | snet-app-dev |
| Network Security Group | nsg | nsg-app-dev |
| Storage Account | st | stcontosounivdev (no hyphens, max 24 chars) |
| SQL Server | sql | sql-contoso-univ-dev |
| SQL Database | sqldb | sqldb-contoso-univ-dev |
| Container Apps Environment | cae | cae-contoso-univ-dev |
| Container App | ca | ca-contoso-univ-dev |
| Service Bus Namespace | sbns | sbns-contoso-univ-dev |
| Service Bus Queue | sbq | sbq-notifications |
| Key Vault | kv | kv-contoso-univ-dev (max 24 chars) |
| Log Analytics Workspace | log | log-contoso-univ-dev |
| Application Insights | appi | appi-contoso-univ-dev |
| Container Registry | acr | acrcontosounivdev (no hyphens, max 50 chars) |
| Public IP Address | pip | pip-contoso-univ-dev |
| Load Balancer | lb | lb-contoso-univ-dev |
| Azure AD App Registration | app | app-contoso-univ-dev |
| Service Principal | sp | sp-contoso-univ-dev-cicd |
| Managed Identity | id | id-contoso-univ-dev |

### Environment Abbreviations

| Environment | Abbreviation | Purpose |
|-------------|--------------|---------|
| Development | dev | Development and testing |
| Staging | staging | Pre-production validation |
| Production | prod | Live production environment |
| Sandbox | sandbox | Experimentation and learning |
| Shared | shared | Shared services across environments |

### Special Considerations

#### Storage Accounts
- **Format**: `st<project><environment><instance>`
- **Rules**: Lowercase letters and numbers only, no hyphens, 3-24 characters
- **Example**: `stcontosounivdev`, `stcontosounivprod`

#### Key Vaults
- **Format**: `kv-<project>-<environment>`
- **Rules**: 3-24 characters, alphanumerics and hyphens only
- **Example**: `kv-contoso-univ-dev`, `kv-contoso-univ-prod`

#### Container Registry
- **Format**: `acr<project><environment>`
- **Rules**: Lowercase letters and numbers only, no hyphens, 5-50 characters
- **Example**: `acrcontosounivdev`, `acrcontosounivprod`

---

## Tagging Strategy

### Required Tags

All resources must have the following tags:

| Tag Name | Description | Example Values | Required |
|----------|-------------|----------------|----------|
| Environment | Deployment environment | dev, staging, prod | Yes |
| Project | Project or application name | ContosoUniversity | Yes |
| Owner | Team or individual responsible | DevOps Team, john.doe@contoso.com | Yes |
| CostCenter | Cost allocation identifier | IT-Migration, Engineering | Yes |

### Optional Tags

Additional tags for enhanced management:

| Tag Name | Description | Example Values |
|----------|-------------|----------------|
| ManagedBy | How resource is managed | Terraform, ARM, Manual, Bicep |
| Version | Application or infrastructure version | v1.0, v2.3 |
| DataClassification | Data sensitivity level | Public, Internal, Confidential, Restricted |
| BusinessUnit | Business unit or department | IT, Engineering, Finance |
| MaintenanceWindow | Preferred maintenance time | Saturday-02:00-04:00 |
| BackupPolicy | Backup requirements | Daily, Weekly, None |
| DR | Disaster recovery tier | Critical, High, Medium, Low |
| ComplianceRequirement | Compliance standards | HIPAA, PCI-DSS, GDPR, None |

### Tag Value Guidelines

1. **Consistency**: Use consistent capitalization (Title Case for names, lowercase for environments)
2. **Valid Characters**: Use alphanumeric characters, spaces, and these special characters: `+ - = . _ : /`
3. **Length**: Tag names max 512 characters, values max 256 characters
4. **Reserved Prefixes**: Don't use `azure:`, `microsoft:`, or `windows:` prefixes

### Tag Application Example

```json
{
  "tags": {
    "Environment": "dev",
    "Project": "ContosoUniversity",
    "Owner": "DevOps Team",
    "CostCenter": "IT-Migration",
    "ManagedBy": "ARM",
    "DataClassification": "Internal",
    "MaintenanceWindow": "Saturday-02:00-04:00"
  }
}
```

### Applying Tags

#### Azure CLI
```bash
az resource tag \
  --tags Environment=dev Project=ContosoUniversity Owner="DevOps Team" CostCenter=IT-Migration \
  --resource-group rg-contoso-university-dev
```

#### Azure Portal
1. Navigate to resource
2. Click "Tags" in left menu
3. Add name-value pairs
4. Click "Save"

---

## Resource-Specific Guidelines

### Resource Groups

**Format**: `rg-<project>-<environment>`

**Examples**:
- `rg-contoso-university-dev`
- `rg-contoso-university-staging`
- `rg-contoso-university-prod`
- `rg-contoso-university-shared` (for shared services)

**Required Tags**: All required tags

### Storage Accounts

**Format**: `st<project><environment><instance>`

**Examples**:
- `stcontosounivdev`
- `stcontosounivprod`
- `stcontosounivlogs` (for diagnostic logs)

**Notes**:
- Must be globally unique
- If name taken, add region or number: `stcontosounivdeveus`, `stcontosounivdev01`

### SQL Resources

**Server Format**: `sql-<project>-<environment>`
**Database Format**: `sqldb-<project>-<environment>`

**Examples**:
- Server: `sql-contoso-univ-dev`
- Database: `sqldb-contoso-univ-dev`

**Notes**:
- Server names must be globally unique
- Add region suffix if needed: `sql-contoso-univ-dev-eastus`

### Container Apps

**Environment Format**: `cae-<project>-<environment>`
**App Format**: `ca-<app-name>-<environment>`

**Examples**:
- Environment: `cae-contoso-univ-dev`
- App: `ca-contoso-univ-web-dev`

### Service Bus

**Namespace Format**: `sbns-<project>-<environment>`
**Queue Format**: `sbq-<purpose>`

**Examples**:
- Namespace: `sbns-contoso-univ-dev`
- Queue: `sbq-notifications`, `sbq-events`

**Notes**:
- Namespace must be globally unique
- Queue names should be descriptive and purpose-driven

### Key Vault

**Format**: `kv-<project>-<environment>`

**Examples**:
- `kv-contoso-univ-dev`
- `kv-contoso-univ-prod`

**Notes**:
- Must be globally unique
- 3-24 characters
- If taken, try abbreviations: `kv-cu-dev`, `kv-contoso-dev`

### Networking

**VNet Format**: `vnet-<project>-<environment>`
**Subnet Format**: `snet-<purpose>-<environment>`
**NSG Format**: `nsg-<purpose>-<environment>`

**Examples**:
- VNet: `vnet-contoso-univ-dev`
- Subnets: `snet-app-dev`, `snet-data-dev`, `snet-mgmt-dev`
- NSGs: `nsg-app-dev`, `nsg-data-dev`

---

## Examples

### Development Environment

```
Resource Group:           rg-contoso-university-dev
Virtual Network:          vnet-contoso-univ-dev
  - App Subnet:          snet-app-dev
  - Data Subnet:         snet-data-dev
  - App NSG:             nsg-app-dev
  - Data NSG:            nsg-data-dev
Storage Account:          stcontosounivdev
SQL Server:               sql-contoso-univ-dev
SQL Database:             sqldb-contoso-univ-dev
Service Bus Namespace:    sbns-contoso-univ-dev
  - Notifications Queue:  sbq-notifications
Key Vault:                kv-contoso-univ-dev
Container Apps Env:       cae-contoso-univ-dev
Container App:            ca-contoso-univ-web-dev
Container Registry:       acrcontosounivdev
Log Analytics:            log-contoso-univ-dev
Application Insights:     appi-contoso-univ-dev
Service Principal:        sp-contoso-univ-dev-cicd
```

### Production Environment

```
Resource Group:           rg-contoso-university-prod
Virtual Network:          vnet-contoso-univ-prod
  - App Subnet:          snet-app-prod
  - Data Subnet:         snet-data-prod
Storage Account:          stcontosounivprod
SQL Server:               sql-contoso-univ-prod
SQL Database:             sqldb-contoso-univ-prod
Service Bus Namespace:    sbns-contoso-univ-prod
  - Notifications Queue:  sbq-notifications
Key Vault:                kv-contoso-univ-prod
Container Apps Env:       cae-contoso-univ-prod
Container App:            ca-contoso-univ-web-prod
Container Registry:       acrcontosounivprod
Log Analytics:            log-contoso-univ-prod
Application Insights:     appi-contoso-univ-prod
Service Principal:        sp-contoso-univ-prod-cicd
```

---

## Governance and Enforcement

### Azure Policy

Use Azure Policy to enforce naming conventions and tagging:

```json
{
  "policyRule": {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          "field": "tags['Environment']",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  }
}
```

### Validation Scripts

Use scripts to validate naming before resource creation:

```bash
#!/bin/bash
# Validate resource name follows convention
validate_name() {
    local name=$1
    local type=$2
    
    # Example: Storage account validation
    if [[ $type == "storage" ]]; then
        if [[ ! $name =~ ^st[a-z0-9]{3,22}$ ]]; then
            echo "Invalid storage account name: $name"
            return 1
        fi
    fi
    
    return 0
}
```

---

## Maintenance and Updates

### Review Schedule
- **Quarterly**: Review naming conventions for relevance
- **Annually**: Update based on Microsoft best practices
- **As Needed**: Update when adding new resource types

### Change Process
1. Propose changes to DevOps team
2. Review impact on existing resources
3. Update documentation
4. Communicate to all team members
5. Apply to new resources (don't rename existing unless necessary)

---

## References

- [Microsoft Cloud Adoption Framework - Naming Conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- [Resource Naming Abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Azure Tagging Best Practices](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging)
- [Azure Resource Naming Restrictions](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
