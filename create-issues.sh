#!/bin/bash
# Script to create GitHub issues for ContosoUniversity migration tasks
# Generated automatically from task markdown files
#
# Usage:
#   1. Ensure you're authenticated with GitHub CLI: gh auth login
#   2. Run this script: ./create-issues.sh
#
# Total issues to create: 47

set -e  # Exit on error

echo "Creating 47 GitHub issues for ContosoUniversity migration..."
echo ""

# Issue 1: Application Inventory and Dependency Analysis
# File: tasks/phase-0-assessment-planning/01-application-inventory.md
# Phase: phase-0-assessment-planning
cat > /tmp/issue-body-1.md << 'EOF'
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

EOF

gh issue create \
  --title "Application Inventory and Dependency Analysis" \
  --body-file /tmp/issue-body-1.md \
  --label "phase-0,setup,critical,1-week"


# Issue 2: Set Up Azure Subscription and Resource Groups
# File: tasks/phase-0-assessment-planning/02-azure-setup.md
# Phase: phase-0-assessment-planning
cat > /tmp/issue-body-2.md << 'EOF'
# Task: Set Up Azure Subscription and Resource Groups

## Phase
Phase 0: Assessment and Planning (Week 1, Day 3-4)

## Description
Set up the Azure subscription, resource groups, and initial configuration for the migration project.

## Objectives
- Create or configure Azure subscription
- Establish resource group structure
- Set up naming conventions and tagging strategy
- Configure access control and permissions
- Establish cost management and monitoring

## Prerequisites
- Azure account with appropriate permissions
- Approved budget for Azure resources
- Project team identified

## Dependencies
- Task 01: Application Inventory and Dependency Analysis (to understand resource requirements)

## Tasks
1. **Azure Subscription Setup:**
   - Create or configure Azure subscription
   - Set up billing alerts and budget limits
   - Configure cost management policies
   - Document subscription details

2. **Resource Group Structure:**
   - Create resource group for Development environment
   - Create resource group for Production environment (optional at this stage)
   - Apply naming conventions (e.g., rg-contoso-university-dev, rg-contoso-university-prod)
   - Set up resource group tags (Environment, Project, Owner, CostCenter)

3. **Access Control:**
   - Configure Azure AD/Entra ID access
   - Set up RBAC roles for team members
   - Create service principals for CI/CD
   - Document access control policies

4. **Network Configuration:**
   - Plan virtual network topology (if needed)
   - Configure network security groups
   - Plan private endpoints strategy
   - Document network architecture

5. **Governance Setup:**
   - Apply Azure policies for compliance
   - Set up management locks for production resources
   - Configure activity logging
   - Set up Azure Monitor for resource tracking

## Deliverables
- [ ] Azure subscription configured and accessible
- [ ] Resource groups created (dev and prod)
- [ ] Naming conventions and tagging strategy documented
- [ ] RBAC roles assigned to team members
- [ ] Service principals created for automation
- [ ] Cost alerts configured
- [ ] Governance policies applied
- [ ] Network topology documented

## Acceptance Criteria
- All team members can access Azure subscription with appropriate permissions
- Resource groups created with proper naming and tags
- Cost alerts trigger at defined thresholds
- Service principals can authenticate and access resources
- Governance policies enforce compliance requirements
- Documentation complete and accessible to team

## Estimated Effort
2 days

## Notes
- Follow Azure naming conventions: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging
- Consider using Azure landing zones for enterprise deployments
- Set up separate resource groups for shared resources (networking, monitoring)
- Use least-privilege principle for RBAC assignments
- Document all credentials securely (use Azure Key Vault or password manager)

EOF

gh issue create \
  --title "Set Up Azure Subscription and Resource Groups" \
  --body-file /tmp/issue-body-2.md \
  --label "phase-0,azure,critical,1-week"


# Issue 3: Team Kickoff, Tools Setup, and Access Provisioning
# File: tasks/phase-0-assessment-planning/03-team-setup.md
# Phase: phase-0-assessment-planning
cat > /tmp/issue-body-3.md << 'EOF'
# Task: Team Kickoff, Tools Setup, and Access Provisioning

## Phase
Phase 0: Assessment and Planning (Week 1, Day 5)

## Description
Conduct team kickoff meeting, set up development tools, and provision access to all required systems.

## Objectives
- Align team on migration goals and timeline
- Set up development environments
- Provision access to all necessary tools and services
- Establish communication channels and processes
- Configure development tools and SDKs

## Prerequisites
- Azure subscription and resource groups configured
- Project team assigned
- Migration plan approved

## Dependencies
- Task 02: Set Up Azure Subscription and Resource Groups

## Tasks
1. **Team Kickoff Meeting:**
   - Present migration plan and timeline
   - Assign roles and responsibilities
   - Review success criteria and deliverables
   - Discuss communication protocols
   - Address team questions and concerns
   - Schedule regular standup/sync meetings

2. **Development Environment Setup:**
   - Install .NET 9 SDK
   - Install Visual Studio 2022 or VS Code
   - Install Docker Desktop
   - Install Azure CLI
   - Install Git and configure SSH keys
   - Install SQL Server Management Studio or Azure Data Studio

3. **Access Provisioning:**
   - Provide GitHub repository access to all team members
   - Grant Azure portal access with appropriate RBAC roles
   - Provide access to Azure DevOps or GitHub Actions
   - Set up access to development database
   - Configure VPN access if required

4. **Tool Configuration:**
   - Configure Visual Studio with Azure extensions
   - Set up Azure Storage Explorer
   - Install Service Bus Explorer
   - Configure Application Insights extension
   - Set up code analysis tools (SonarLint, Roslyn analyzers)

5. **Communication Channels:**
   - Set up team chat channel (Teams, Slack)
   - Create shared documentation location (SharePoint, Confluence)
   - Set up project tracking (Azure Boards, GitHub Projects, Jira)
   - Configure notification preferences
   - Document escalation procedures

6. **Standards and Guidelines:**
   - Review coding standards
   - Review Git workflow and branching strategy
   - Review pull request process
   - Review testing requirements
   - Document development workflow

## Deliverables
- [ ] Team kickoff meeting completed with documented outcomes
- [ ] All team members have development environments configured
- [ ] .NET 9 SDK installed and verified on all dev machines
- [ ] Azure CLI configured with subscription access
- [ ] GitHub repository cloned and accessible
- [ ] Azure portal access verified for all team members
- [ ] Communication channels established
- [ ] Project tracking tool configured
- [ ] Development workflow documented

## Acceptance Criteria
- All team members can build and run the current application
- All team members can access Azure resources
- All team members can push code to repository
- Communication channels are active and tested
- Project tracking tool has initial backlog imported
- Development standards documented and accessible
- All required tools installed and configured

## Estimated Effort
1 day

## Notes
- Provide a setup checklist for each team member
- Consider pairing new team members with experienced developers
- Document all tool versions for consistency
- Create troubleshooting guide for common setup issues
- Schedule follow-up sessions for tool training if needed
- Ensure all team members have Azure free credits or appropriate subscription access

EOF

gh issue create \
  --title "Team Kickoff, Tools Setup, and Access Provisioning" \
  --body-file /tmp/issue-body-3.md \
  --label "phase-0,setup,critical,1-2-days"


# Issue 4: Create Azure Resources (SQL Database, Service Bus, Storage)
# File: tasks/phase-0-assessment-planning/04-create-azure-resources.md
# Phase: phase-0-assessment-planning
cat > /tmp/issue-body-4.md << 'EOF'
# Task: Create Azure Resources (SQL Database, Service Bus, Storage)

## Phase
Phase 0: Assessment and Planning (Week 2, Day 1-2)

## Description
Provision all required Azure services for the development environment including SQL Database, Service Bus, and Blob Storage.

## Objectives
- Create Azure SQL Database for development
- Set up Azure Service Bus namespace and queue
- Configure Azure Blob Storage account
- Establish connectivity and access
- Document connection strings and configuration

## Prerequisites
- Azure subscription and resource groups configured
- Development environment setup complete
- Application inventory completed (to size resources appropriately)

## Dependencies
- Task 02: Set Up Azure Subscription and Resource Groups
- Task 03: Team Kickoff, Tools Setup, and Access Provisioning

## Tasks
1. **Azure SQL Database Setup:**
   - Create Azure SQL Database server
   - Configure server firewall rules (allow Azure services, dev IPs)
   - Create database with Serverless tier (1 vCore, auto-pause enabled)
   - Configure geo-redundancy (locally redundant storage for dev)
   - Create admin credentials and store in Key Vault
   - Test connectivity from development machines
   - Document connection string format

2. **Azure Service Bus Setup:**
   - Create Service Bus namespace (Standard tier)
   - Create queue for notifications
   - Configure queue properties (TTL, dead-letter queue, duplicate detection)
   - Set up access policies (send and receive permissions)
   - Create connection strings for sending and receiving
   - Test sending and receiving messages
   - Document Service Bus configuration

3. **Azure Blob Storage Setup:**
   - Create Storage Account (Standard tier, locally redundant)
   - Create blob container for teaching materials
   - Configure container access level (private)
   - Set up CORS rules if needed
   - Generate SAS token for development access
   - Test file upload and download
   - Document storage configuration

4. **Azure Key Vault Setup:**
   - Create Key Vault instance
   - Store SQL Database connection string
   - Store Service Bus connection strings
   - Store Storage Account connection string
   - Configure access policies for development team
   - Test secret retrieval
   - Document Key Vault usage

5. **Network Security:**
   - Configure firewall rules for SQL Database
   - Set up private endpoints if required
   - Configure network security groups
   - Document security configuration

6. **Monitoring Setup:**
   - Enable diagnostic logs for all resources
   - Configure log retention policies
   - Set up basic alerts (connection failures, resource usage)
   - Verify metrics are being collected

## Deliverables
- [ ] Azure SQL Database created and accessible
- [ ] Azure Service Bus namespace and queue created
- [ ] Azure Blob Storage account and container created
- [ ] Azure Key Vault created with all secrets stored
- [ ] Firewall rules configured for development access
- [ ] Connection strings documented in Key Vault
- [ ] All resources tagged appropriately
- [ ] Diagnostic logging enabled
- [ ] Basic alerts configured
- [ ] Resource configuration documented

## Acceptance Criteria
- SQL Database accessible from development machines
- Can send and receive messages to Service Bus queue
- Can upload and download files from Blob Storage
- All connection strings secured in Key Vault
- Team members can access resources with appropriate permissions
- Diagnostic logs are being collected
- Alerts trigger appropriately for test scenarios
- All resources follow naming conventions

## Estimated Effort
2 days

## Notes
- Use Azure CLI or Azure PowerShell for repeatable resource creation
- Consider creating ARM templates or Bicep files for infrastructure as code
- Keep resource costs minimal for development (use smallest tiers)
- Document resource sizing decisions for later production scaling
- Test connectivity from different network locations
- Ensure SQL Database auto-pause is enabled to reduce costs
- Consider using managed identities instead of connection strings where possible
- Keep a backup of all configuration settings

EOF

gh issue create \
  --title "Create Azure Resources (SQL Database, Service Bus, Storage)" \
  --body-file /tmp/issue-body-4.md \
  --label "phase-0,azure,critical,1-week"


# Issue 5: Set Up GitHub Repository, Branching Strategy, CI/CD Skeleton
# File: tasks/phase-0-assessment-planning/05-github-cicd-setup.md
# Phase: phase-0-assessment-planning
cat > /tmp/issue-body-5.md << 'EOF'
# Task: Set Up GitHub Repository, Branching Strategy, CI/CD Skeleton

## Phase
Phase 0: Assessment and Planning (Week 2, Day 3-4)

## Description
Configure GitHub repository structure, establish branching strategy, and create a skeleton CI/CD pipeline using GitHub Actions.

## Objectives
- Establish Git branching strategy
- Configure repository settings and protection rules
- Create initial CI/CD workflows
- Set up automated build and test pipeline
- Document Git workflow for the team

## Prerequisites
- GitHub repository created
- Team members have repository access
- Azure resources created (for deployment targets)
- Development environment setup complete

