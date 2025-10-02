# Task: Convert Web.config to appsettings.json

## Phase
Phase 1: Foundation - Core Migration (Week 1)

## Description
Migrate configuration from Web.config to the modern appsettings.json format and implement the IConfiguration pattern.

## Objectives
- Extract all configuration from Web.config
- Create appsettings.json structure
- Implement environment-specific configuration
- Replace ConfigurationManager with IConfiguration
- Secure sensitive configuration

## Prerequisites
- Program.cs created
- Understanding of current Web.config settings
- Azure Key Vault ready (from Phase 0)

## Dependencies
- Phase 1: Task 03 - Create Program.cs and Startup Configuration
- Phase 0: Task 04 - Create Azure Resources

## Tasks
1. **Analyze Web.config:**
   - Extract all appSettings
   - Extract connection strings
   - Identify authentication settings
   - Document custom configuration sections
   - Note system.web settings

2. **Create appsettings.json:**
   - Create main appsettings.json
   - Structure configuration hierarchically
   - Add connection strings section
   - Add application-specific settings
   - Add logging configuration

3. **Create Environment-Specific Settings:**
   - Create appsettings.Development.json
   - Create appsettings.Production.json (template)
   - Document environment overrides
   - Set up proper file precedence

4. **Migrate Configuration Sections:**
   - Migrate connection strings:
     ```json
     {
       "ConnectionStrings": {
         "DefaultConnection": "Server=..."
       }
     }
     ```
   - Migrate app settings:
     ```json
     {
       "NotificationQueuePath": "...",
       "UploadPath": "..."
     }
     ```

5. **Configure Options Pattern:**
   - Create strongly-typed configuration classes
   - Register options in DI container
   - Implement IOptions<T> pattern
   - Validate configuration on startup

6. **Secure Sensitive Settings:**
   - Identify secrets (connection strings, keys)
   - Document which settings should come from Key Vault
   - Use user secrets for local development
   - Configure Azure Key Vault integration (Phase 2)

7. **Update Code References:**
   - Find all ConfigurationManager.AppSettings references
   - Replace with IConfiguration injection
   - Update connection string retrieval
   - Test all configuration reads

8. **Environment Variables:**
   - Document environment variable overrides
   - Set up local development variables
   - Configure Azure App Service settings (Phase 4)

9. **Remove Web.config:**
   - Remove system.web sections
   - Keep only necessary runtime settings (if any)
   - Document what was removed
   - Verify nothing is broken

## Deliverables
- [ ] appsettings.json created with all configuration
- [ ] appsettings.Development.json created
- [ ] Environment-specific configuration working
- [ ] Strongly-typed configuration classes created
- [ ] IConfiguration used throughout codebase
- [ ] ConfigurationManager references removed
- [ ] User secrets configured for development
- [ ] Configuration documentation updated

## Acceptance Criteria
- All configuration from Web.config is migrated
- Application reads configuration correctly
- Environment-specific overrides work
- No ConfigurationManager references remain
- Configuration is strongly-typed where possible
- Sensitive data is not in appsettings.json
- User secrets work for local development
- Documentation explains configuration structure

## Estimated Effort
1-2 days

## Notes
- Use user secrets (dotnet user-secrets) for local development
- Never commit sensitive data to source control
- Use hierarchical JSON structure for better organization
- Consider using IOptionsSnapshot for hot-reload scenarios
- Validate configuration on startup to fail fast
- Document all configuration options and their defaults
- Use consistent naming conventions (PascalCase recommended)
- Consider creating configuration validation attributes
