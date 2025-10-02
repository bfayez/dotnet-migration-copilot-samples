# Task: Update Connection String and Test Connectivity

## Phase
Phase 2: Azure Services Integration (Week 1)

## Description
Update the application to use Azure SQL Database connection string and implement robust connection handling with retry logic.

## Objectives
- Configure Azure SQL connection string
- Implement connection resiliency
- Test connection under various scenarios
- Configure connection pooling
- Handle connection failures gracefully

## Prerequisites
- Azure SQL Database configured and migrations applied
- Application code updated to .NET 9
- Understanding of connection resiliency patterns

## Dependencies
- Phase 2: Task 03 - Run Database Migrations on Azure SQL

## Tasks
1. **Update Connection String Configuration:**
   - Add Azure SQL connection string to appsettings.Development.json
   - Use user secrets for local development
   - Document connection string format
   - Verify Encrypt=True for security

2. **Configure Connection Resiliency:**
   - Already configured in DbContext registration, verify:
   ```csharp
   builder.Services.AddDbContext<SchoolContext>(options =>
       options.UseSqlServer(
           builder.Configuration.GetConnectionString("DefaultConnection"),
           sqlOptions => 
           {
               sqlOptions.EnableRetryOnFailure(
                   maxRetryCount: 5,
                   maxRetryDelay: TimeSpan.FromSeconds(30),
                   errorNumbersToAdd: null);
               sqlOptions.CommandTimeout(30);
           }
       )
   );
   ```

3. **Configure Connection Pooling:**
   - Verify connection string has pooling enabled (default)
   - Set Min Pool Size if needed
   - Set Max Pool Size appropriately
   - Document pooling settings

4. **Test Basic Connectivity:**
   - Start application
   - Verify connection succeeds
   - Test database operations
   - Check application logs for errors

5. **Test Connection Resiliency:**
   - Simulate transient failures
   - Verify retry logic works
   - Test timeout scenarios
   - Verify error handling

6. **Test Connection Pooling:**
   - Test concurrent requests
   - Monitor connection count in Azure
   - Verify connections are reused
   - Check for connection leaks

7. **Test Firewall Scenarios:**
   - Test from different networks
   - Verify firewall rules work
   - Test VPN connectivity if applicable
   - Document any connectivity issues

8. **Implement Health Checks:**
   - Add health check for database connectivity
   ```csharp
   builder.Services.AddHealthChecks()
       .AddDbContextCheck<SchoolContext>();
   
   app.MapHealthChecks("/health");
   ```
   - Test health check endpoint
   - Verify health check fails when database is down

9. **Configure Error Handling:**
   - Handle connection failures gracefully
   - Show user-friendly error messages
   - Log connection errors
   - Implement circuit breaker if needed

10. **Update Development Workflow:**
    - Document how to switch between LocalDB and Azure SQL
    - Update README with connection setup
    - Create troubleshooting guide
    - Document firewall configuration steps

11. **Performance Testing:**
    - Compare latency with LocalDB
    - Test query performance
    - Monitor DTU usage
    - Identify any bottlenecks

12. **Security Review:**
    - Verify connection string is not in source control
    - Verify encryption is enabled (Encrypt=True)
    - Check certificate validation
    - Review authentication method

## Deliverables
- [ ] Azure SQL connection string configured
- [ ] Connection resiliency implemented
- [ ] Connection pooling configured
- [ ] Health checks implemented
- [ ] Connectivity tested from all environments
- [ ] Error handling implemented
- [ ] Performance benchmarks documented
- [ ] Troubleshooting guide created

## Acceptance Criteria
- Application connects to Azure SQL successfully
- Retry logic handles transient failures
- Connection pooling works correctly
- Health check endpoint responds correctly
- No connection leaks detected
- Error messages are user-friendly
- Performance is acceptable
- Documentation is complete

## Estimated Effort
1 day

## Notes
- Use Encrypt=True in connection string for security
- Enable retry logic for production resilience
- Monitor connection count in Azure portal
- Set appropriate timeout values (not too high)
- Test from different network locations
- Keep LocalDB setup for offline development
- Use Azure AD authentication for production (later task)
- Document any network-specific issues
- Consider using connection string builder for clarity