## Dependencies
- Task 03: Team Kickoff, Tools Setup, and Access Provisioning
- Task 04: Create Azure Resources

## Tasks
1. **Repository Structure:**
   - Review current repository structure
   - Create .github directory structure
   - Set up issue templates
   - Create pull request template
   - Add CODEOWNERS file
   - Configure .gitignore for .NET 9 projects

2. **Branching Strategy:**
   - Define branching model (e.g., GitFlow, GitHub Flow)
   - Create main/develop branch structure
   - Document branch naming conventions (feature/, bugfix/, release/)
   - Establish merge strategy (squash, rebase, merge commit)
   - Document workflow in CONTRIBUTING.md

3. **Branch Protection Rules:**
   - Enable branch protection for main branch
   - Require pull request reviews (minimum 1 reviewer)
   - Require status checks to pass before merging
   - Enable "Require branches to be up to date"
   - Prevent direct pushes to main
   - Configure administrator enforcement

4. **CI/CD Pipeline - Build Workflow:**
   - Create .github/workflows/build.yml
   - Configure triggers (push, pull request)
   - Set up .NET 9 SDK installation
   - Add restore, build, and test steps
   - Configure code coverage reporting
   - Add build artifact publishing

5. **CI/CD Pipeline - PR Validation:**
   - Create .github/workflows/pr-validation.yml
   - Add code quality checks (linting)
   - Run unit and integration tests
   - Check for security vulnerabilities
   - Verify code formatting
   - Add automated PR comments with results

6. **CI/CD Pipeline - Deploy Skeleton:**
   - Create .github/workflows/deploy.yml (skeleton)
   - Define deployment stages (dev, prod)
   - Set up Azure credentials (Service Principal)
   - Add manual approval gates for production
   - Document deployment process
   - Note: Full deployment steps will be implemented in Phase 4

7. **GitHub Actions Secrets:**
   - Add Azure credentials as repository secrets
   - Store connection strings for testing
   - Configure environment-specific secrets
   - Document secret management process

8. **Quality Gates:**
   - Configure status checks required for merging
   - Set up automated dependency updates (Dependabot)
   - Enable security alerts
   - Configure code scanning (CodeQL)

## Deliverables
- [ ] Branching strategy documented and implemented
- [ ] Branch protection rules configured
- [ ] Build workflow (.github/workflows/build.yml) created and tested
- [ ] PR validation workflow created and tested
- [ ] Deploy workflow skeleton created
- [ ] Repository secrets configured
- [ ] Issue and PR templates created
- [ ] CODEOWNERS file configured
- [ ] Dependabot configured
- [ ] CodeQL scanning enabled
- [ ] Git workflow documentation (CONTRIBUTING.md)

## Acceptance Criteria
- Build workflow runs successfully on push and PR
- All tests pass in CI pipeline
- Branch protection prevents direct pushes to main
- PRs require review before merging
- Code coverage reports are generated
- Deployment workflow structure is in place (even if not fully functional)
- All team members understand the Git workflow
- Documentation is clear and accessible

## Estimated Effort
2 days

## Notes
- Use GitHub Actions marketplace for pre-built actions
- Consider using composite actions for reusable steps
- Set up notifications for build failures
- Document how to run workflows locally (using act)
- Create sample PR to test all checks
- Ensure CI pipeline runs reasonably fast (< 10 minutes)
- Consider matrix builds for different configurations
- Document troubleshooting steps for common CI issues

EOF

gh issue create \
  --title "Set Up GitHub Repository, Branching Strategy, CI/CD Skeleton" \
  --body-file /tmp/issue-body-5.md \
  --label "phase-0,deployment,critical,1-week"


# Issue 6: Sprint Planning for Phase 1
# File: tasks/phase-0-assessment-planning/06-sprint-planning.md
# Phase: phase-0-assessment-planning
cat > /tmp/issue-body-6.md << 'EOF'
# Task: Sprint Planning for Phase 1

## Phase
Phase 0: Assessment and Planning (Week 2, Day 5)

## Description
Conduct sprint planning session to detail Phase 1 tasks, estimate effort, and create the initial sprint backlog.

## Objectives
- Break down Phase 1 into detailed tasks
- Estimate effort for each task
- Identify dependencies and critical path
- Create sprint backlog
- Assign initial responsibilities
- Establish sprint cadence and ceremonies

## Prerequisites
- Phase 0 tasks completed
- Team fully onboarded and trained
- Migration plan reviewed and understood
- Azure resources available for development

## Dependencies
- Task 01: Application Inventory and Dependency Analysis
- Task 02: Set Up Azure Subscription and Resource Groups
- Task 03: Team Kickoff, Tools Setup, and Access Provisioning
- Task 04: Create Azure Resources
- Task 05: Set Up GitHub Repository, Branching Strategy, CI/CD Skeleton

## Tasks
1. **Review Phase 1 Objectives:**
   - Review Phase 1 goals from migration plan
   - Clarify scope and boundaries
   - Identify potential risks
   - Review success criteria

2. **Task Breakdown:**
   - Break down Week 1 (Project Structure) into detailed tasks
   - Break down Week 2 (Controllers and Views) into detailed tasks
   - Break down Week 3 (Views and Static Files) into detailed tasks
   - Break down Week 4 (Data Layer) into detailed tasks
   - Identify atomic, testable tasks
   - Create task cards in project tracking tool

3. **Estimation:**
   - Use planning poker or similar technique for estimation
   - Estimate each task in story points or hours
   - Identify complex tasks that need further breakdown
   - Account for learning curve with new technologies
   - Add buffer for unknowns (20%)

4. **Dependency Mapping:**
   - Create task dependency graph
   - Identify critical path tasks
   - Highlight blockers and risks
   - Determine which tasks can run in parallel
   - Plan for incremental testing

5. **Sprint Organization:**
   - Define sprint duration (recommended: 2 weeks)
   - Create Sprint 1 and Sprint 2 backlogs
   - Assign tasks to team members based on expertise
   - Balance workload across team
   - Identify sprint goals

6. **Definition of Done:**
   - Define what "done" means for each task
   - Establish code review requirements
   - Define testing requirements
   - Establish documentation requirements
   - Document acceptance criteria

7. **Risk Identification:**
   - Identify technical risks for Phase 1
   - Plan mitigation strategies
   - Assign risk owners
   - Define escalation procedures

8. **Sprint Ceremonies:**
   - Schedule daily standups
   - Schedule sprint review/demo
   - Schedule sprint retrospective
   - Schedule mid-sprint check-in
   - Document ceremony formats and expectations

## Deliverables
- [ ] Detailed Phase 1 task breakdown in project tracking tool
- [ ] Effort estimates for all Phase 1 tasks
- [ ] Task dependency graph/diagram
- [ ] Sprint 1 backlog prioritized and assigned
- [ ] Sprint 2 backlog prioritized
- [ ] Definition of Done documented
- [ ] Risk register for Phase 1
- [ ] Sprint ceremony schedule
- [ ] Sprint 1 goal statement
- [ ] Team capacity planning document

## Acceptance Criteria
- All Phase 1 tasks from migration plan are represented in backlog
- Each task has acceptance criteria defined
- Estimates are reasonable and agreed upon by team
- Dependencies are clearly identified and documented
- Sprint backlog is achievable within sprint duration
- All team members understand their assignments
- Definition of Done is clear and measurable
- Risk mitigation strategies are in place

## Estimated Effort
1 day

## Notes
- Use collaborative estimation techniques (planning poker)
- Consider team velocity if known from previous projects
- Keep sprint backlog flexible to accommodate learnings
- Don't over-commit in first sprint while team is ramping up
- Schedule regular backlog refinement sessions
- Use burndown charts to track progress
- Document assumptions made during planning
- Plan for knowledge sharing and pair programming
- Consider dedicating time for learning .NET 9 features
- Keep first sprint slightly lighter to account for setup overhead

EOF

gh issue create \
  --title "Sprint Planning for Phase 1" \
  --body-file /tmp/issue-body-6.md \
  --label "phase-0,setup,critical,1-2-days"


# Issue 7: Create .NET 9 Project Structure
# File: tasks/phase-1-foundation/01-create-dotnet9-project.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-7.md << 'EOF'
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

EOF

gh issue create \
  --title "Create .NET 9 Project Structure" \
  --body-file /tmp/issue-body-7.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 8: Migrate packages.config to PackageReference
# File: tasks/phase-1-foundation/02-migrate-packages.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-8.md << 'EOF'
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

EOF

gh issue create \
  --title "Migrate packages.config to PackageReference" \
  --body-file /tmp/issue-body-8.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 9: Create Program.cs and Startup Configuration
# File: tasks/phase-1-foundation/03-program-startup.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-9.md << 'EOF'
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

EOF

gh issue create \
  --title "Create Program.cs and Startup Configuration" \
  --body-file /tmp/issue-body-9.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 10: Convert Web.config to appsettings.json
# File: tasks/phase-1-foundation/04-config-migration.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-10.md << 'EOF'
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

EOF

gh issue create \
  --title "Convert Web.config to appsettings.json" \
  --body-file /tmp/issue-body-10.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 11: Set Up Dependency Injection Container
# File: tasks/phase-1-foundation/05-dependency-injection.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-11.md << 'EOF'
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

EOF

gh issue create \
  --title "Set Up Dependency Injection Container" \
  --body-file /tmp/issue-body-11.md \
  --label "phase-1,deployment,high,1-2-days"


# Issue 12: Migrate Controllers to ASP.NET Core MVC
# File: tasks/phase-1-foundation/06-migrate-controllers.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-12.md << 'EOF'
# Task: Migrate Controllers to ASP.NET Core MVC

## Phase
Phase 1: Foundation - Core Migration (Week 2)

## Description
Migrate all controllers from ASP.NET MVC 5 to ASP.NET Core MVC, updating them to use dependency injection and modern patterns.

## Objectives
- Migrate BaseController functionality
- Convert all controllers to use IActionResult
- Implement constructor injection
- Update action methods for ASP.NET Core
- Remove System.Web dependencies

## Prerequisites
- .NET 9 project structure ready
- Dependency injection configured
- Configuration system migrated
- Understanding of current controller architecture

## Dependencies
- Phase 1: Task 05 - Set Up Dependency Injection Container

## Tasks
1. **Analyze Current Controllers:**
   - List all controllers (Students, Courses, Instructors, Departments, Home, Notifications)
   - Document BaseController pattern and its purpose
   - Identify System.Web dependencies
   - Note async/sync patterns

2. **Migrate BaseController:**
   - Remove BaseController inheritance pattern
   - Move DbContext to constructor injection
   - Move NotificationService to constructor injection
   - Create shared controller functionality (base class or helper methods)
   ```csharp
   public class BaseController : Controller
   {
       protected readonly SchoolContext _context;
       protected readonly INotificationService _notifications;
       
       public BaseController(SchoolContext context, INotificationService notifications)
       {
           _context = context;
           _notifications = notifications;
       }
   }
   ```

3. **Migrate HomeController:**
   - Convert to ASP.NET Core Controller
   - Update Index action
   - Update About action
   - Update Contact action
   - Test routing works

4. **Migrate StudentsController:**
   - Update namespace imports
   - Change ActionResult to IActionResult
   - Add constructor with dependencies
   - Update Index (list with pagination)
   - Update Details
   - Update Create (GET and POST)
   - Update Edit (GET and POST)
   - Update Delete (GET and POST)
   - Convert synchronous methods to async

5. **Migrate CoursesController:**
   - Follow same pattern as StudentsController
   - Handle file upload for teaching materials (stub for Phase 2)
   - Update CRUD operations
   - Test all actions

6. **Migrate InstructorsController:**
   - Migrate CRUD operations
   - Handle complex related data loading
   - Update view models if needed
   - Test functionality

7. **Migrate DepartmentsController:**
   - Migrate CRUD operations
   - Handle optimistic concurrency
   - Update error handling
   - Test functionality

8. **Migrate NotificationsController:**
   - Migrate notification retrieval
   - Update API methods
   - Prepare for Azure Service Bus (Phase 2)
   - Test basic functionality

9. **Update Action Results:**
   - Replace ActionResult with IActionResult
   - Use typed results (ViewResult, JsonResult, etc.)
   - Update redirect methods
   - Update error handling

