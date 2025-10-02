# ContosoUniversity Migration Tasks

This directory contains detailed task descriptions for implementing the migration plan outlined in `MigrationWithModernization.md`. Each task is structured to be converted into GitHub Issues when ready.

## Directory Structure

The tasks are organized by migration phase, with each phase representing a logical grouping of related work:

```
tasks/
├── phase-0-assessment-planning/     # 2 weeks - Setup and preparation
├── phase-1-foundation/              # 4 weeks - Core .NET 9 migration
├── phase-2-azure-integration/       # 3 weeks - Azure services integration
├── phase-3-testing-quality/         # 2 weeks - Testing and hardening
├── phase-4-deployment/              # 1 week - Deployment and cutover
└── post-migration/                  # Ongoing - Enhancements and optimization
```

## Task Dependencies

Each task file documents its dependencies on other tasks. The general flow is:

1. **Phase 0** must be completed before Phase 1
2. **Phase 1** tasks have internal dependencies (project setup → controllers → views → data layer)
3. **Phase 2** depends on Phase 1 completion
4. **Phase 3** depends on Phase 2 completion
5. **Phase 4** depends on Phase 3 completion
6. **Post-Migration** tasks can be done after Phase 4

## Phase 0: Assessment and Planning (2 weeks)

Foundation work before code migration begins.

| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 01 | Application Inventory and Dependency Analysis | 2 days | None |
| 02 | Set Up Azure Subscription and Resource Groups | 2 days | Task 01 |
| 03 | Team Kickoff, Tools Setup, and Access Provisioning | 1 day | Task 02 |
| 04 | Create Azure Resources (SQL, Service Bus, Storage) | 2 days | Task 02, 03 |
| 05 | Set Up GitHub Repository, Branching Strategy, CI/CD Skeleton | 2 days | Task 03, 04 |
| 06 | Sprint Planning for Phase 1 | 1 day | All Phase 0 |

**Total**: ~2 weeks

## Phase 1: Foundation - Core Migration (4 weeks)

Migrate from .NET Framework 4.8 to .NET 9 with ASP.NET Core.

### Week 1: Project Structure
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 01 | Create .NET 9 Project Structure | 1-2 days | Phase 0 complete |
| 02 | Migrate packages.config to PackageReference | 1-2 days | Task 01 |
| 03 | Create Program.cs and Startup Configuration | 1-2 days | Task 02 |
| 04 | Convert Web.config to appsettings.json | 1-2 days | Task 03 |
| 05 | Set Up Dependency Injection Container | 1 day | Task 04 |

### Week 2: Controllers
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 06 | Migrate Controllers to ASP.NET Core MVC | 3-4 days | Task 05 |
| 07 | Update Routing to ASP.NET Core Conventions | 1 day | Task 06 |

### Week 3: Views and Static Files
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 08 | Migrate Razor Views to ASP.NET Core | 3-4 days | Task 06, 07 |
| 09 | Move Static Files to wwwroot | 1 day | Task 08 |

### Week 4: Data Layer
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 10 | Update Entity Framework Core to Version 9 | 1-2 days | Task 05 |
| 11 | Update DbContext for DI and Remove Static Factory | 1 day | Task 10 |
| 12 | Create and Apply EF Core Migrations | 1 day | Task 11 |
| 13 | Convert Synchronous Operations to Async/Await | 2-3 days | Task 12 |

**Total**: ~4 weeks

## Phase 2: Azure Services Integration (3 weeks)

Replace Windows-specific services with Azure services.

### Week 1: Database Migration
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 01 | Export Schema and Data from LocalDB | 1 day | Phase 1 complete |
| 02 | Create Azure SQL Database | 1 day | Task 01 |
| 03 | Run Database Migrations on Azure SQL | 1 day | Task 02 |
| 04 | Update Connection String and Test Connectivity | 1 day | Task 03 |

### Week 2: Messaging and Storage
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 05 | Create Azure Service Bus Namespace and Queue | 1 day | Task 04 |
| 06 | Update NotificationService to Use Azure Service Bus | 2-3 days | Task 05 |
| 07 | Create Azure Blob Storage Account and Container | 1 day | Task 06 |
| 08 | Update File Upload to Use Azure Blob Storage | 2-3 days | Task 07 |

### Week 3: Authentication and Security
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 09 | Set Up Azure AD B2C Tenant | 1-2 days | Task 08 |
| 10 | Implement Azure AD B2C Authentication | 2-3 days | Task 09 |
| 11 | Set Up Azure Key Vault and Move Secrets | 1-2 days | Task 10 |
| 12 | Test All Azure Services Integration | 2-3 days | Task 11 |

**Total**: ~3 weeks

## Phase 3: Testing and Quality (2 weeks)

Implement comprehensive testing and quality measures.

### Week 1: Testing
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 01 | Set Up Test Projects | 1-2 days | Phase 2 complete |
| 02 | Write Unit Tests for Controllers and Services | 3-4 days | Task 01 |
| 03 | Write Integration Tests | 2-3 days | Task 02 |

