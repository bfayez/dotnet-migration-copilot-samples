# Task: Create .NET 9 Project Structure

## Phase
Phase 1: Foundation - Core Migration (Week 1)

## Description
Create a new .NET 9 SDK-style project structure to replace the existing .NET Framework 4.8 project.

## Objectives
- Create new .NET 9 solution and project structure
- Set up SDK-style project files
- Establish proper solution organization
- Configure project settings for ASP.NET Core

## Prerequisites
- .NET 9 SDK installed
- Phase 0 completed (development environment ready)
- Application inventory available

## Dependencies
- Phase 0: Task 06 - Sprint Planning for Phase 1

## Tasks
1. **Create Solution Structure:**
   - Create new solution file (.sln)
   - Create main web project (ContosoUniversity.Web)
   - Create test project structure (ContosoUniversity.Tests)
   - Organize projects in solution folders if needed

2. **Create SDK-Style Project:**
   - Create new .csproj with SDK-style format
   - Set TargetFramework to net9.0
   - Configure project properties (nullable, implicit usings)
   - Set up output paths and configuration

3. **Project Configuration:**
   - Configure ASP.NET Core project settings
   - Set up Razor view compilation
   - Configure static files directory (wwwroot)
   - Set up launch settings for development

4. **Initial Dependencies:**
   - Add core ASP.NET Core MVC packages
   - Add Entity Framework Core 9 packages
   - Add logging and configuration packages
   - Document package versions

5. **Directory Structure:**
   - Create Controllers directory
   - Create Models directory
   - Create Views directory
   - Create Data directory
   - Create Services directory
   - Create wwwroot directory (for static files)

6. **Configuration Files:**
   - Create Program.cs with minimal setup
   - Create appsettings.json structure
   - Create appsettings.Development.json
   - Set up launchSettings.json

7. **Verify Build:**
   - Build new project
   - Run project to verify it starts
   - Test hot reload functionality
   - Document any initial issues

## Deliverables
- [ ] New .NET 9 solution created
- [ ] SDK-style project file created
- [ ] Directory structure established
- [ ] Core NuGet packages added
- [ ] Program.cs with minimal setup
- [ ] appsettings.json configured
- [ ] Project builds successfully
- [ ] Project runs without errors

## Acceptance Criteria
- Solution opens in Visual Studio/VS Code without errors
- Project file is SDK-style format
- TargetFramework is net9.0
- Project builds with zero errors
- Application starts and shows default page
- All directories follow ASP.NET Core conventions
- Configuration files are properly formatted

## Estimated Effort
1-2 days

## Notes
- Keep old project intact for reference during migration
- Use SDK-style project format exclusively (not hybrid)
- Consider enabling nullable reference types from the start
- Document all project settings and their purposes
- Create a README in the new project with setup instructions
- Consider using global.json to lock .NET SDK version
- Test on multiple developer machines to ensure consistency