10. **Remove System.Web Dependencies:**
    - Replace HttpContext.Current with injected IHttpContextAccessor
    - Update file upload methods
    - Remove Server.MapPath usage
    - Update URL generation

11. **Update Model Binding:**
    - Verify [FromBody], [FromQuery], [FromRoute] attributes
    - Update custom model binders if any
    - Test model validation

12. **Update Filters:**
    - Convert filter attributes to ASP.NET Core
    - Implement custom filters if needed
    - Test filter execution

## Deliverables
- [ ] BaseController pattern updated or removed
- [ ] HomeController migrated and tested
- [ ] StudentsController migrated and tested
- [ ] CoursesController migrated and tested
- [ ] InstructorsController migrated and tested
- [ ] DepartmentsController migrated and tested
- [ ] NotificationsController migrated and tested
- [ ] All controllers use constructor injection
- [ ] All actions return IActionResult
- [ ] System.Web dependencies removed
- [ ] Basic navigation works

## Acceptance Criteria
- All controllers compile without errors
- All controllers use constructor injection
- No System.Web namespaces remain
- All action methods return IActionResult or derived types
- Basic CRUD operations work (with existing views)
- Routing works correctly
- Error handling is functional
- No BaseController anti-pattern remains

## Estimated Effort
3-4 days

## Notes
- Migrate controllers incrementally and test each one
- Keep old controllers for reference until migration is complete
- Use async/await throughout (convert synchronous methods)
- Pay attention to model binding differences
- Test each controller after migration
- Update XML comments and documentation
- Consider using API analyzers for best practices
- Document any breaking changes or workarounds needed

EOF

gh issue create \
  --title "Migrate Controllers to ASP.NET Core MVC" \
  --body-file /tmp/issue-body-12.md \
  --label "phase-1,migration,high,3-4-days"


# Issue 13: Update Routing to ASP.NET Core Conventions
# File: tasks/phase-1-foundation/07-update-routing.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-13.md << 'EOF'
# Task: Update Routing to ASP.NET Core Conventions

## Phase
Phase 1: Foundation - Core Migration (Week 2)

## Description
Update routing from ASP.NET MVC 5 RouteConfig to ASP.NET Core routing conventions and middleware.

## Objectives
- Remove RouteConfig.cs
- Configure routing in Program.cs
- Set up conventional routing
- Configure attribute routing
- Test all routes work correctly

## Prerequisites
- Controllers migrated to ASP.NET Core
- Program.cs configured
- Understanding of current routing configuration

## Dependencies
- Phase 1: Task 06 - Migrate Controllers to ASP.NET Core MVC

## Tasks
1. **Analyze Current Routing:**
   - Review RouteConfig.cs
   - Document custom routes
   - Identify route constraints
   - Note default routes

2. **Configure Routing in Program.cs:**
   - Add routing middleware to pipeline
   - Configure endpoint routing
   - Set up conventional routes
   ```csharp
   app.MapControllerRoute(
       name: "default",
       pattern: "{controller=Home}/{action=Index}/{id?}");
   ```

3. **Set Up Area Routes (if applicable):**
   - Configure area routing
   - Set up area-specific routes
   - Test area routing

4. **Configure Attribute Routing:**
   - Update controllers to use [Route] attributes where needed
   - Add [HttpGet], [HttpPost] attributes
   - Use route templates for API-like controllers
   - Test attribute routes

5. **Configure Route Constraints:**
   - Add route constraints if needed
   - Configure parameter constraints
   - Test constraint validation

6. **Update Link Generation:**
   - Test Url.Action() calls
   - Test Html.ActionLink() calls
   - Update any hardcoded URLs
   - Verify all links work

7. **Configure Lowercased URLs (optional):**
   ```csharp
   builder.Services.Configure<RouteOptions>(options =>
   {
       options.LowercaseUrls = true;
       options.LowercaseQueryStrings = false;
   });
   ```

8. **Remove Old Routing:**
   - Delete RouteConfig.cs
   - Remove App_Start folder if empty
   - Clean up old routing references

9. **Test Routing:**
   - Test all major routes manually
   - Verify default route works
   - Test parameterized routes
   - Test route constraints
   - Verify 404 handling

## Deliverables
- [ ] Routing configured in Program.cs
- [ ] RouteConfig.cs removed
- [ ] Default route works correctly
- [ ] All controller actions are routable
- [ ] Attribute routing configured where needed
- [ ] Link generation works correctly
- [ ] Route constraints functional
- [ ] 404 pages display correctly

## Acceptance Criteria
- All pages accessible via correct URLs
- No broken links in navigation
- Default route (/) navigates to Home/Index
- Parameterized routes work (e.g., /Students/Details/1)
- RouteConfig.cs and App_Start removed
- URL generation methods work correctly
- Routing is well-documented

## Estimated Effort
1 day

## Notes
- ASP.NET Core uses endpoint routing by default
- Middleware order matters: UseRouting() before UseEndpoints()
- Use attribute routing for API-style controllers
- Use conventional routing for MVC-style controllers
- Test routing with different URL patterns
- Consider using lowercase URLs for consistency
- Document any custom route configurations
- Use route names for generating URLs reliably

EOF

gh issue create \
  --title "Update Routing to ASP.NET Core Conventions" \
  --body-file /tmp/issue-body-13.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 14: Migrate Razor Views to ASP.NET Core
# File: tasks/phase-1-foundation/08-migrate-views.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-14.md << 'EOF'
# Task: Migrate Razor Views to ASP.NET Core

## Phase
Phase 1: Foundation - Core Migration (Week 3)

## Description
Migrate all Razor views from ASP.NET MVC 5 to ASP.NET Core, updating view syntax, helpers, and tag helpers.

## Objectives
- Migrate _ViewStart and _Layout files
- Convert HTML helpers to tag helpers
- Update all view files
- Move static files to wwwroot
- Update script and style references

## Prerequisites
- Controllers migrated and functional
- Static files middleware configured
- Understanding of tag helper syntax

## Dependencies
- Phase 1: Task 06 - Migrate Controllers to ASP.NET Core MVC
- Phase 1: Task 07 - Update Routing to ASP.NET Core Conventions

## Tasks
1. **Analyze Current Views:**
   - List all views and their dependencies
   - Document current HTML helper usage
   - Identify custom helpers
   - Note bundling and script references

2. **Migrate _ViewStart.cshtml:**
   - Copy to Views folder
   - Verify Layout path
   - Test that layout is applied

3. **Migrate _Layout.cshtml:**
   - Update DOCTYPE and HTML structure
   - Remove @Styles.Render() and @Scripts.Render()
   - Add link tags for CSS files
   - Add script tags for JavaScript files
   - Update navigation menu
   - Update @RenderBody(), @RenderSection()
   - Add environment tag helper for dev/prod assets
   ```cshtml
   <environment include="Development">
       <link rel="stylesheet" href="~/css/site.css" />
   </environment>
   <environment exclude="Development">
       <link rel="stylesheet" href="~/css/site.min.css" />
   </environment>
   ```

4. **Migrate _ViewImports.cshtml:**
   - Create _ViewImports.cshtml
   - Add @using statements for namespaces
   - Add @addTagHelper directives
   ```cshtml
   @using ContosoUniversity.Models
   @addTagHelper *, Microsoft.AspNetCore.Mvc.TagHelpers
   ```

5. **Convert Form Helpers:**
   - Replace @Html.BeginForm() with <form asp-controller="" asp-action="">
   - Update form method and attributes
   - Test form submissions

6. **Convert Input Helpers:**
   - Replace @Html.TextBoxFor() with <input asp-for="" />
   - Replace @Html.EditorFor() with <input asp-for="" />
   - Replace @Html.DropDownListFor() with <select asp-for="" asp-items="">
   - Update input attributes and classes

7. **Convert Validation Helpers:**
   - Replace @Html.ValidationMessageFor() with <span asp-validation-for="" />
   - Replace @Html.ValidationSummary() with <div asp-validation-summary="" />
   - Keep validation scripts

8. **Convert Link Helpers:**
   - Replace @Html.ActionLink() with <a asp-controller="" asp-action="">
   - Update link parameters
   - Test all links

9. **Convert Display Helpers:**
   - Update @Html.DisplayFor() usage
   - Update @Html.DisplayNameFor() usage
   - Keep these helpers or replace with direct model references

10. **Migrate All Views by Controller:**
    - Home views (Index, About, Contact)
    - Students views (Index, Details, Create, Edit, Delete)
    - Courses views (Index, Details, Create, Edit, Delete)
    - Instructors views (Index, Details, Create, Edit, Delete)
    - Departments views (Index, Details, Create, Edit, Delete)
    - Shared views (_ValidationScriptsPartial, Error, etc.)

11. **Update Script References:**
    - Update jQuery reference
    - Update validation script references
    - Update custom script references
    - Test client-side validation

12. **Test Each View:**
    - Verify view renders correctly
    - Test form submission
    - Test validation
    - Test links and navigation
    - Verify styling is correct

## Deliverables
- [ ] _ViewStart.cshtml migrated
- [ ] _Layout.cshtml migrated with tag helpers
- [ ] _ViewImports.cshtml created
- [ ] All Home views migrated
- [ ] All Students views migrated
- [ ] All Courses views migrated
- [ ] All Instructors views migrated
- [ ] All Departments views migrated
- [ ] All shared views migrated
- [ ] HTML helpers converted to tag helpers
- [ ] All forms functional
- [ ] All validation working

## Acceptance Criteria
- All views render without errors
- No HTML helper syntax remains (except DisplayFor/DisplayNameFor if kept)
- Tag helpers work correctly
- Forms submit successfully
- Client-side validation works
- All links navigate correctly
- Views follow ASP.NET Core conventions
- Styling is preserved

## Estimated Effort
3-4 days

## Notes
- Migrate views incrementally, one controller at a time
- Test each view after migration
- Tag helpers are more HTML-like and easier to read
- Keep validation scripts (_ValidationScriptsPartial.cshtml)
- Use environment tag helper for dev vs prod assets
- Document any custom tag helpers needed
- Consider using Razor Class Library for shared components
- Test both client-side and server-side validation

EOF

gh issue create \
  --title "Migrate Razor Views to ASP.NET Core" \
  --body-file /tmp/issue-body-14.md \
  --label "phase-1,migration,high,3-4-days"


# Issue 15: Move Static Files to wwwroot and Configure Static File Serving
# File: tasks/phase-1-foundation/09-move-static-files.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-15.md << 'EOF'
# Task: Move Static Files to wwwroot and Configure Static File Serving

## Phase
Phase 1: Foundation - Core Migration (Week 3)

## Description
Move all static files (CSS, JavaScript, images) from Content/ and Scripts/ to wwwroot/ and configure static file middleware.

## Objectives
- Create wwwroot directory structure
- Move CSS files from Content/ to wwwroot/css/
- Move JavaScript files from Scripts/ to wwwroot/js/
- Move images and other assets
- Configure static file middleware
- Update references in views

## Prerequisites
- Views migrated to ASP.NET Core
- Static files middleware added to Program.cs
- Understanding of current static file organization

## Dependencies
- Phase 1: Task 08 - Migrate Razor Views to ASP.NET Core

## Tasks
1. **Create wwwroot Structure:**
   - Create wwwroot/css directory
   - Create wwwroot/js directory
   - Create wwwroot/lib directory (for third-party libraries)
   - Create wwwroot/images directory
   - Create wwwroot/uploads directory (placeholder)

2. **Move CSS Files:**
   - Move all files from Content/ to wwwroot/css/
   - Preserve folder structure if any
   - Update CSS file references
   - Test CSS loading

3. **Move JavaScript Files:**
   - Move all files from Scripts/ to wwwroot/js/
   - Organize JavaScript files logically
   - Keep jQuery and Bootstrap in wwwroot/lib/
   - Update script references

4. **Move Images and Icons:**
   - Move images to wwwroot/images/
   - Move favicons to wwwroot/
   - Update image references in views and CSS

