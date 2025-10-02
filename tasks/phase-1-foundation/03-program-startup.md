# Task: Create Program.cs and Startup Configuration

## Phase
Phase 1: Foundation - Core Migration (Week 1)

## Description
Create the Program.cs file with proper ASP.NET Core startup configuration, middleware pipeline, and dependency injection setup.

## Objectives
- Create Program.cs with minimal hosting model
- Configure services and dependency injection
- Set up middleware pipeline
- Configure routing and MVC
- Replace Global.asax functionality

## Prerequisites
- .NET 9 project structure created
- Packages migrated to PackageReference
- Understanding of current Global.asax setup

## Dependencies
- Phase 1: Task 01 - Create .NET 9 Project Structure
- Phase 1: Task 02 - Migrate packages.config to PackageReference

## Tasks
1. **Create Program.cs:**
   - Use minimal hosting model (WebApplication.CreateBuilder)
   - Set up web application builder
   - Configure Kestrel settings
   - Set up logging configuration

2. **Configure Services (Dependency Injection):**
   - Add MVC services (AddControllersWithViews)
   - Configure Razor Pages options
   - Add session services if needed
   - Add health checks
   - Add HTTP client factory
   - Prepare for future service registrations

3. **Configure Middleware Pipeline:**
   - Add exception handling middleware
   - Add HTTPS redirection
   - Add static files middleware
   - Add routing middleware
   - Add authentication middleware (placeholder)
   - Add authorization middleware
   - Add session middleware if needed

4. **Configure Routing:**
   - Set up conventional routing
   - Define default route pattern
   - Configure area routes if needed
   - Map controllers

5. **Environment-Specific Configuration:**
   - Configure development exception page
   - Set up error handling for production
   - Configure different behaviors per environment

6. **Replace Global.asax Functionality:**
   - Move application start logic
   - Convert filters to middleware
   - Replace route configuration
   - Convert bundling configuration (if applicable)

7. **Configuration Setup:**
   - Load appsettings.json
   - Load environment-specific settings
   - Set up environment variables
   - Configure options pattern for settings

8. **Logging Configuration:**
   - Set up default logging providers
   - Configure log levels
   - Prepare for Application Insights integration (Phase 3)

## Deliverables
- [ ] Program.cs created with full configuration
- [ ] Services properly registered in DI container
- [ ] Middleware pipeline configured correctly
- [ ] Routing configured with default patterns
- [ ] Environment-specific behavior implemented
- [ ] Global.asax functionality migrated
- [ ] Application starts without errors
- [ ] Configuration is well-documented

## Acceptance Criteria
- Application starts and runs successfully
- Default route works (HomeController/Index)
- Static files are served correctly
- Error pages display appropriately
- Development vs Production behavior differs correctly
- All services are properly registered
- No Global.asax or App_Start files remain
- Code is well-commented and documented

## Estimated Effort
1-2 days

## Notes
- Use minimal hosting model for cleaner code
- Keep middleware order correct (exception handling → static files → routing → auth → MVC)
- Use built-in DI container instead of third-party containers initially
- Consider using IHostBuilder extensions for better organization
- Document service lifetimes (Singleton, Scoped, Transient)
- Test hot reload functionality works properly
- Consider using top-level statements for cleaner Program.cs
- Add comments explaining each middleware's purpose
