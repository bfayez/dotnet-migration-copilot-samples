# Task: Application Inventory and Dependency Analysis

## Phase
Phase 0: Assessment and Planning (Week 1, Day 1-2)

## Description
Complete a thorough inventory of the ContosoUniversity application and analyze all dependencies to understand the scope of the migration.

## Objectives
- Document all application components and their interactions
- Identify all external dependencies (NuGet packages, system dependencies)
- Analyze Windows-specific dependencies that need replacement
- Create a comprehensive dependency map
- Identify potential migration blockers

## Prerequisites
- Access to the ContosoUniversity source code
- Access to the current hosting environment
- Documentation review (README files)

## Dependencies
None (This is the starting task)

## Tasks
1. **Application Components Inventory:**
   - List all controllers and their responsibilities
   - Document all models and their relationships
   - Catalog all views and partial views
   - Identify all services and business logic components
   - Document data access patterns

2. **Dependency Analysis:**
   - Extract all NuGet package dependencies from packages.config
   - Identify .NET Framework-specific dependencies
   - Document Windows-specific dependencies (MSMQ, IIS features)
   - Analyze third-party library compatibility with .NET 9
   - Check for deprecated APIs and breaking changes

3. **Infrastructure Dependencies:**
   - Document current hosting requirements (IIS, Windows Server)
   - Identify authentication mechanisms (Windows Authentication)
   - Document file system dependencies (upload directories)
   - Analyze message queue implementation (MSMQ)
   - Document database schema and migrations

4. **Create Dependency Map:**
   - Create visual diagram showing component relationships
   - Document data flow between components
   - Identify critical paths and workflows
   - Document integration points

## Deliverables
- [ ] Application components inventory document
- [ ] Complete dependency list (NuGet, system, external)
- [ ] Windows-specific dependencies report
- [ ] Compatibility assessment for .NET 9
- [ ] Dependency diagram/map
- [ ] Risk assessment for identified dependencies

## Acceptance Criteria
- All controllers, models, views, and services documented
- All NuGet packages cataloged with versions
- All Windows-specific dependencies identified
- Compatibility issues documented with mitigation strategies
- Dependency map created and reviewed
- No missing components or dependencies

## Estimated Effort
2 days

## Notes
- Use tools like NDepend or Visual Studio dependency graphs if available
- Document both direct and transitive dependencies
- Pay special attention to System.Web, System.Messaging, and other framework-specific namespaces
- This inventory will inform all subsequent migration tasks