5. **Configure Static Files Middleware:**
   - Already added in Program.cs
   - Configure default files if needed
   - Set up static file options (caching, MIME types)
   ```csharp
   app.UseStaticFiles(new StaticFileOptions
   {
       OnPrepareResponse = ctx =>
       {
           // Set cache headers
           ctx.Context.Response.Headers.Append("Cache-Control", "public,max-age=600");
       }
   });
   ```

6. **Update View References:**
   - Update all link tags in _Layout.cshtml
   - Update all script tags
   - Use ~ prefix for root-relative paths
   - Test all references work

7. **Client-Side Library Management:**
   - Consider using libman for client-side libraries
   - Create libman.json if using libman
   - Or keep CDN references with local fallbacks
   - Document library management strategy

8. **Remove Old Directories:**
   - Delete Content/ directory
   - Delete Scripts/ directory  
   - Remove App_Start/BundleConfig.cs (if exists)
   - Clean up project structure

9. **Test Static Files:**
   - Verify all CSS loads correctly
   - Verify all JavaScript loads correctly
   - Test images display properly
   - Check browser console for 404 errors

## Deliverables
- [ ] wwwroot directory created with proper structure
- [ ] All CSS files moved to wwwroot/css/
- [ ] All JavaScript files moved to wwwroot/js/
- [ ] All images moved to wwwroot/images/
- [ ] Static file middleware configured
- [ ] All view references updated
- [ ] Old Content/ and Scripts/ directories removed
- [ ] No broken static file references

## Acceptance Criteria
- Application styling renders correctly
- No CSS or JavaScript 404 errors
- Images display properly
- Static files are served correctly
- No old Content/ or Scripts/ directories exist
- Client-side functionality works (validation, etc.)
- Browser console shows no errors

## Estimated Effort
1 day

## Notes
- Use wwwroot convention for all static files
- Consider using CDN for popular libraries (jQuery, Bootstrap)
- Set up proper caching headers for production
- Use environment tag helper to switch between dev and production assets
- Consider minification and bundling strategy (WebOptimizer, Webpack, etc.)
- Test on different browsers to ensure cross-browser compatibility
- Document where to place future static files

EOF

gh issue create \
  --title "Move Static Files to wwwroot and Configure Static File Serving" \
  --body-file /tmp/issue-body-15.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 16: Update Entity Framework Core to Version 9
# File: tasks/phase-1-foundation/10-update-ef-core.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-16.md << 'EOF'
# Task: Update Entity Framework Core to Version 9

## Phase
Phase 1: Foundation - Core Migration (Week 4)

## Description
Update Entity Framework Core from version 3.1 to version 9, ensuring compatibility and taking advantage of new features.

## Objectives
- Update EF Core packages to version 9
- Update DbContext for .NET 9
- Review and update LINQ queries for EF Core 9
- Test all database operations
- Document breaking changes

## Prerequisites
- .NET 9 project created
- Packages migrated to PackageReference
- Database schema understood from inventory
- Dependency injection configured

## Dependencies
- Phase 1: Task 05 - Set Up Dependency Injection Container

## Tasks
1. **Update EF Core Packages:**
   - Update Microsoft.EntityFrameworkCore to 9.0.x
   - Update Microsoft.EntityFrameworkCore.SqlServer to 9.0.x
   - Update Microsoft.EntityFrameworkCore.Tools to 9.0.x
   - Update Microsoft.EntityFrameworkCore.Design to 9.0.x (if used)

2. **Review Breaking Changes:**
   - Review EF Core 9 breaking changes documentation
   - Identify affected code in SchoolContext
   - Document required changes
   - Plan migration approach

3. **Update SchoolContext:**
   - Keep DbContext configuration
   - Update OnModelCreating if needed
   - Review entity configurations
   - Update any custom conventions
   - Verify connection string configuration

4. **Update Entity Configurations:**
   - Review all entity type configurations
   - Update any deprecated APIs
   - Test TPH (Table-per-Hierarchy) inheritance for Person/Student/Instructor
   - Verify relationships and navigation properties

5. **Review LINQ Queries:**
   - Identify all LINQ queries in controllers
   - Test queries with EF Core 9
   - Update queries if translation issues occur
   - Look for N+1 query problems
   - Add .Include() where needed for related data

6. **Update Query Methods:**
   - Ensure efficient query patterns
   - Use AsNoTracking() for read-only queries
   - Use proper async methods (ToListAsync, FirstOrDefaultAsync)
   - Optimize complex queries

7. **Test DateTime Handling:**
   - Verify datetime2 handling
   - Test timezone scenarios
   - Check for any date formatting issues

8. **Performance Testing:**
   - Compare query performance with old version
   - Check for query regression
   - Use SQL Server Profiler or logging to inspect generated SQL
   - Optimize slow queries

9. **Test All Database Operations:**
   - Test Create operations
   - Test Read operations (list, details)
   - Test Update operations
   - Test Delete operations
   - Test complex queries (pagination, filtering, sorting)
   - Test related data loading

## Deliverables
- [ ] EF Core packages updated to version 9
- [ ] SchoolContext updated and functional
- [ ] Breaking changes addressed
- [ ] All LINQ queries reviewed and tested
- [ ] Database operations tested
- [ ] Performance verified
- [ ] Migration notes documented

## Acceptance Criteria
- All EF Core packages are version 9.0.x
- SchoolContext compiles without errors
- All database operations work correctly
- No query translation errors
- Performance is acceptable
- TPH inheritance works correctly
- Navigation properties load correctly
- Documentation covers all changes made

## Estimated Effort
1-2 days

## Notes
- EF Core 9 has many performance improvements
- Review the release notes for new features to leverage
- Use logging to see generated SQL during testing
- Consider using compiled queries for frequently used queries
- Test with realistic data volumes
- Document any workarounds needed
- Keep database connection strings in configuration, not code
- Use migrations for schema changes (next task)

EOF

gh issue create \
  --title "Update Entity Framework Core to Version 9" \
  --body-file /tmp/issue-body-16.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 17: Update DbContext for Dependency Injection and Remove Static Factory
# File: tasks/phase-1-foundation/11-update-dbcontext-di.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-17.md << 'EOF'
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

EOF

gh issue create \
  --title "Update DbContext for Dependency Injection and Remove Static Factory" \
  --body-file /tmp/issue-body-17.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 18: Create and Apply EF Core Migrations
# File: tasks/phase-1-foundation/12-create-migrations.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-18.md << 'EOF'
# Task: Create and Apply EF Core Migrations

## Phase
Phase 1: Foundation - Core Migration (Week 4)

## Description
Replace the DbInitializer pattern with EF Core Migrations for safe database schema management in production.

## Objectives
- Create initial EF Core migration
- Replace DbInitializer with migrations
- Test migration on development database
- Document migration process
- Prepare for production database migration

## Prerequisites
- EF Core 9 configured
- DbContext properly set up
- Database schema understood
- Connection to development database

## Dependencies
- Phase 1: Task 11 - Update DbContext for Dependency Injection and Remove Static Factory

## Tasks
1. **Prepare for Migrations:**
   - Ensure EF Core Tools are installed
   - Verify DbContext configuration
   - Back up current database
   - Document current schema

2. **Create Initial Migration:**
   ```bash
   dotnet ef migrations add InitialCreate
   ```
   - Review generated migration code
   - Verify Up() method captures all entities
   - Verify Down() method for rollback
   - Check for any issues or warnings

3. **Review Migration Code:**
   - Check table definitions
   - Verify indexes
   - Check foreign keys
   - Verify data types
   - Review constraints

4. **Test Migration Locally:**
   ```bash
   dotnet ef database update
   ```
   - Apply migration to development database
   - Verify all tables created
   - Verify relationships are correct
   - Test application with migrated database

5. **Update DbInitializer:**
   - Keep seed data logic
   - Remove database recreation logic
   - Convert to a seeding strategy
   - Apply seed data after migration
   ```csharp
   public static class DbInitializer
   {
       public static async Task SeedAsync(SchoolContext context)
       {
           if (await context.Students.AnyAsync())
               return; // DB has been seeded
               
           // Add seed data
           await context.SaveChangesAsync();
       }
   }
   ```

6. **Update Program.cs:**
   - Apply migrations on startup (development only)
   - Run seed data
   - Handle migration errors gracefully
   ```csharp
   using (var scope = app.Services.CreateScope())
   {
       var context = scope.ServiceProvider.GetRequiredService<SchoolContext>();
       
       if (app.Environment.IsDevelopment())
       {
           await context.Database.MigrateAsync(); // Apply pending migrations
           await DbInitializer.SeedAsync(context);
       }
   }
   ```

7. **Test Migration Workflow:**
   - Test creating new migration
   - Test applying migration
   - Test rolling back migration
   - Test updating from previous migration

8. **Document Migration Process:**
   - Document how to create migrations
   - Document how to apply migrations
   - Document how to rollback migrations
   - Create runbook for production migrations
   - Document troubleshooting steps

9. **Production Migration Strategy:**
   - Plan production migration approach
   - Decide on manual vs automatic migrations
   - Create backup strategy
   - Plan rollback procedure
   - Document production migration steps

## Deliverables
- [ ] Initial EF Core migration created
- [ ] Migration tested on development database
- [ ] DbInitializer updated to seed data only
- [ ] Program.cs configured to apply migrations in development
- [ ] Migration process documented
- [ ] Production migration strategy documented
- [ ] Rollback procedure documented
- [ ] All database operations work with migrations

## Acceptance Criteria
- Migration creates correct database schema
- All tables, indexes, and relationships are correct
- Seed data works correctly
- Can create new migrations successfully
- Can apply and rollback migrations
- Documentation is clear and complete
- Production migration plan is ready
- No data loss during migration

## Estimated Effort
1 day

## Notes
- Always back up database before migration
- Test migrations on non-production data first
- Keep migrations small and focused
- Use meaningful migration names
- Never modify applied migrations
- Consider zero-downtime deployment strategies
- Document any manual steps needed for production
- Test rollback procedure thoroughly
- Consider using migration bundles for production deployment

EOF

gh issue create \
  --title "Create and Apply EF Core Migrations" \
  --body-file /tmp/issue-body-18.md \
  --label "phase-1,migration,high,1-2-days"


# Issue 19: Convert Synchronous Operations to Async/Await
# File: tasks/phase-1-foundation/13-convert-to-async.md
# Phase: phase-1-foundation
cat > /tmp/issue-body-19.md << 'EOF'
# Task: Convert Synchronous Operations to Async/Await

## Phase
Phase 1: Foundation - Core Migration (Week 4)

## Description
Convert all synchronous database operations and I/O operations to use async/await patterns for better scalability and performance.

## Objectives
- Identify all synchronous operations
- Convert controller actions to async
- Convert database queries to async
- Update views and calling code
- Test async operations
- Verify performance improvements

## Prerequisites
- Controllers migrated to ASP.NET Core
- DbContext configured
- Understanding of async/await patterns

## Dependencies
- Phase 1: Task 12 - Create and Apply EF Core Migrations

## Tasks
1. **Identify Synchronous Operations:**
   - Find all database operations (ToList, FirstOrDefault, etc.)
   - Identify file I/O operations
   - Find HTTP client calls
   - Document all synchronous methods

2. **Update Controller Actions:**
   - Change return type to Task<IActionResult>
   - Add async keyword to method signature
   - Update all database calls to async versions
   ```csharp
   // Before
   public IActionResult Index()
   {
       var students = _context.Students.ToList();
       return View(students);
   }
   
   // After
   public async Task<IActionResult> Index()
   {
       var students = await _context.Students.ToListAsync();
       return View(students);
   }
   ```

3. **Convert Database Queries:**
   - Replace ToList() with ToListAsync()
   - Replace FirstOrDefault() with FirstOrDefaultAsync()
   - Replace Any() with AnyAsync()
   - Replace Count() with CountAsync()
   - Replace Single() with SingleAsync()
   - Add await to all async calls

4. **Update Create Operations:**
   - Replace Add() + SaveChanges() with async version
   ```csharp
   _context.Students.Add(student);
   await _context.SaveChangesAsync();
   ```

5. **Update Update Operations:**
   - Replace Update() + SaveChanges() with async version
   ```csharp
   _context.Update(student);
   await _context.SaveChangesAsync();
   ```

