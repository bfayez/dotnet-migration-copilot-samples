# Task: Update DbContext for Dependency Injection and Remove Static Factory

## Phase
Phase 1: Foundation - Core Migration (Week 4)

## Description
Remove the SchoolContextFactory static factory pattern and update DbContext to use dependency injection properly.

## Objectives
- Remove SchoolContextFactory class
- Register DbContext in DI container
- Update all DbContext usage to use injected instances
- Implement proper DbContext lifetime management
- Test connection pooling and performance

## Prerequisites
- EF Core updated to version 9
- Dependency injection container configured
- Understanding of DbContext lifetime management

## Dependencies
- Phase 1: Task 10 - Update Entity Framework Core to Version 9

## Tasks
1. **Analyze Current Factory Usage:**
   - Find all SchoolContextFactory.Create() calls
   - Document where DbContext is created
   - Identify patterns of usage
   - Note disposal patterns

2. **Remove SchoolContextFactory:**
   - Delete SchoolContextFactory class
   - Remove design-time factory if not needed
   - Document removal

3. **Register DbContext in DI:**
   - Already done in Task 05, verify configuration
   ```csharp
   builder.Services.AddDbContext<SchoolContext>(options =>
       options.UseSqlServer(
           builder.Configuration.GetConnectionString("DefaultConnection"),
           sqlOptions => sqlOptions.EnableRetryOnFailure()
       )
   );
   ```

4. **Configure DbContext Options:**
   - Enable sensitive data logging for development
   - Configure query tracking behavior
   - Set command timeout if needed
   - Configure connection resiliency
   ```csharp
   options.UseSqlServer(connectionString, sqlOptions =>
   {
       sqlOptions.EnableRetryOnFailure(
           maxRetryCount: 5,
           maxRetryDelay: TimeSpan.FromSeconds(30),
           errorNumbersToAdd: null);
   });
   ```

5. **Update Controllers:**
   - Remove manual DbContext instantiation
   - Use injected DbContext from constructor
   - Verify DbContext is disposed properly (automatic with DI)
   - Test each controller

6. **Update Services:**
   - Inject DbContext into NotificationService
   - Update any other services using DbContext
   - Ensure proper lifetime scopes

7. **Test DbContext Lifetime:**
   - Verify DbContext is scoped per request
   - Test concurrent requests
   - Verify no connection leaks
   - Check connection pooling is working

8. **Test Database Operations:**
   - Test CRUD operations
   - Test concurrent database access
   - Verify transactions work correctly
   - Test error handling and retries

9. **Performance Testing:**
   - Compare connection pooling performance
   - Verify no connection exhaustion
   - Test under load
   - Monitor database connections

## Deliverables
- [ ] SchoolContextFactory removed
- [ ] DbContext registered in DI container
- [ ] All controllers use injected DbContext
- [ ] All services use injected DbContext
- [ ] DbContext lifetime is scoped
- [ ] Connection resiliency configured
- [ ] All database operations tested
- [ ] Performance verified

## Acceptance Criteria
- No SchoolContextFactory class exists
- All DbContext usage is through dependency injection
- DbContext is properly scoped (per request)
- No connection leaks detected
- Connection pooling works correctly
- Retry logic functions properly
- All CRUD operations work
- Performance is acceptable

## Estimated Effort
1 day

## Notes
- DbContext should be scoped, not singleton
- DI container handles DbContext disposal automatically
- Enable retry on failure for production resilience
- Use connection pooling for better performance
- Monitor connection count in SQL Server
- Test with realistic concurrent load
- Document DbContext configuration decisions
- Consider using IDbContextFactory<T> for background services if needed