### Week 2: Monitoring and Quality
| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 04 | Set Up Application Insights | 1-2 days | Task 03 |
| 05 | Implement Structured Logging with Serilog | 1-2 days | Task 04 |
| 06 | Add Health Checks and Security Hardening | 2-3 days | Task 05 |
| 07 | Performance Testing and Optimization | 2-3 days | Task 06 |

**Total**: ~2 weeks

## Phase 4: Deployment and Cutover (1 week)

Containerize and deploy to Azure Container Apps.

| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 01 | Create Dockerfile and Test Container Locally | 1 day | Phase 3 complete |
| 02 | Push Container to Azure Container Registry | 0.5 day | Task 01 |
| 03 | Create Azure Container Apps Environment and Deploy | 1-2 days | Task 02 |
| 04 | Complete CI/CD Pipeline and Automate Deployment | 1 day | Task 03 |
| 05 | Production Deployment and Smoke Tests | 1 day | Task 04 |

**Total**: ~1 week

## Post-Migration Tasks (Ongoing)

Optional enhancements after successful migration.

| Task | File | Estimated Effort | Dependencies |
|------|------|------------------|--------------|
| 01 | Monitor Production and Address Issues | 1-2 weeks | Phase 4 complete |
| 02 | Implement Caching Strategy | 2-3 days | Task 01 |
| 03 | Implement Real-Time Notifications with SignalR | 2-3 days | Task 02 |
| 04 | Set Up Disaster Recovery Plan | 3-5 days | Task 03 |

## Task File Format

Each task file follows a consistent structure:

- **Phase**: Which migration phase this task belongs to
- **Description**: Brief overview of the task
- **Objectives**: What the task aims to achieve
- **Prerequisites**: What needs to be in place before starting
- **Dependencies**: Which other tasks must be completed first
- **Tasks**: Detailed checklist of work items
- **Deliverables**: Concrete outputs expected
- **Acceptance Criteria**: How to verify the task is complete
- **Estimated Effort**: Time estimate for completion
- **Notes**: Additional guidance, tips, or warnings

## How to Use These Tasks

### For Issue Creation

When ready to start work, convert these task files into GitHub Issues:

1. **Create an issue** for each task file
2. **Use the task file name** as the issue title
3. **Copy the task content** into the issue description
4. **Add labels** for phase, effort estimate, and type
5. **Link dependencies** using GitHub issue references
6. **Assign** to appropriate team member(s)
7. **Add to project board** for tracking

### Example Issue Labels

- Phase labels: `phase-0`, `phase-1`, `phase-2`, `phase-3`, `phase-4`, `post-migration`
- Effort labels: `1-day`, `2-3-days`, `1-week`, `2-weeks`
- Type labels: `setup`, `migration`, `azure`, `testing`, `deployment`, `enhancement`
- Priority labels: `critical`, `high`, `medium`, `low`

### Tracking Progress

1. Use GitHub Projects to create a Kanban board
2. Organize issues by phase
3. Track dependencies using issue links
4. Update progress in daily standups
5. Review completed work in sprint reviews

## Timeline Summary

| Phase | Duration | Description |
|-------|----------|-------------|
| Phase 0 | 2 weeks | Assessment and Planning |
| Phase 1 | 4 weeks | Core .NET 9 Migration |
| Phase 2 | 3 weeks | Azure Services Integration |
| Phase 3 | 2 weeks | Testing and Quality |
| Phase 4 | 1 week | Deployment and Cutover |
| **Total** | **12 weeks** | **Complete migration** |
| Post-Migration | Ongoing | Enhancements and optimization |

## Key Milestones

- **Week 2**: Phase 0 complete - Ready to start coding
- **Week 6**: Phase 1 complete - Application runs on .NET 9
- **Week 9**: Phase 2 complete - All Azure services integrated
- **Week 11**: Phase 3 complete - Testing and quality complete
- **Week 12**: Phase 4 complete - Production deployment

## Success Criteria

The migration is considered successful when:

- ✅ Application runs on .NET 9
- ✅ All features functional on Azure
- ✅ 70%+ code coverage with tests
- ✅ No Windows-specific dependencies remain
- ✅ All Azure services integrated
- ✅ CI/CD pipeline fully functional
- ✅ Production deployment successful
- ✅ Performance benchmarks met
- ✅ Security requirements satisfied
- ✅ Documentation complete

## Related Documents

- **Migration Plan**: `/MigrationWithModernization.md` - Complete migration strategy
- **README**: `/README.md` - Repository overview
- **Application README**: `/ContosoUniversity/README.md` - Application documentation

## Questions or Issues?

If you have questions about any task or encounter issues during migration:

1. Review the task dependencies to ensure prerequisites are met
2. Consult the main migration plan (`MigrationWithModernization.md`)
3. Check Azure documentation for service-specific guidance
4. Raise questions in team discussions or standups
5. Update task documentation with lessons learned

---

**Document Version**: 1.0  
**Created**: 2024  
**Last Updated**: 2024