6. **Update Delete Operations:**
   - Replace Remove() + SaveChanges() with async version
   ```csharp
   _context.Students.Remove(student);
   await _context.SaveChangesAsync();
   ```

7. **Update File Operations:**
   - Convert file uploads to async (Phase 2)
   - Use async file stream operations
   - Update any file reading operations

8. **Update Service Methods:**
   - Convert NotificationService methods to async
   - Update any other service methods
   - Ensure proper async propagation

9. **Test Async Operations:**
   - Test each controller action
   - Verify data is loaded correctly
   - Check for deadlocks or threading issues
   - Test error handling

10. **Performance Testing:**
    - Compare performance before/after
    - Test under concurrent load
    - Verify thread pool usage
    - Monitor resource consumption

11. **Update Error Handling:**
    - Ensure exceptions in async methods are handled
    - Use try-catch in async methods
    - Test error scenarios

## Deliverables
- [ ] All controller actions are async
- [ ] All database operations use async methods
- [ ] All I/O operations are async
- [ ] Services use async patterns
- [ ] Error handling works correctly
- [ ] Performance improvements documented
- [ ] No deadlocks or threading issues

## Acceptance Criteria
- All controller actions have async keyword
- All database calls use async methods
- No synchronous blocking calls remain
- Application compiles without warnings
- All functionality works correctly
- Performance is improved under load
- No threading issues detected
- Error handling works properly

## Estimated Effort
2-3 days

## Notes
- Use async/await all the way up the call stack
- Don't use .Result or .Wait() - these cause deadlocks
- Use ConfigureAwait(false) in library code, not in ASP.NET Core
- Async is about scalability, not necessarily speed
- Test thoroughly under concurrent load
- Watch for async over sync anti-patterns
- Use async methods from EF Core, not sync versions
- Document any remaining synchronous operations and why

EOF

gh issue create \
  --title "Convert Synchronous Operations to Async/Await" \
  --body-file /tmp/issue-body-19.md \
  --label "phase-1,migration,high,2-3-days"


# Issue 20: Export Schema and Data from LocalDB
# File: tasks/phase-2-azure-integration/01-export-database.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-20.md << 'EOF'
# Task: Export Schema and Data from LocalDB

## Phase
Phase 2: Azure Services Integration (Week 1)

## Description
Export the database schema and data from LocalDB in preparation for migration to Azure SQL Database.

## Objectives
- Export complete database schema
- Export all data with referential integrity
- Validate exported data
- Create backup scripts
- Document export process

## Prerequisites
- Phase 1 completed (application functional on .NET 9)
- EF Core migrations created
- Access to LocalDB instance
- SQL Server Management Studio or Azure Data Studio

## Dependencies
- Phase 1: Task 12 - Create and Apply EF Core Migrations

## Tasks
1. **Prepare for Export:**
   - Back up current LocalDB database
   - Document database schema
   - Identify data dependencies
   - Plan export strategy

2. **Export Using EF Core Migrations:**
   - Generate migration script
   ```bash
   dotnet ef migrations script -o migration.sql
   ```
   - Review generated SQL script
   - Verify all tables and relationships
   - Save script for deployment

3. **Alternative: Export Using SQL Server Tools:**
   - Use SSMS to generate scripts
   - Include schema and data
   - Configure script options
   - Export to SQL files

4. **Export Data:**
   - Use BCP or SSMS to export data
   - Export in correct dependency order
   - Include all referential constraints
   - Verify data completeness

5. **Create Seed Data Script:**
   - Export sample/test data
   - Create INSERT statements
   - Maintain referential integrity
   - Test script locally

6. **Validate Export:**
   - Verify all tables included
   - Check all data exported
   - Verify foreign key relationships
   - Check for any missing objects

7. **Create Rollback Script:**
   - Create script to rollback migration
   - Test rollback on copy of database
   - Document rollback procedure

8. **Document Export Process:**
   - Document steps taken
   - Note any issues encountered
   - Create checklist for production export
   - Document data volumes

## Deliverables
- [ ] Database schema export script
- [ ] Data export completed
- [ ] EF Core migration script generated
- [ ] Seed data script created
- [ ] Export validated
- [ ] Rollback script created
- [ ] Export process documented
- [ ] Backup of LocalDB created

## Acceptance Criteria
- Complete schema exported successfully
- All data exported with integrity
- Migration script runs without errors
- Seed data script works correctly
- Export is complete and validated
- Documentation is clear
- Rollback procedure tested

## Estimated Effort
1 day

## Notes
- Always create backups before export
- Test exported scripts on fresh database
- Verify row counts match source
- Handle IDENTITY columns correctly
- Export in dependency order for foreign keys
- Consider data size and compression
- Document any transformations needed
- Test import on local SQL Server first

EOF

gh issue create \
  --title "Export Schema and Data from LocalDB" \
  --body-file /tmp/issue-body-20.md \
  --label "phase-2,migration,high,1-2-days"


# Issue 21: Create Azure SQL Database
# File: tasks/phase-2-azure-integration/02-create-azure-sql.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-21.md << 'EOF'
# Task: Create Azure SQL Database

## Phase
Phase 2: Azure Services Integration (Week 1)

## Description
Create and configure Azure SQL Database for the development environment with proper sizing, security, and configuration.

## Objectives
- Create Azure SQL Database server and database
- Configure firewall rules and networking
- Set up authentication and access control
- Configure backup and recovery
- Test connectivity

## Prerequisites
- Azure subscription configured
- Database schema exported
- Resource groups created
- Understanding of database requirements

## Dependencies
- Phase 0: Task 04 - Create Azure Resources (partial - may need SQL-specific setup)
- Phase 2: Task 01 - Export Schema and Data from LocalDB

## Tasks
1. **Create SQL Database Server:**
   - Create logical SQL Server in Azure
   - Choose appropriate region
   - Configure server admin credentials
   - Use naming convention (e.g., sql-contoso-university-dev)
   - Store credentials in Key Vault

2. **Create SQL Database:**
   - Create database with Serverless tier
   - Choose vCore model (1 vCore for dev)
   - Configure auto-pause delay (1 hour)
   - Set minimum and maximum vCores
   - Configure storage (5-10 GB for dev)

3. **Configure Firewall Rules:**
   - Add "Allow Azure services and resources to access this server"
   - Add IP addresses for development machines
   - Add IP ranges for office/VPN if needed
   - Document firewall rules

4. **Configure Advanced Security:**
   - Enable Advanced Data Security (if needed)
   - Configure threat detection
   - Enable auditing (optional for dev)
   - Configure data classification

5. **Configure Backup and Recovery:**
   - Verify automatic backup is enabled (default)
   - Configure backup retention (7 days for dev)
   - Document point-in-time restore capability
   - Test backup/restore process

6. **Configure Connection Resiliency:**
   - Enable connection retry logic (already in code)
   - Configure connection pooling settings
   - Set command timeout appropriately
   - Document connection string format

7. **Test Connectivity:**
   - Test connection from Azure Portal query editor
   - Test connection from SSMS/Azure Data Studio
   - Test connection from application
   - Verify firewall rules work

8. **Configure Monitoring:**
   - Enable diagnostic logs
   - Configure log retention
   - Set up basic alerts (DTU usage, storage)
   - Create dashboard for monitoring

9. **Document Configuration:**
   - Document server and database settings
   - Document connection string format
   - Document security configuration
   - Create troubleshooting guide

## Deliverables
- [ ] Azure SQL Server created
- [ ] Azure SQL Database created (Serverless tier)
- [ ] Firewall rules configured
- [ ] Advanced security configured
- [ ] Backup and recovery verified
- [ ] Connectivity tested from multiple sources
- [ ] Monitoring and alerts configured
- [ ] Configuration documented
- [ ] Connection string stored in Key Vault

## Acceptance Criteria
- SQL Server and database are accessible
- Can connect from development machines
- Can connect from Azure services
- Firewall rules allow required access
- Backup is configured correctly
- Monitoring is capturing metrics
- Connection string is secured in Key Vault
- Documentation is complete

## Estimated Effort
1 day

## Notes
- Use Serverless tier for development to minimize costs
- Database auto-pauses after 1 hour of inactivity
- First request after auto-pause may be slow (resume time)
- Use locally redundant storage for dev (cheaper)
- Consider geo-redundancy for production
- Set up cost alerts to avoid surprises
- Test connection from different networks
- Document any connection troubleshooting steps
- Use managed identity for production (setup in later task)

EOF

gh issue create \
  --title "Create Azure SQL Database" \
  --body-file /tmp/issue-body-21.md \
  --label "phase-2,azure,high,1-2-days"


# Issue 22: Run Database Migrations on Azure SQL
# File: tasks/phase-2-azure-integration/03-run-migrations-azure.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-22.md << 'EOF'
# Task: Run Database Migrations on Azure SQL

## Phase
Phase 2: Azure Services Integration (Week 1)

## Description
Apply EF Core migrations to Azure SQL Database and import seed data for development and testing.

## Objectives
- Apply EF Core migrations to Azure SQL
- Import seed data
- Verify database schema
- Test database operations
- Document migration process

## Prerequisites
- Azure SQL Database created
- EF Core migrations ready
- Database export scripts ready
- Connection string available

## Dependencies
- Phase 2: Task 02 - Create Azure SQL Database

## Tasks
1. **Update Connection String:**
   - Get Azure SQL connection string from portal
   - Add to appsettings.Development.json
   - Store in user secrets locally
   - Verify connection string format
   ```json
   {
     "ConnectionStrings": {
       "DefaultConnection": "Server=tcp:sql-contoso-dev.database.windows.net,1433;Initial Catalog=ContosoUniversity;..."
     }
   }
   ```

2. **Test Connection:**
   - Test connection from application
   - Verify firewall allows connection
   - Test with SQL Server Management Studio
   - Resolve any connection issues

3. **Apply Migrations Using EF Core:**
   - Run migration command
   ```bash
   dotnet ef database update --connection "connection_string"
   ```
   - Verify migration applied successfully
   - Check for errors in output
   - Verify all tables created

4. **Alternative: Apply Migration Script:**
   - Run generated migration.sql script
   - Execute using SSMS or Azure Data Studio
   - Verify execution completed
   - Check for errors

5. **Verify Schema:**
   - Connect to Azure SQL with SSMS
   - Verify all tables exist
   - Check indexes and constraints
   - Verify foreign key relationships
   - Check column types and nullability

6. **Import Seed Data:**
   - Run DbInitializer seed logic
   - Or execute seed data SQL script
   - Verify data imported correctly
   - Check referential integrity

7. **Verify Data:**
   - Query tables to verify data
   - Check row counts
   - Verify relationships between tables
   - Test sample queries

8. **Update Application Configuration:**
   - Update connection string in application
   - Test application with Azure SQL
   - Verify CRUD operations work
   - Test all major features

9. **Configure Migration Automation:**
   - Update Program.cs to apply migrations on startup (dev only)
   - Test automatic migration application
   - Document manual migration process for production

10. **Test Database Operations:**
    - Test Create operations
    - Test Read operations
    - Test Update operations
    - Test Delete operations
    - Test complex queries with joins
    - Test pagination and sorting

11. **Performance Testing:**
    - Compare performance with LocalDB
    - Test query response times
    - Monitor DTU usage
    - Identify slow queries

## Deliverables
- [ ] Connection string configured
- [ ] Migrations applied to Azure SQL
- [ ] Database schema verified
- [ ] Seed data imported
- [ ] Application connected to Azure SQL
- [ ] All CRUD operations tested
- [ ] Performance benchmarks documented
- [ ] Migration process documented

## Acceptance Criteria
- Database schema matches local database
- All migrations applied successfully
- Seed data imported correctly
- Application connects to Azure SQL
- All database operations work
- Performance is acceptable
- No errors in application logs
- Documentation is complete

## Estimated Effort
1 day

## Notes
- Always back up before running migrations
- Test migrations on dev database first
- Monitor DTU usage during testing
- Keep LocalDB as backup during transition
- Document any performance issues
- Plan for production migration separately
- Use connection resiliency in application
- Test error scenarios (connection failures, timeouts)
- Consider using migration bundles for production

