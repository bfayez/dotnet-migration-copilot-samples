# Task: Set Up Dependency Injection Container

## Phase
Phase 1: Foundation - Core Migration (Week 1)

## Description
Configure the built-in dependency injection container and register all services, replacing manual instantiation and static factories.

## Objectives
- Configure DI container in Program.cs
- Register DbContext with proper lifetime
- Register services with appropriate lifetimes
- Remove static factory patterns
- Enable constructor injection throughout

## Prerequisites
- Program.cs created
- Configuration system set up
- Understanding of current service instantiation

## Dependencies
- Phase 1: Task 03 - Create Program.cs and Startup Configuration
- Phase 1: Task 04 - Convert Web.config to appsettings.json

## Tasks
1. **Understand Current Service Creation:**
   - Identify all manual instantiations
   - Document BaseController pattern
   - Find all static factory patterns
   - List all services that need registration

2. **Register DbContext:**
   - Add SchoolContext to DI container
   - Configure lifetime (Scoped recommended)
   - Set up connection string from configuration
   - Remove SchoolContextFactory pattern
   ```csharp
   builder.Services.AddDbContext<SchoolContext>(options =>
       options.UseSqlServer(
           builder.Configuration.GetConnectionString("DefaultConnection")
       )
   );
   ```

3. **Register Application Services:**
   - Register NotificationService (Scoped)
   - Register any other business services
   - Prepare for future service registrations
   - Document service lifetimes

4. **Service Lifetime Decisions:**
   - Singleton: Stateless services, shared state
   - Scoped: Per-request services (DbContext, most services)
   - Transient: Lightweight, stateless services
   - Document lifetime choices

5. **Create Service Interfaces:**
   - Create INotificationService interface
   - Create other service interfaces as needed
   - Register interfaces with implementations
   - Enable testability through interfaces

6. **Configure Service Options:**
   - Register configuration options
   - Use IOptions<T> pattern
   - Validate options on startup
   ```csharp
   builder.Services.Configure<NotificationOptions>(
       builder.Configuration.GetSection("Notification")
   );
   ```

7. **HttpClient Configuration:**
   - Register IHttpClientFactory
   - Configure named or typed clients
   - Set up default policies (retry, timeout)

8. **Logging Configuration:**
   - Register logging services
   - Configure log providers
   - Set up structured logging (Serilog prep)

9. **Remove Static Factories:**
   - Remove SchoolContextFactory.Create()
   - Remove other static factory methods
   - Update code to use injected services

10. **Testing Setup:**
    - Verify services are resolvable
    - Test service lifetimes
    - Check for circular dependencies
    - Document DI container configuration

## Deliverables
- [ ] DI container fully configured in Program.cs
- [ ] DbContext registered with proper lifetime
- [ ] All services registered in DI container
- [ ] Service interfaces created
- [ ] Static factories removed
- [ ] Configuration options registered
- [ ] Service lifetimes documented
- [ ] DI configuration tested and verified

## Acceptance Criteria
- All services can be resolved from DI container
- No circular dependency errors
- DbContext is properly scoped to requests
- Services have appropriate lifetimes
- No static factory patterns remain
- Configuration options are properly bound
- Code is ready for constructor injection
- Documentation explains DI decisions

## Estimated Effort
1 day

## Notes
- Use constructor injection exclusively
- Avoid service locator pattern
- Prefer interfaces over concrete types for flexibility
- Be careful with Captive Dependencies (don't inject Scoped into Singleton)
- Use IServiceScope for creating scopes manually when needed
- Consider using Scrutor for assembly scanning if many services
- Test DI configuration in integration tests
- Document any complex service registrations
- Use extension methods to organize service registrations
