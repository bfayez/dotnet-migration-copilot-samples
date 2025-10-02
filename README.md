# DotNet Migration Copilot Samples

## Samples:

- [ContosoUniversity](https://github.com/Azure-Samples/dotnet-migration-copilot-samples/tree/main/ContosoUniversity): This is a university management application built on .NET Framework 4.8 with traditional Windows infrastructure dependencies and runs on on-premises Windows-based hosting. After migration, the app will run on Azure Container Apps and leverage Azure SQL Database for data persistence, Azure Service Bus for reliable messaging and notifications, and Azure Blob Storage for teaching material file uploads, replacing the current MSMQ and local file system dependencies with cloud-native Azure services.

## Migration Planning

This repository includes a comprehensive migration plan with **47 detailed tasks** organized into **6 phases**:

- **Phase 0**: Assessment and Planning (2 weeks, 6 tasks)
- **Phase 1**: Foundation - Core Migration (4 weeks, 13 tasks)
- **Phase 2**: Azure Services Integration (3 weeks, 12 tasks)
- **Phase 3**: Testing and Quality (2 weeks, 7 tasks)
- **Phase 4**: Deployment and Cutover (1 week, 5 tasks)
- **Post-Migration**: Enhancements (Ongoing, 4 tasks)

### 📋 Creating GitHub Issues from Tasks

To track your migration progress, convert the task files into GitHub Issues:

#### Quick Start
```bash
# 1. Authenticate with GitHub CLI
gh auth login

# 2. Create labels (run once)
./create-labels.sh

# 3. Create all 47 issues
./create-issues.sh
```

#### Alternative Methods
- **GitHub Actions**: Use the "Create Migration Issues" workflow in the Actions tab
- **Manual**: Follow the [Issue Creation Guide](./ISSUE_CREATION_GUIDE.md)

### 📚 Documentation

- [Migration Plan](./MigrationWithModernization.md) - Complete migration strategy and architecture
- [Tasks Directory](./tasks/) - 47 detailed task files organized by phase
- [Issue Creation Guide](./ISSUE_CREATION_GUIDE.md) - Comprehensive guide for creating issues
- [Issues Summary](./ISSUES_SUMMARY.md) - Overview of all migration issues

### 🎯 Getting Started

1. **Review the migration plan**: Read [MigrationWithModernization.md](./MigrationWithModernization.md)
2. **Explore the tasks**: Browse the [tasks/](./tasks/) directory to understand the work
3. **Create issues**: Use the scripts to create trackable GitHub Issues
4. **Start migrating**: Begin with Phase 0 tasks