EOF

gh issue create \
  --title "Run Database Migrations on Azure SQL" \
  --body-file /tmp/issue-body-22.md \
  --label "phase-2,azure,high,1-2-days"


# Issue 23: Update Connection String and Test Connectivity
# File: tasks/phase-2-azure-integration/04-test-connectivity.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-23.md << 'EOF'
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

EOF

gh issue create \
  --title "Update Connection String and Test Connectivity" \
  --body-file /tmp/issue-body-23.md \
  --label "phase-2,testing,high,1-2-days"


# Issue 24: Create Azure Service Bus Namespace and Queue
# File: tasks/phase-2-azure-integration/05-create-service-bus.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-24.md << 'EOF'
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

EOF

gh issue create \
  --title "Create Azure Service Bus Namespace and Queue" \
  --body-file /tmp/issue-body-24.md \
  --label "phase-2,azure,high,1-2-days"


# Issue 25: Update NotificationService to Use Azure Service Bus
# File: tasks/phase-2-azure-integration/06-update-notification-service.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-25.md << 'EOF'
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

EOF

gh issue create \
  --title "Update NotificationService to Use Azure Service Bus" \
  --body-file /tmp/issue-body-25.md \
  --label "phase-2,azure,high,2-3-days"


# Issue 26: Create Azure Blob Storage Account and Container
# File: tasks/phase-2-azure-integration/07-create-blob-storage.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-26.md << 'EOF'
# Task: Create Azure Blob Storage Account and Container

## Phase
Phase 2: Azure Services Integration (Week 2)

## Description
Create Azure Blob Storage account and container to replace local file system for teaching material uploads.

## Objectives
- Create Azure Storage account
- Create blob container for teaching materials
- Configure access and security
- Test blob operations
- Set up monitoring

## Prerequisites
- Azure subscription and resource groups configured
- Understanding of current file upload implementation
- File upload paths documented

## Dependencies
- Phase 2: Task 06 - Update NotificationService to Use Azure Service Bus

## Tasks
1. **Create Storage Account:**
   - Create storage account in Azure portal or CLI
   - Choose Standard performance tier
   - Choose Locally Redundant Storage (LRS) for dev
   - Use naming convention (e.g., stcontosounivdev)
   - Select same region as other resources
   - Enable soft delete (optional for dev)

2. **Configure Storage Account Settings:**
   - Enable blob versioning (optional)
   - Configure firewall and virtual networks
   - Enable secure transfer required (HTTPS)
   - Configure minimum TLS version (1.2)
   - Document configuration

3. **Create Blob Container:**
   - Create container named "teaching-materials"
   - Set access level to Private (blob)
   - Configure metadata if needed
   - Document container settings

4. **Configure CORS (if needed):**
   - Add CORS rules for web access
   - Configure allowed origins
   - Configure allowed methods (GET, POST, PUT, DELETE)
   - Configure allowed headers
   - Test CORS configuration

5. **Set Up Access Keys:**
   - Generate access keys
   - Store connection string in Key Vault
   - Document key rotation policy
   - Plan for using Managed Identity later

6. **Configure SAS Tokens:**
   - Understand SAS token creation
   - Document SAS token usage for secure file access
   - Plan SAS token expiration strategy
   - Test SAS token generation

7. **Test Blob Operations:**
   - Use Azure Storage Explorer
   - Upload test file
   - Download test file
   - Delete test file
   - List blobs in container

8. **Configure Lifecycle Management:**
   - Set up blob lifecycle policies (optional)
   - Archive old blobs to cool/archive tier
   - Delete old blobs after retention period
   - Document lifecycle policy

9. **Configure Monitoring:**
   - Enable diagnostic logs
   - Configure metrics collection
   - Set up alerts for:
     - Storage capacity
     - Failed requests
     - Throttling
   - Create monitoring dashboard

10. **Configure Backup (optional for dev):**
    - Enable soft delete
    - Configure retention period
    - Document backup strategy
    - Test restore process

11. **Security Configuration:**
    - Review access policies
    - Verify HTTPS is enforced
    - Plan for managed identity usage
    - Document security settings

12. **Cost Optimization:**
    - Review storage tier (Hot for dev)
    - Configure lifecycle management
    - Monitor storage usage
    - Set up cost alerts

## Deliverables
- [ ] Storage account created
- [ ] Blob container created
- [ ] Access configured (private)
- [ ] Connection string stored in Key Vault
- [ ] CORS configured if needed
- [ ] SAS token strategy documented
- [ ] Monitoring and alerts configured
- [ ] Test operations completed successfully
- [ ] Configuration documented

## Acceptance Criteria
- Storage account is accessible
- Blob container is created
- Can upload and download blobs
- Connection string is secured
- CORS works if needed
- Monitoring captures metrics
- Alerts are configured
- Documentation is complete
- Security settings are appropriate

## Estimated Effort
1 day

## Notes
- Use Hot tier for frequently accessed files
- Consider Cool or Archive tier for old files
- Enable soft delete for accidental deletion protection
- Use Managed Identity for better security (later task)
- Test blob operations from Azure Portal
- Monitor storage costs regularly
- Plan for CDN integration if global access needed
- Document naming conventions for blobs
- Consider using Storage Explorer for testing
- Plan for production storage sizing separately

EOF

gh issue create \
  --title "Create Azure Blob Storage Account and Container" \
  --body-file /tmp/issue-body-26.md \
  --label "phase-2,deployment,high,1-2-days"


# Issue 27: Update File Upload to Use Azure Blob Storage
# File: tasks/phase-2-azure-integration/08-update-file-upload.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-27.md << 'EOF'
# Task: Update File Upload to Use Azure Blob Storage

## Phase
Phase 2: Azure Services Integration (Week 2)

## Description
Replace local file system storage with Azure Blob Storage for teaching material uploads.

## Objectives
- Add Azure.Storage.Blobs SDK
- Update CoursesController file upload logic
- Implement blob upload/download methods
- Generate SAS tokens for secure access
- Update views to display blob URLs
- Remove local file system dependencies

## Prerequisites
- Blob Storage account and container created
- Connection string available
- Current file upload code reviewed

## Dependencies
- Phase 2: Task 07 - Create Azure Blob Storage Account and Container

## Tasks
1. Add Azure.Storage.Blobs NuGet package
2. Create BlobStorageService with upload/download/delete methods
3. Register BlobStorageService in DI container
4. Update CoursesController Create/Edit actions to use blob storage
5. Generate SAS tokens for secure file access
6. Update views to use blob URLs instead of local paths
7. Implement file deletion when course is deleted or file replaced
8. Test file upload, download, and deletion
9. Remove local file system upload code
10. Update documentation

## Estimated Effort
2-3 days

## Acceptance Criteria
- Files upload to Blob Storage successfully
- Files are accessible via SAS URLs
- Old files are deleted properly
- No local file system dependencies remain
- All tests pass

EOF

gh issue create \
  --title "Update File Upload to Use Azure Blob Storage" \
  --body-file /tmp/issue-body-27.md \
  --label "phase-2,azure,high,2-3-days"


# Issue 28: Set Up Azure AD B2C Tenant
# File: tasks/phase-2-azure-integration/09-setup-azure-ad-b2c.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-28.md << 'EOF'
# Task: Set Up Azure AD B2C Tenant

## Phase
Phase 2: Azure Services Integration (Week 3)

## Description
Set up Azure AD B2C tenant for modern authentication, replacing Windows Authentication.

## Objectives
- Create Azure AD B2C tenant
- Register application
- Configure user flows
- Set up authentication policies
- Test authentication

## Prerequisites
- Azure subscription available
- Understanding of authentication requirements
- Application inventory of users and roles

## Dependencies
- Phase 2: Task 08 - Update File Upload to Use Azure Blob Storage

## Tasks
1. Create Azure AD B2C tenant
2. Register web application in B2C
3. Configure redirect URIs
4. Set up sign-up and sign-in user flows
5. Configure password reset flow
6. Define custom attributes if needed
7. Configure branding (optional)
8. Test authentication flows in Azure portal
9. Document tenant and application settings
10. Store B2C configuration values

## Estimated Effort
1-2 days

## Acceptance Criteria
- B2C tenant is created
- Application is registered
- User flows are configured
- Can test authentication in portal
- Configuration is documented

EOF

gh issue create \
  --title "Set Up Azure AD B2C Tenant" \
  --body-file /tmp/issue-body-28.md \
  --label "phase-2,azure,high,1-2-days"


# Issue 29: Implement Azure AD B2C Authentication
# File: tasks/phase-2-azure-integration/10-implement-authentication.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-29.md << 'EOF'
# Task: Implement Azure AD B2C Authentication

## Phase
Phase 2: Azure Services Integration (Week 3)

## Description
Implement Azure AD B2C authentication in the application, replacing Windows Authentication.

## Objectives
- Add Microsoft.Identity.Web packages
- Configure authentication middleware
- Update controllers with [Authorize] attributes
- Convert role-based to claims-based authorization
- Test authentication flows

## Prerequisites
- Azure AD B2C tenant configured
- Application registered
- User flows created

## Dependencies
- Phase 2: Task 09 - Set Up Azure AD B2C Tenant

## Tasks
1. Add Microsoft.Identity.Web and Microsoft.Identity.Web.UI packages
2. Configure authentication in Program.cs
3. Add Azure AD B2C settings to appsettings.json
4. Configure authentication middleware
5. Update [Authorize] attributes on controllers
6. Implement claims-based authorization
7. Update _Layout.cshtml with sign-in/sign-out links
8. Test sign-in flow
9. Test sign-out flow
10. Test authorized and unauthorized access
11. Remove Windows Authentication
12. Document authentication setup

## Estimated Effort
2-3 days

## Acceptance Criteria
- Users can sign in with Azure AD B2C
- Users can sign out
- Authorized pages require authentication
- Claims are properly populated
- Windows Authentication is removed
- Documentation is complete

EOF

gh issue create \
  --title "Implement Azure AD B2C Authentication" \
  --body-file /tmp/issue-body-29.md \
  --label "phase-2,azure,high,2-3-days"


# Issue 30: Set Up Azure Key Vault and Move Secrets
# File: tasks/phase-2-azure-integration/11-setup-key-vault.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-30.md << 'EOF'
# Task: Set Up Azure Key Vault and Move Secrets

## Phase
Phase 2: Azure Services Integration (Week 3)

## Description
Create Azure Key Vault and migrate all secrets from configuration files to secure storage.

## Objectives
- Create Azure Key Vault
- Store connection strings and secrets
- Configure application to read from Key Vault
- Implement Managed Identity (preparation)
- Remove secrets from appsettings.json

## Prerequisites
- Azure subscription configured
- All connection strings documented
- Understanding of secrets to migrate

## Dependencies
- Phase 2: Task 10 - Implement Azure AD B2C Authentication

## Tasks
1. Create Azure Key Vault in Azure portal
2. Configure access policies for development team
3. Store secrets in Key Vault:
   - SQL Database connection string
   - Service Bus connection string
   - Storage Account connection string
   - Azure AD B2C client secret
4. Add Azure.Extensions.AspNetCore.Configuration.Secrets package
5. Configure application to read from Key Vault
6. Test application with Key Vault integration
7. Remove secrets from appsettings.json (keep keys only)
8. Update documentation
9. Plan for Managed Identity setup (Phase 4)

## Estimated Effort
1-2 days

## Acceptance Criteria
- Key Vault is created
- All secrets are stored in Key Vault
- Application reads secrets from Key Vault
- No secrets in appsettings.json
- Application works correctly
- Documentation is updated

EOF

gh issue create \
  --title "Set Up Azure Key Vault and Move Secrets" \
  --body-file /tmp/issue-body-30.md \
  --label "phase-2,azure,high,1-2-days"


# Issue 31: Test All Azure Services Integration
# File: tasks/phase-2-azure-integration/12-test-integration.md
# Phase: phase-2-azure-integration
cat > /tmp/issue-body-31.md << 'EOF'
# Task: Test All Azure Services Integration

## Phase
Phase 2: Azure Services Integration (Week 3)

