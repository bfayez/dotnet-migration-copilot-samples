# Task: Set Up Azure Key Vault and Move Secrets

## Phase
Phase 2: Azure Services Integration (Week 3)

## Description
Create Azure Key Vault and migrate all secrets from configuration files to secure storage.

## Objectives
- Create Azure Key Vault
- Store connection strings and secrets
- Configure application to read from Key Vault
- Implement Managed Identity (preparation)
- Remove secrets from appsettings.json

## Prerequisites
- Azure subscription configured
- All connection strings documented
- Understanding of secrets to migrate

## Dependencies
- Phase 2: Task 10 - Implement Azure AD B2C Authentication

## Tasks
1. Create Azure Key Vault in Azure portal
2. Configure access policies for development team
3. Store secrets in Key Vault:
   - SQL Database connection string
   - Service Bus connection string
   - Storage Account connection string
   - Azure AD B2C client secret
4. Add Azure.Extensions.AspNetCore.Configuration.Secrets package
5. Configure application to read from Key Vault
6. Test application with Key Vault integration
7. Remove secrets from appsettings.json (keep keys only)
8. Update documentation
9. Plan for Managed Identity setup (Phase 4)

## Estimated Effort
1-2 days

## Acceptance Criteria
- Key Vault is created
- All secrets are stored in Key Vault
- Application reads secrets from Key Vault
- No secrets in appsettings.json
- Application works correctly
- Documentation is updated
