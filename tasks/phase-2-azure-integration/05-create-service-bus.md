# Task: Create Azure Service Bus Namespace and Queue

## Phase
Phase 2: Azure Services Integration (Week 2)

## Description
Create and configure Azure Service Bus namespace and queue to replace MSMQ for notification messaging.

## Objectives
- Create Azure Service Bus namespace
- Create queue for notifications
- Configure queue properties
- Set up access policies
- Test message sending and receiving

## Prerequisites
- Azure subscription and resource groups configured
- Understanding of current MSMQ implementation
- NotificationService code reviewed

## Dependencies
- Phase 2: Task 04 - Update Connection String and Test Connectivity

## Tasks
1. **Create Service Bus Namespace:**
   - Create namespace in Azure portal or CLI
   - Choose Standard tier (supports queues and topics)
   - Select appropriate region (same as other resources)
   - Use naming convention (e.g., sbns-contoso-university-dev)
   - Document configuration

2. **Configure Namespace Settings:**
   - Configure messaging units if Premium (not needed for Standard)
   - Enable zone redundancy (optional for dev)
   - Configure diagnostic logs
   - Set up monitoring

3. **Create Queue:**
   - Create queue named "notifications"
   - Configure queue properties:
     - Max size: 1 GB (dev)
     - Message TTL: 14 days
     - Lock duration: 30 seconds
     - Max delivery count: 10
     - Enable dead-letter queue
     - Enable duplicate detection (5-minute window)
   - Document queue configuration

4. **Configure Access Policies:**
   - Create policy with Send and Listen permissions
   - Name: "SendListenPolicy"
   - Generate connection string
   - Store connection string in Key Vault

5. **Test Queue in Portal:**
   - Use Service Bus Explorer in portal
   - Send test message
   - Receive test message
   - Verify message delivery
   - Test dead-letter queue

6. **Configure Monitoring:**
   - Enable diagnostic logs
   - Configure metrics collection
   - Set up basic alerts:
     - Dead-letter message count
     - Active message count
     - Failed requests
   - Create monitoring dashboard

7. **Configure Dead-Letter Queue:**
   - Verify dead-letter queue is enabled
   - Document dead-letter handling strategy
   - Plan for monitoring dead-letter messages

8. **Security Configuration:**
   - Review access policies
   - Consider using Managed Identity (Phase 2, later task)
   - Verify network access
   - Document security settings

9. **Performance Configuration:**
   - Configure batch processing settings
   - Set appropriate prefetch count
   - Document performance settings
   - Plan for scaling if needed

10. **Document Configuration:**
    - Document namespace and queue settings
    - Document connection string format
    - Create troubleshooting guide
    - Document monitoring and alerts

## Deliverables
- [ ] Service Bus namespace created
- [ ] Queue created with proper configuration
- [ ] Access policies configured
- [ ] Connection string stored in Key Vault
- [ ] Test messages sent and received
- [ ] Monitoring and alerts configured
- [ ] Dead-letter queue configured
- [ ] Configuration documented

## Acceptance Criteria
- Service Bus namespace is accessible
- Queue is created with correct properties
- Can send and receive messages via portal
- Connection string is secured
- Monitoring is capturing metrics
- Alerts are configured
- Documentation is complete
- Dead-letter queue handling is defined

## Estimated Effort
1 day

## Notes
- Standard tier is sufficient for most scenarios
- Premium tier offers better performance and isolation
- Use duplicate detection to prevent duplicate notifications
- Monitor dead-letter queue regularly
- Set appropriate TTL to prevent message accumulation
- Consider using topics if multiple subscribers needed
- Test failover and recovery scenarios
- Document any network requirements
- Plan for production queue sizing separately
