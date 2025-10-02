# Task: Create Azure Blob Storage Account and Container

## Phase
Phase 2: Azure Services Integration (Week 2)

## Description
Create Azure Blob Storage account and container to replace local file system for teaching material uploads.

## Objectives
- Create Azure Storage account
- Create blob container for teaching materials
- Configure access and security
- Test blob operations
- Set up monitoring

## Prerequisites
- Azure subscription and resource groups configured
- Understanding of current file upload implementation
- File upload paths documented

## Dependencies
- Phase 2: Task 06 - Update NotificationService to Use Azure Service Bus

## Tasks
1. **Create Storage Account:**
   - Create storage account in Azure portal or CLI
   - Choose Standard performance tier
   - Choose Locally Redundant Storage (LRS) for dev
   - Use naming convention (e.g., stcontosounivdev)
   - Select same region as other resources
   - Enable soft delete (optional for dev)

2. **Configure Storage Account Settings:**
   - Enable blob versioning (optional)
   - Configure firewall and virtual networks
   - Enable secure transfer required (HTTPS)
   - Configure minimum TLS version (1.2)
   - Document configuration

3. **Create Blob Container:**
   - Create container named "teaching-materials"
   - Set access level to Private (blob)
   - Configure metadata if needed
   - Document container settings

4. **Configure CORS (if needed):**
   - Add CORS rules for web access
   - Configure allowed origins
   - Configure allowed methods (GET, POST, PUT, DELETE)
   - Configure allowed headers
   - Test CORS configuration

5. **Set Up Access Keys:**
   - Generate access keys
   - Store connection string in Key Vault
   - Document key rotation policy
   - Plan for using Managed Identity later

6. **Configure SAS Tokens:**
   - Understand SAS token creation
   - Document SAS token usage for secure file access
   - Plan SAS token expiration strategy
   - Test SAS token generation

7. **Test Blob Operations:**
   - Use Azure Storage Explorer
   - Upload test file
   - Download test file
   - Delete test file
   - List blobs in container

8. **Configure Lifecycle Management:**
   - Set up blob lifecycle policies (optional)
   - Archive old blobs to cool/archive tier
   - Delete old blobs after retention period
   - Document lifecycle policy

9. **Configure Monitoring:**
   - Enable diagnostic logs
   - Configure metrics collection
   - Set up alerts for:
     - Storage capacity
     - Failed requests
     - Throttling
   - Create monitoring dashboard

10. **Configure Backup (optional for dev):**
    - Enable soft delete
    - Configure retention period
    - Document backup strategy
    - Test restore process

11. **Security Configuration:**
    - Review access policies
    - Verify HTTPS is enforced
    - Plan for managed identity usage
    - Document security settings

12. **Cost Optimization:**
    - Review storage tier (Hot for dev)
    - Configure lifecycle management
    - Monitor storage usage
    - Set up cost alerts

## Deliverables
- [ ] Storage account created
- [ ] Blob container created
- [ ] Access configured (private)
- [ ] Connection string stored in Key Vault
- [ ] CORS configured if needed
- [ ] SAS token strategy documented
- [ ] Monitoring and alerts configured
- [ ] Test operations completed successfully
- [ ] Configuration documented

## Acceptance Criteria
- Storage account is accessible
- Blob container is created
- Can upload and download blobs
- Connection string is secured
- CORS works if needed
- Monitoring captures metrics
- Alerts are configured
- Documentation is complete
- Security settings are appropriate

## Estimated Effort
1 day

## Notes
- Use Hot tier for frequently accessed files
- Consider Cool or Archive tier for old files
- Enable soft delete for accidental deletion protection
- Use Managed Identity for better security (later task)
- Test blob operations from Azure Portal
- Monitor storage costs regularly
- Plan for CDN integration if global access needed
- Document naming conventions for blobs
- Consider using Storage Explorer for testing
- Plan for production storage sizing separately
