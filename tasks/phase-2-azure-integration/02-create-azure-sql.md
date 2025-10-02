# Task: Create Azure SQL Database

## Phase
Phase 2: Azure Services Integration (Week 1)

## Description
Create and configure Azure SQL Database for the development environment with proper sizing, security, and configuration.

## Objectives
- Create Azure SQL Database server and database
- Configure firewall rules and networking
- Set up authentication and access control
- Configure backup and recovery
- Test connectivity

## Prerequisites
- Azure subscription configured
- Database schema exported
- Resource groups created
- Understanding of database requirements

## Dependencies
- Phase 0: Task 04 - Create Azure Resources (partial - may need SQL-specific setup)
- Phase 2: Task 01 - Export Schema and Data from LocalDB

## Tasks
1. **Create SQL Database Server:**
   - Create logical SQL Server in Azure
   - Choose appropriate region
   - Configure server admin credentials
   - Use naming convention (e.g., sql-contoso-university-dev)
   - Store credentials in Key Vault

2. **Create SQL Database:**
   - Create database with Serverless tier
   - Choose vCore model (1 vCore for dev)
   - Configure auto-pause delay (1 hour)
   - Set minimum and maximum vCores
   - Configure storage (5-10 GB for dev)

3. **Configure Firewall Rules:**
   - Add "Allow Azure services and resources to access this server"
   - Add IP addresses for development machines
   - Add IP ranges for office/VPN if needed
   - Document firewall rules

4. **Configure Advanced Security:**
   - Enable Advanced Data Security (if needed)
   - Configure threat detection
   - Enable auditing (optional for dev)
   - Configure data classification

5. **Configure Backup and Recovery:**
   - Verify automatic backup is enabled (default)
   - Configure backup retention (7 days for dev)
   - Document point-in-time restore capability
   - Test backup/restore process

6. **Configure Connection Resiliency:**
   - Enable connection retry logic (already in code)
   - Configure connection pooling settings
   - Set command timeout appropriately
   - Document connection string format

7. **Test Connectivity:**
   - Test connection from Azure Portal query editor
   - Test connection from SSMS/Azure Data Studio
   - Test connection from application
   - Verify firewall rules work

8. **Configure Monitoring:**
   - Enable diagnostic logs
   - Configure log retention
   - Set up basic alerts (DTU usage, storage)
   - Create dashboard for monitoring

9. **Document Configuration:**
   - Document server and database settings
   - Document connection string format
   - Document security configuration
   - Create troubleshooting guide

## Deliverables
- [ ] Azure SQL Server created
- [ ] Azure SQL Database created (Serverless tier)
- [ ] Firewall rules configured
- [ ] Advanced security configured
- [ ] Backup and recovery verified
- [ ] Connectivity tested from multiple sources
- [ ] Monitoring and alerts configured
- [ ] Configuration documented
- [ ] Connection string stored in Key Vault

## Acceptance Criteria
- SQL Server and database are accessible
- Can connect from development machines
- Can connect from Azure services
- Firewall rules allow required access
- Backup is configured correctly
- Monitoring is capturing metrics
- Connection string is secured in Key Vault
- Documentation is complete

## Estimated Effort
1 day

## Notes
- Use Serverless tier for development to minimize costs
- Database auto-pauses after 1 hour of inactivity
- First request after auto-pause may be slow (resume time)
- Use locally redundant storage for dev (cheaper)
- Consider geo-redundancy for production
- Set up cost alerts to avoid surprises
- Test connection from different networks
- Document any connection troubleshooting steps
- Use managed identity for production (setup in later task)
