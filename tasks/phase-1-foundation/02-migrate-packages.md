# Task: Migrate packages.config to PackageReference

## Phase
Phase 1: Foundation - Core Migration (Week 1)

## Description
Convert the legacy packages.config format to modern PackageReference format and update all packages to .NET 9 compatible versions.

## Objectives
- Remove packages.config
- Migrate to PackageReference format
- Update packages to .NET 9 compatible versions
- Resolve package conflicts and dependencies
- Clean up transitive dependencies

## Prerequisites
- .NET 9 project structure created
- Access to NuGet package manager
- List of current packages from inventory

## Dependencies
- Phase 1: Task 01 - Create .NET 9 Project Structure

## Tasks
1. **Inventory Current Packages:**
   - Extract all packages from packages.config
   - Document current versions
   - Identify framework-specific packages
   - Check compatibility with .NET 9

2. **Remove Legacy Packages:**
   - Identify packages that are no longer needed
   - Remove System.Web dependencies
   - Remove .NET Framework-specific packages
   - Document removed packages and reasons

3. **Add Core ASP.NET Core Packages:**
   - Microsoft.AspNetCore.App (SDK reference)
   - Microsoft.EntityFrameworkCore (9.0.x)
   - Microsoft.EntityFrameworkCore.SqlServer (9.0.x)
   - Microsoft.EntityFrameworkCore.Tools (9.0.x)

4. **Add Replacement Packages:**
   - Replace System.Messaging → Azure.Messaging.ServiceBus (future)
   - Replace System.Web.Http → Microsoft.AspNetCore.Mvc
   - Replace bundle/minification packages → WebOptimizer (if needed)
   - Document all replacements

5. **Add Supporting Packages:**
   - Microsoft.Extensions.Configuration.Json
   - Microsoft.Extensions.Logging
   - Microsoft.Extensions.DependencyInjection
   - Serilog packages (for structured logging)

6. **Update UI Packages:**
   - Verify Bootstrap version compatibility
   - Update jQuery if needed
   - Document client-side library management strategy

7. **Resolve Conflicts:**
   - Resolve version conflicts
   - Handle transitive dependency issues
   - Test package compatibility
   - Document any workarounds

8. **Clean Up:**
   - Delete packages.config
   - Delete packages directory
   - Remove legacy references from .csproj
   - Verify all references are PackageReference

9. **Verify:**
   - Restore packages successfully
   - Build project
   - Check for warnings
   - Document final package list

## Deliverables
- [ ] packages.config removed
- [ ] All packages converted to PackageReference
- [ ] All packages updated to .NET 9 compatible versions
- [ ] Package conflicts resolved
- [ ] Project builds successfully
- [ ] Package list documented
- [ ] Migration notes for package changes

## Acceptance Criteria
- No packages.config file exists
- All package references use PackageReference format
- All packages are .NET 9 compatible
- No package version conflicts
- Project restores and builds without errors
- No legacy framework packages remain
- Documentation explains all major package changes

## Estimated Effort
1-2 days

## Notes
- Use Visual Studio's built-in migration tool if available
- Check for breaking changes in major version updates
- Some packages may not have .NET 9 versions yet - document alternatives
- Keep track of packages that need custom replacement logic
- Test that all functionality still works after package migration
- Consider using central package management (Directory.Packages.props)
- Document any packages that require code changes
