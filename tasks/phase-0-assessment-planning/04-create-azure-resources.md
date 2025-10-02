# Task: Create Azure Resources (SQL Database, Service Bus, Storage)

## Phase
Phase 0: Assessment and Planning (Week 2, Day 1-2)

## Description
Provision all required Azure services for the development environment including SQL Database, Service Bus, and Blob Storage.

## Objectives
- Create Azure SQL Database for development
- Set up Azure Service Bus namespace and queue
- Configure Azure Blob Storage account
- Establish connectivity and access
- Document connection strings and configuration

## Prerequisites
- Azure subscription and resource groups configured
- Development environment setup complete
- Application inventory completed (to size resources appropriately)

## Dependencies
- Task 02: Set Up Azure Subscription and Resource Groups
- Task 03: Team Kickoff, Tools Setup, and Access Provisioning

## Tasks
1. **Azure SQL Database Setup:**
   - Create Azure SQL Database server
   - Configure server firewall rules (allow Azure services, dev IPs)
   - Create database with Serverless tier (1 vCore, auto-pause enabled)
   - Configure geo-redundancy (locally redundant storage for dev)
   - Create admin credentials and store in Key Vault
   - Test connectivity from development machines
   - Document connection string format

2. **Azure Service Bus Setup:**
   - Create Service Bus namespace (Standard tier)
   - Create queue for notifications
   - Configure queue properties (TTL, dead-letter queue, duplicate detection)
   - Set up access policies (send and receive permissions)
   - Create connection strings for sending and receiving
   - Test sending and receiving messages
   - Document Service Bus configuration

3. **Azure Blob Storage Setup:**
   - Create Storage Account (Standard tier, locally redundant)
   - Create blob container for teaching materials
   - Configure container access level (private)
   - Set up CORS rules if needed
   - Generate SAS token for development access
   - Test file upload and download
   - Document storage configuration

4. **Azure Key Vault Setup:**
   - Create Key Vault instance
   - Store SQL Database connection string
   - Store Service Bus connection strings
   - Store Storage Account connection string
   - Configure access policies for development team
   - Test secret retrieval
   - Document Key Vault usage

5. **Network Security:**
   - Configure firewall rules for SQL Database
   - Set up private endpoints if required
   - Configure network security groups
   - Document security configuration

6. **Monitoring Setup:**
   - Enable diagnostic logs for all resources
   - Configure log retention policies
   - Set up basic alerts (connection failures, resource usage)
   - Verify metrics are being collected

## Deliverables
- [ ] Azure SQL Database created and accessible
- [ ] Azure Service Bus namespace and queue created
- [ ] Azure Blob Storage account and container created
- [ ] Azure Key Vault created with all secrets stored
- [ ] Firewall rules configured for development access
- [ ] Connection strings documented in Key Vault
- [ ] All resources tagged appropriately
- [ ] Diagnostic logging enabled
- [ ] Basic alerts configured
- [ ] Resource configuration documented

## Acceptance Criteria
- SQL Database accessible from development machines
- Can send and receive messages to Service Bus queue
- Can upload and download files from Blob Storage
- All connection strings secured in Key Vault
- Team members can access resources with appropriate permissions
- Diagnostic logs are being collected
- Alerts trigger appropriately for test scenarios
- All resources follow naming conventions

## Estimated Effort
2 days

## Notes
- Use Azure CLI or Azure PowerShell for repeatable resource creation
- Consider creating ARM templates or Bicep files for infrastructure as code
- Keep resource costs minimal for development (use smallest tiers)
- Document resource sizing decisions for later production scaling
- Test connectivity from different network locations
- Ensure SQL Database auto-pause is enabled to reduce costs
- Consider using managed identities instead of connection strings where possible
- Keep a backup of all configuration settings
