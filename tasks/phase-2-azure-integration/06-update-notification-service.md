# Task: Update NotificationService to Use Azure Service Bus

## Phase
Phase 2: Azure Services Integration (Week 2)

## Description
Replace the MSMQ-based NotificationService implementation with Azure Service Bus for cross-platform messaging.

## Objectives
- Remove System.Messaging dependencies
- Implement Azure Service Bus message sending
- Implement message receiving/polling
- Update error handling and retry logic
- Test notification functionality

## Prerequisites
- Azure Service Bus namespace and queue created
- Connection string available
- NotificationService interface defined
- Understanding of current notification flow

## Dependencies
- Phase 2: Task 05 - Create Azure Service Bus Namespace and Queue

## Tasks
1. **Add Azure Service Bus Package:**
   ```bash
   dotnet add package Azure.Messaging.ServiceBus
   ```

2. **Remove MSMQ Dependencies:**
   - Remove System.Messaging references
   - Remove MessageQueue code
   - Remove MSMQ-specific configuration
   - Document removed functionality

3. **Create Service Bus Configuration:**
   - Add configuration section to appsettings.json
   ```json
   {
     "ServiceBus": {
       "ConnectionString": "from-key-vault",
       "QueueName": "notifications"
     }
   }
   ```
   - Create strongly-typed configuration class
   - Register configuration in DI

4. **Update INotificationService Interface:**
   ```csharp
   public interface INotificationService
   {
       Task SendNotificationAsync(string entityType, string action, int entityId, string details);
       Task<List<Notification>> GetRecentNotificationsAsync(int count = 5);
   }
   ```

5. **Implement Send Message Functionality:**
   ```csharp
   public class ServiceBusNotificationService : INotificationService
   {
       private readonly ServiceBusClient _client;
       private readonly ServiceBusSender _sender;
       
       public ServiceBusNotificationService(IOptions<ServiceBusOptions> options)
       {
           _client = new ServiceBusClient(options.Value.ConnectionString);
           _sender = _client.CreateSender(options.Value.QueueName);
       }
       
       public async Task SendNotificationAsync(string entityType, string action, 
           int entityId, string details)
       {
           var notification = new Notification
           {
               EntityType = entityType,
               Action = action,
               EntityId = entityId,
               Details = details,
               Timestamp = DateTime.UtcNow
           };
           
           var message = new ServiceBusMessage(JsonSerializer.Serialize(notification))
           {
               MessageId = Guid.NewGuid().ToString(),
               ContentType = "application/json"
           };
           
           await _sender.SendMessageAsync(message);
       }
   }
   ```

6. **Implement Error Handling:**
   - Add try-catch blocks
   - Log errors appropriately
   - Implement retry logic
   - Don't fail user operations if notification fails
   ```csharp
   try
   {
       await SendNotificationAsync(...);
   }
   catch (Exception ex)
   {
       _logger.LogError(ex, "Failed to send notification");
       // Don't throw - notification is not critical
   }
   ```

7. **Implement Message Receiving:**
   - Create background service or API endpoint
   - Use ServiceBusReceiver to poll for messages
   - Process messages and store in database if needed
   - Complete/abandon messages appropriately
   ```csharp
   var receiver = _client.CreateReceiver(queueName);
   var message = await receiver.ReceiveMessageAsync(timeout);
   if (message != null)
   {
       // Process message
       await receiver.CompleteMessageAsync(message);
   }
   ```

8. **Update Controllers:**
   - Verify controllers use INotificationService
   - Test notification sending from CRUD operations
   - Verify async patterns are used
   - Test error handling

9. **Update NotificationsController:**
   - Update GetRecentNotifications to read from Service Bus or database
   - Implement proper API endpoints
   - Add error handling
   - Test API responses

10. **Register Service in DI:**
    ```csharp
    builder.Services.Configure<ServiceBusOptions>(
        builder.Configuration.GetSection("ServiceBus"));
    builder.Services.AddSingleton<INotificationService, ServiceBusNotificationService>();
    ```

11. **Test Notification Flow:**
    - Create a student, verify notification sent
    - Update a course, verify notification sent
    - Delete an instructor, verify notification sent
    - Verify messages appear in Azure portal
    - Test error scenarios

12. **Cleanup:**
    - Remove all MSMQ code
    - Remove MSMQ configuration
    - Update documentation
    - Remove System.Messaging package

## Deliverables
- [ ] Azure.Messaging.ServiceBus package added
- [ ] System.Messaging references removed
- [ ] ServiceBusNotificationService implemented
- [ ] Send functionality working
- [ ] Receive functionality working
- [ ] Error handling implemented
- [ ] All CRUD operations send notifications
- [ ] Service registered in DI
- [ ] Tests passed
- [ ] MSMQ code removed

## Acceptance Criteria
- Notifications are sent to Azure Service Bus
- Messages can be received and processed
- No System.Messaging references remain
- Error handling works gracefully
- Notifications don't block user operations
- All tests pass
- Code is well-documented
- MSMQ dependencies completely removed

## Estimated Effort
2-3 days

## Notes
- Make notification sending non-blocking (fire and forget with error logging)
- Use async/await throughout
- Consider using IHostedService for background message processing
- Test with Service Bus Explorer during development
- Monitor dead-letter queue for failed messages
- Consider adding message batching for performance
- Document message format and schema
- Plan for future SignalR integration (real-time UI updates)