## Description
Comprehensive testing of all Azure services integration to ensure everything works together correctly.

## Objectives
- Test end-to-end scenarios
- Verify all Azure services integration
- Test error handling
- Perform integration testing
- Document any issues

## Prerequisites
- All Phase 2 tasks completed
- Azure SQL, Service Bus, Blob Storage, AD B2C configured
- Application fully migrated to Azure services

## Dependencies
- Phase 2: Task 11 - Set Up Azure Key Vault and Move Secrets

## Tasks
1. **Test Database Operations:**
   - Test CRUD for all entities
   - Test complex queries
   - Test concurrent operations
   - Verify connection resiliency

2. **Test Notification System:**
   - Send notifications from various actions
   - Verify messages in Service Bus
   - Test message retrieval
   - Check dead-letter queue handling

3. **Test File Upload:**
   - Upload teaching materials
   - Verify files in Blob Storage
   - Download files using SAS URLs
   - Delete files and verify removal

4. **Test Authentication:**
   - Sign in with test users
   - Test authorized access
   - Test unauthorized access
   - Test sign-out

5. **Test Configuration:**
   - Verify secrets from Key Vault
   - Test environment-specific settings
   - Verify all connection strings work

6. **Integration Testing:**
   - Test complete user workflows
   - Test error scenarios
   - Test timeout scenarios
   - Test network failures

7. **Performance Testing:**
   - Test response times
   - Test under load
   - Monitor Azure resource usage
   - Identify bottlenecks

8. **Security Testing:**
   - Verify HTTPS enforcement
   - Test authentication requirements
   - Verify secrets are not exposed
   - Test SAS token expiration

9. **Document Issues:**
   - Log any bugs found
   - Document workarounds
   - Create issue tickets
   - Prioritize fixes

## Estimated Effort
2-3 days

## Acceptance Criteria
- All CRUD operations work
- Notifications are sent and received
- File uploads work correctly
- Authentication works properly
- All Azure services are functional
- No critical bugs found
- Performance is acceptable
- Documentation is complete

EOF

gh issue create \
  --title "Test All Azure Services Integration" \
  --body-file /tmp/issue-body-31.md \
  --label "phase-2,testing,high,2-3-days"


# Issue 32: Set Up Test Projects
# File: tasks/phase-3-testing-quality/01-setup-test-projects.md
# Phase: phase-3-testing-quality
cat > /tmp/issue-body-32.md << 'EOF'
# Task: Set Up Test Projects

## Phase
Phase 3: Testing and Quality (Week 1)

## Description
Create comprehensive test project structure with unit, integration, and E2E test projects.

## Objectives
- Create test project structure
- Add testing frameworks
- Set up test data builders
- Configure test databases
- Establish testing patterns

## Dependencies
- Phase 2: Task 12 - Test All Azure Services Integration

## Tasks
1. Create ContosoUniversity.Tests.Unit project
2. Create ContosoUniversity.Tests.Integration project
3. Create ContosoUniversity.Tests.E2E project (optional)
4. Add xUnit, Moq, FluentAssertions packages
5. Set up in-memory database for integration tests
6. Create test data builders and fixtures
7. Configure test settings
8. Document testing standards

## Estimated Effort
1-2 days

## Acceptance Criteria
- Test projects created
- Testing frameworks installed
- Can run empty tests
- Test infrastructure documented

EOF

gh issue create \
  --title "Set Up Test Projects" \
  --body-file /tmp/issue-body-32.md \
  --label "phase-3,testing,high,1-2-days"


# Issue 33: Write Unit Tests for Controllers and Services
# File: tasks/phase-3-testing-quality/02-write-unit-tests.md
# Phase: phase-3-testing-quality
cat > /tmp/issue-body-33.md << 'EOF'
# Task: Write Unit Tests for Controllers and Services

## Phase
Phase 3: Testing and Quality (Week 1)

## Description
Write comprehensive unit tests for controllers and services with 70%+ code coverage target.

## Objectives
- Write unit tests for all controllers
- Write unit tests for services
- Mock dependencies
- Achieve 70%+ code coverage
- Document test patterns

## Dependencies
- Phase 3: Task 01 - Set Up Test Projects

## Tasks
1. Write tests for StudentsController (CRUD operations)
2. Write tests for CoursesController (CRUD + file upload)
3. Write tests for InstructorsController
4. Write tests for DepartmentsController
5. Write tests for HomeController
6. Write tests for NotificationService
7. Write tests for BlobStorageService
8. Mock DbContext, Service Bus, Blob Storage
9. Test error scenarios
10. Run code coverage analysis
11. Improve coverage to 70%+
12. Document test patterns

## Estimated Effort
3-4 days

## Acceptance Criteria
- All controllers have unit tests
- All services have unit tests
- Code coverage >= 70%
- All tests pass
- Tests are well-documented

EOF

gh issue create \
  --title "Write Unit Tests for Controllers and Services" \
  --body-file /tmp/issue-body-33.md \
  --label "phase-3,testing,high,3-4-days"


# Issue 34: Write Integration Tests
# File: tasks/phase-3-testing-quality/03-write-integration-tests.md
# Phase: phase-3-testing-quality
cat > /tmp/issue-body-34.md << 'EOF'
# Task: Write Integration Tests

## Phase
Phase 3: Testing and Quality (Week 1)

## Description
Write integration tests for data layer and Azure services integration.

## Objectives
- Test database operations with real DbContext
- Test Azure services integration
- Test complete workflows
- Verify data integrity

## Dependencies
- Phase 3: Task 02 - Write Unit Tests for Controllers and Services

## Tasks
1. Create integration tests for SchoolContext
2. Test CRUD operations with in-memory database
3. Test complex queries and relationships
4. Test EF Core migrations
5. Test Azure Service Bus integration (if possible)
6. Test Blob Storage integration (if possible)
7. Test authentication flows
8. Run integration tests in CI/CD
9. Document integration test patterns

## Estimated Effort
2-3 days

## Acceptance Criteria
- Integration tests for data layer complete
- Tests use in-memory database
- All tests pass
- Tests run in CI/CD pipeline
- Documentation complete

EOF

gh issue create \
  --title "Write Integration Tests" \
  --body-file /tmp/issue-body-34.md \
  --label "phase-3,testing,high,2-3-days"


# Issue 35: Set Up Application Insights
# File: tasks/phase-3-testing-quality/04-setup-app-insights.md
# Phase: phase-3-testing-quality
cat > /tmp/issue-body-35.md << 'EOF'
# Task: Set Up Application Insights

## Phase
Phase 3: Testing and Quality (Week 2)

## Description
Configure Azure Application Insights for comprehensive monitoring and telemetry.

## Objectives
- Create Application Insights resource
- Configure instrumentation
- Add custom telemetry
- Set up dashboards and alerts
- Test monitoring

## Dependencies
- Phase 3: Task 03 - Write Integration Tests

## Tasks
1. Create Application Insights resource in Azure
2. Add Microsoft.ApplicationInsights.AspNetCore package
3. Configure Application Insights in Program.cs
4. Add instrumentation key to configuration
5. Add custom telemetry for business events
6. Configure telemetry processors
7. Set up dashboards in Azure portal
8. Configure alerts (exceptions, response time, availability)
9. Test telemetry collection
10. Document monitoring setup

## Estimated Effort
1-2 days

## Acceptance Criteria
- Application Insights is configured
- Telemetry is being collected
- Dashboards show metrics
- Alerts are configured
- Documentation complete

EOF

gh issue create \
  --title "Set Up Application Insights" \
  --body-file /tmp/issue-body-35.md \
  --label "phase-3,setup,high,1-2-days"


# Issue 36: Implement Structured Logging with Serilog
# File: tasks/phase-3-testing-quality/05-implement-logging.md
# Phase: phase-3-testing-quality
cat > /tmp/issue-body-36.md << 'EOF'
# Task: Implement Structured Logging with Serilog

## Phase
Phase 3: Testing and Quality (Week 2)

## Description
Implement structured logging using Serilog with Application Insights integration.

## Objectives
- Add Serilog packages
- Configure structured logging
- Add log enrichers
- Configure Application Insights sink
- Update logging throughout application

## Dependencies
- Phase 3: Task 04 - Set Up Application Insights

## Tasks
1. Add Serilog packages (Serilog.AspNetCore, Serilog.Sinks.ApplicationInsights)
2. Configure Serilog in Program.cs
3. Add log enrichers (request, user, environment)
4. Configure log levels per namespace
5. Update controllers to use ILogger<T>
6. Add structured logging to services
7. Log exceptions with context
8. Test logging in Application Insights
9. Remove Debug.WriteLine statements
10. Document logging standards

## Estimated Effort
1-2 days

## Acceptance Criteria
- Serilog is configured
- Logs appear in Application Insights
- Structured logging is used throughout
- Log levels are appropriate
- Documentation complete

EOF

gh issue create \
  --title "Implement Structured Logging with Serilog" \
  --body-file /tmp/issue-body-36.md \
  --label "phase-3,migration,high,1-2-days"


# Issue 37: Add Health Checks and Security Hardening
# File: tasks/phase-3-testing-quality/06-health-security.md
# Phase: phase-3-testing-quality
cat > /tmp/issue-body-37.md << 'EOF'
# Task: Add Health Checks and Security Hardening

## Phase
Phase 3: Testing and Quality (Week 2)

## Description
Implement health checks, rate limiting, CSRF protection, and other security enhancements.

## Objectives
- Add health check endpoints
- Implement rate limiting
- Add CSRF protection
- Add security headers
- Perform security scan

## Dependencies
- Phase 3: Task 05 - Implement Structured Logging with Serilog

## Tasks
1. Add health checks for database, Service Bus, Blob Storage
2. Expose health check endpoint (/health)
3. Add AspNetCoreRateLimit package
4. Configure rate limiting middleware
5. Enable anti-forgery tokens in forms
6. Add security headers middleware (HSTS, CSP, etc.)
7. Configure CORS appropriately
8. Run security scan (OWASP ZAP or similar)
9. Fix identified vulnerabilities
10. Document security measures

## Estimated Effort
2-3 days

## Acceptance Criteria
- Health checks are functional
- Rate limiting works
- CSRF protection enabled
- Security headers configured
- Security scan passed
- Documentation complete

EOF

gh issue create \
  --title "Add Health Checks and Security Hardening" \
  --body-file /tmp/issue-body-37.md \
  --label "phase-3,migration,high,2-3-days"


# Issue 38: Performance Testing and Optimization
# File: tasks/phase-3-testing-quality/07-performance-testing.md
# Phase: phase-3-testing-quality
cat > /tmp/issue-body-38.md << 'EOF'
# Task: Performance Testing and Optimization

## Phase
Phase 3: Testing and Quality (Week 2)

## Description
Perform performance testing, identify bottlenecks, and optimize application performance.

## Objectives
- Run load tests
- Identify bottlenecks
- Optimize queries
- Improve response times
- Document performance benchmarks

## Dependencies
- Phase 3: Task 06 - Add Health Checks and Security Hardening

## Tasks
1. Set up load testing tool (Apache JMeter, k6, or Azure Load Testing)
2. Create load test scenarios
3. Run baseline performance tests
4. Identify slow queries using Application Insights
5. Optimize N+1 queries with .Include()
6. Add AsNoTracking() to read-only queries
7. Consider adding caching (optional)
8. Re-run performance tests
9. Document performance improvements
10. Establish performance benchmarks

## Estimated Effort
2-3 days

## Acceptance Criteria
- Load tests completed
- Bottlenecks identified and resolved
- Queries optimized
- Performance benchmarks documented
- Response times acceptable

EOF

gh issue create \
  --title "Performance Testing and Optimization" \
  --body-file /tmp/issue-body-38.md \
  --label "phase-3,testing,high,2-3-days"


# Issue 39: Create Dockerfile and Test Container Locally
# File: tasks/phase-4-deployment/01-create-dockerfile.md
# Phase: phase-4-deployment
cat > /tmp/issue-body-39.md << 'EOF'
# Task: Create Dockerfile and Test Container Locally

## Phase
Phase 4: Deployment and Cutover (Day 1-2)

## Description
Create Dockerfile for the application and test container build and execution locally.

## Objectives
- Create optimized Dockerfile
- Build container image
- Test container locally
- Optimize image size
- Document container build

## Dependencies
- Phase 3: Task 07 - Performance Testing and Optimization

## Tasks
1. Create Dockerfile with multi-stage build
2. Configure base images (.NET 9 SDK and runtime)
3. Copy application files
4. Set up entry point
5. Build container image
6. Run container locally with Docker Desktop
7. Test application in container
8. Optimize image size (remove unnecessary files)
9. Create .dockerignore file
10. Document Docker build process
11. Test with different configurations

## Estimated Effort
1 day

## Acceptance Criteria
- Dockerfile created
- Container builds successfully
- Application runs in container
- Can access application on localhost
- Image size is optimized
- Documentation complete

EOF

gh issue create \
  --title "Create Dockerfile and Test Container Locally" \
  --body-file /tmp/issue-body-39.md \
  --label "phase-4,testing,high,1-2-days"


# Issue 40: Push Container to Azure Container Registry
# File: tasks/phase-4-deployment/02-push-to-acr.md
# Phase: phase-4-deployment
cat > /tmp/issue-body-40.md << 'EOF'
# Task: Push Container to Azure Container Registry

## Phase
Phase 4: Deployment and Cutover (Day 1-2)

## Description
Create Azure Container Registry and push the container image for deployment.

## Objectives
- Create Azure Container Registry
- Tag container image
- Push image to ACR
- Configure access
- Test image pull

## Dependencies
- Phase 4: Task 01 - Create Dockerfile and Test Container Locally

## Tasks
1. Create Azure Container Registry (Basic tier for dev)
2. Enable admin access for testing
3. Log in to ACR using Docker CLI
4. Tag container image
5. Push image to ACR
6. Verify image in Azure portal
7. Test pulling image from ACR
8. Configure service principal for CI/CD
9. Document ACR configuration

## Estimated Effort
0.5 day

## Acceptance Criteria
- ACR is created
- Image pushed successfully
- Can pull image from ACR
- CI/CD credentials configured
- Documentation complete

EOF

gh issue create \
  --title "Push Container to Azure Container Registry" \
  --body-file /tmp/issue-body-40.md \
  --label "phase-4,deployment,high,1-week"


# Issue 41: Create Azure Container Apps Environment and Deploy
# File: tasks/phase-4-deployment/03-deploy-container-apps.md
# Phase: phase-4-deployment
cat > /tmp/issue-body-41.md << 'EOF'
# Task: Create Azure Container Apps Environment and Deploy

## Phase
Phase 4: Deployment and Cutover (Day 3-4)

## Description
Create Container Apps environment, configure the application, and deploy the first version.

## Objectives
- Create Container Apps environment
- Configure container app
- Set up environment variables
- Configure scaling rules
- Deploy application
- Test deployment

## Dependencies
- Phase 4: Task 02 - Push Container to Azure Container Registry

## Tasks
1. Create Container Apps environment
2. Create container app
3. Configure container image from ACR
4. Set up environment variables (connection strings, settings)
5. Configure managed identity for Key Vault access
6. Configure ingress (HTTPS, external)
7. Configure scaling rules (HTTP, CPU-based)
8. Configure health checks
9. Deploy application
10. Test application in Azure
11. Configure custom domain (optional)
12. Test all functionality
13. Document deployment configuration

## Estimated Effort
1-2 days

## Acceptance Criteria
- Container Apps environment created
- Application deployed successfully
- Application is accessible via URL
- All functionality works
- Scaling rules configured
- Health checks functional
- Documentation complete

EOF

gh issue create \
  --title "Create Azure Container Apps Environment and Deploy" \
  --body-file /tmp/issue-body-41.md \
  --label "phase-4,deployment,high,1-2-days"


# Issue 42: Complete CI/CD Pipeline and Automate Deployment
# File: tasks/phase-4-deployment/04-complete-cicd.md
# Phase: phase-4-deployment
cat > /tmp/issue-body-42.md << 'EOF'
# Task: Complete CI/CD Pipeline and Automate Deployment

## Phase
Phase 4: Deployment and Cutover (Day 3-4)

## Description
Complete the CI/CD pipeline with automated build, test, and deployment to Azure Container Apps.

## Objectives
- Complete GitHub Actions workflows
- Automate container build
- Automate deployment to dev
- Add manual approval for production
- Test complete pipeline

## Dependencies
- Phase 4: Task 03 - Create Azure Container Apps Environment and Deploy

## Tasks
1. Update .github/workflows/build.yml with full build steps
2. Create .github/workflows/deploy.yml with deployment logic
3. Configure GitHub secrets (Azure credentials, ACR credentials)
4. Add container build and push steps
5. Add deployment to Container Apps step
6. Configure environment-specific deployments
7. Add manual approval gate for production
8. Test complete pipeline end-to-end
9. Document CI/CD process
10. Create rollback procedure

## Estimated Effort
1 day

## Acceptance Criteria
- Build workflow builds and tests code
- Deploy workflow builds container and deploys
- Can deploy to dev automatically
- Production deployment requires approval
- All workflows run successfully
- Documentation complete

EOF

gh issue create \
  --title "Complete CI/CD Pipeline and Automate Deployment" \
  --body-file /tmp/issue-body-42.md \
  --label "phase-4,deployment,high,1-2-days"


# Issue 43: Production Deployment and Smoke Tests
# File: tasks/phase-4-deployment/05-production-deployment.md
# Phase: phase-4-deployment
cat > /tmp/issue-body-43.md << 'EOF'
# Task: Production Deployment and Smoke Tests

## Phase
Phase 4: Deployment and Cutover (Day 5)

## Description
Deploy application to production environment and perform comprehensive smoke tests.

## Objectives
- Deploy to production
- Run smoke tests
- Verify all functionality
- Monitor for issues
- Document any problems

## Dependencies
- Phase 4: Task 04 - Complete CI/CD Pipeline and Automate Deployment

## Tasks
1. Review pre-deployment checklist
2. Back up production database
3. Deploy to production via CI/CD
4. Run smoke tests:
   - Test authentication
   - Test CRUD operations
   - Test file uploads
   - Test notifications
   - Test all major workflows
5. Monitor Application Insights for errors
6. Monitor Azure resource health
7. Verify performance is acceptable
8. Check logs for any issues
9. Document deployment
10. Notify stakeholders of successful deployment
11. Create post-deployment report

## Estimated Effort
1 day

## Acceptance Criteria
- Application deployed to production
- All smoke tests pass
- No critical errors in logs
- Performance is acceptable
- Monitoring shows healthy status
- Documentation complete
- Stakeholders notified

EOF

gh issue create \
  --title "Production Deployment and Smoke Tests" \
  --body-file /tmp/issue-body-43.md \
  --label "phase-4,testing,high,1-2-days"


# Issue 44: Monitor Production and Address Issues
# File: tasks/post-migration/01-monitor-and-tune.md
# Phase: post-migration
cat > /tmp/issue-body-44.md << 'EOF'
# Task: Monitor Production and Address Issues

## Phase
Post-Migration (Week 12-13)

## Description
Monitor production environment, address any deployment issues, and tune performance based on real traffic.

## Objectives
- Monitor production metrics
- Address any issues
- Tune performance
- Train users
- Update documentation

## Dependencies
- Phase 4: Task 05 - Production Deployment and Smoke Tests

## Tasks
1. Monitor Application Insights daily
2. Review error logs and exceptions
3. Monitor Azure resource utilization
4. Address any bugs or issues
5. Tune database performance
6. Optimize slow queries
7. Adjust scaling rules if needed
8. Conduct user training sessions
9. Update user documentation
10. Gather user feedback
11. Create post-migration report

## Estimated Effort
1-2 weeks

## Acceptance Criteria
- No critical issues in production
- Performance is acceptable
- Users are trained
- Documentation is updated
- Feedback collected
- Post-migration report created

EOF

gh issue create \
  --title "Monitor Production and Address Issues" \
  --body-file /tmp/issue-body-44.md \
  --label "post-migration,enhancement,medium,2-weeks"


# Issue 45: Implement Caching Strategy
# File: tasks/post-migration/02-implement-caching.md
# Phase: post-migration
cat > /tmp/issue-body-45.md << 'EOF'
# Task: Implement Caching Strategy

## Phase
Post-Migration (Month 2-3)

## Description
Implement caching strategy using Azure Cache for Redis to improve performance.

## Objectives
- Create Azure Cache for Redis
- Implement caching in application
- Cache frequently accessed data
- Configure cache invalidation
- Measure performance improvements

## Dependencies
- Post-Migration: Task 01 - Monitor Production and Address Issues

## Tasks
1. Create Azure Cache for Redis (Basic tier)
2. Add Microsoft.Extensions.Caching.StackExchangeRedis package
3. Configure Redis cache in Program.cs
4. Implement distributed caching for:
   - Course listings
   - Department data
   - Frequently accessed lookups
5. Implement cache invalidation on updates
6. Test caching functionality
7. Measure performance improvements
8. Document caching strategy

## Estimated Effort
2-3 days

## Acceptance Criteria
- Redis cache deployed
- Caching implemented
- Cache invalidation works
- Performance improved
- Documentation complete

EOF

gh issue create \
  --title "Implement Caching Strategy" \
  --body-file /tmp/issue-body-45.md \
  --label "post-migration,enhancement,medium,2-3-days"


# Issue 46: Implement Real-Time Notifications with SignalR
# File: tasks/post-migration/03-implement-signalr.md
# Phase: post-migration
cat > /tmp/issue-body-46.md << 'EOF'
# Task: Implement Real-Time Notifications with SignalR

## Phase
Post-Migration (Month 2-3)

## Description
Add real-time notification delivery using SignalR, replacing the polling mechanism.

## Objectives
- Add SignalR to application
- Create notification hub
- Update UI for real-time updates
- Test real-time delivery
- Remove polling mechanism

## Dependencies
- Post-Migration: Task 02 - Implement Caching Strategy

## Tasks
1. Add Microsoft.AspNetCore.SignalR package
2. Create NotificationHub
3. Configure SignalR in Program.cs
4. Update NotificationService to broadcast via SignalR
5. Update JavaScript client to use SignalR
6. Remove polling mechanism
7. Test real-time notifications
8. Handle reconnection scenarios
9. Document SignalR implementation

## Estimated Effort
2-3 days

## Acceptance Criteria
- SignalR configured
- Notifications delivered in real-time
- UI updates without polling
- Reconnection works
- Documentation complete

EOF

gh issue create \
  --title "Implement Real-Time Notifications with SignalR" \
  --body-file /tmp/issue-body-46.md \
  --label "post-migration,enhancement,medium,2-3-days"


# Issue 47: Set Up Disaster Recovery Plan
# File: tasks/post-migration/04-disaster-recovery.md
# Phase: post-migration
cat > /tmp/issue-body-47.md << 'EOF'
# Task: Set Up Disaster Recovery Plan

## Phase
Post-Migration (Month 2-3)

## Description
Implement comprehensive disaster recovery plan with backups, geo-redundancy, and recovery procedures.

## Objectives
- Configure automated backups
- Set up geo-redundancy
- Document recovery procedures
- Test recovery process
- Create runbooks

## Dependencies
- Post-Migration: Task 03 - Implement Real-Time Notifications with SignalR

## Tasks
1. Configure Azure SQL Database backup retention
2. Test point-in-time restore
3. Configure geo-replication for production database
4. Set up blob storage geo-redundancy
5. Document RTO and RPO requirements
6. Create disaster recovery runbook
7. Test failover procedures
8. Schedule regular DR drills
9. Document lessons learned
10. Update documentation

## Estimated Effort
3-5 days

## Acceptance Criteria
- Backups configured and tested
- Geo-redundancy enabled
- Recovery procedures documented
- Failover tested successfully
- DR runbook created
- Team trained on DR procedures

EOF

gh issue create \
  --title "Set Up Disaster Recovery Plan" \
  --body-file /tmp/issue-body-47.md \
  --label "post-migration,setup,medium,1-week"



echo ""
echo "Successfully created 47 issues!"
echo "View them at: gh issue list"
