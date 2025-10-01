# ContosoUniversity - .NET 9 Migration and Azure Modernization Plan

## Executive Summary

This document provides a comprehensive migration plan for transforming the ContosoUniversity application from a legacy .NET Framework 4.8 ASP.NET MVC 5 application into a modern .NET 9 application hosted on Azure. The plan addresses technical requirements, Azure service recommendations, agility attributes, and implementation strategy.

**Current State:**
- Framework: .NET Framework 4.8
- Web Framework: ASP.NET MVC 5
- Data Access: Entity Framework Core 3.1.32 (on .NET Framework)
- Database: SQL Server LocalDB
- Messaging: Microsoft Message Queuing (MSMQ)
- File Storage: Local file system
- Hosting: IIS Express / IIS on Windows

**Target State:**
- Framework: .NET 9
- Web Framework: ASP.NET Core MVC
- Data Access: Entity Framework Core 9
- Database: Azure SQL Database
- Messaging: Azure Service Bus
- File Storage: Azure Blob Storage
- Hosting: Azure Container Apps

---

## Table of Contents

1. [Application Analysis](#1-application-analysis)
2. [Migration Requirements for .NET 9](#2-migration-requirements-for-net-9)
3. [Azure Modernization Strategy](#3-azure-modernization-strategy)
4. [Agility Attributes Analysis](#4-agility-attributes-analysis)
5. [Issues and Solutions](#5-issues-and-solutions)
6. [Migration Plan](#6-migration-plan)
7. [Cost Considerations](#7-cost-considerations)
8. [Risks and Mitigation](#8-risks-and-mitigation)

---

## 1. Application Analysis

### 1.1 Current Application Structure

**ContosoUniversity** is a university management system with the following components:

#### Core Features:
- **Student Management**: CRUD operations with pagination and search
- **Course Management**: Course creation, editing, with teaching material image uploads
- **Instructor Management**: Instructor assignments and office locations
- **Department Management**: Department administration
- **Notification System**: Real-time notifications using MSMQ
- **File Upload System**: Teaching material image uploads stored locally

#### Technology Stack:
- **Framework**: .NET Framework 4.8
- **Web**: ASP.NET MVC 5.2.9
- **ORM**: Entity Framework Core 3.1.32 (hybrid approach on .NET Framework)
- **Database**: SQL Server LocalDB (development)
- **Message Queue**: MSMQ (System.Messaging)
- **File Storage**: Local file system (`/Uploads/TeachingMaterials/`)
- **UI**: Bootstrap 5.3.3, jQuery 3.7.1
- **Authentication**: Windows Authentication (IIS-based)

#### Key Dependencies:
- ASP.NET MVC 5 (Windows-only)
- System.Messaging (MSMQ - Windows-only)
- System.Web namespace (IIS-specific)
- Web.config configuration
- IIS-specific features (Windows Authentication)

### 1.2 Application Architecture

```
ContosoUniversity/
├── Controllers/         # MVC Controllers (BaseController, Students, Courses, etc.)
├── Models/              # Domain models (Student, Course, Instructor, Department)
├── Views/               # Razor views (.cshtml)
├── Data/                # EF Core DbContext and initializer
├── Services/            # Business logic (NotificationService)
├── Content/             # CSS files
├── Scripts/             # JavaScript files
├── Uploads/             # Local file storage for teaching materials
└── Web.config           # Configuration file
```

**Key Patterns:**
- MVC pattern with separation of concerns
- Repository-like pattern through DbContext
- Service layer for notifications
- Table-per-Hierarchy (TPH) inheritance for Person/Student/Instructor

---

## 2. Migration Requirements for .NET 9

### 2.1 Framework Migration

#### 2.1.1 Convert from .NET Framework 4.8 to .NET 9

**What Needs to Change:**

1. **Project File Format**
   - Convert from .csproj (old format) to SDK-style project
   - Change from `ToolsVersion="15.0"` to `<TargetFramework>net9.0</TargetFramework>`
   - Replace `packages.config` with PackageReference format

2. **ASP.NET MVC 5 to ASP.NET Core MVC**
   - Replace `System.Web.Mvc` with `Microsoft.AspNetCore.Mvc`
   - Convert controllers to use ASP.NET Core patterns
   - Update routing from `RouteConfig.cs` to ASP.NET Core routing
   - Replace `ActionResult` with `IActionResult`
   - Update model binding and validation

3. **Configuration System**
   - Migrate from `Web.config` to `appsettings.json`
   - Convert `<appSettings>` and `<connectionStrings>` sections
   - Implement `IConfiguration` dependency injection
   - Replace `ConfigurationManager` with `IConfiguration`

4. **Dependency Injection**
   - Implement built-in DI container instead of manual instantiation
   - Convert `BaseController` pattern to use constructor injection
   - Register services in `Program.cs`

5. **Middleware Pipeline**
   - Replace `Global.asax` with middleware pipeline in `Program.cs`
   - Configure routing, authentication, error handling as middleware
   - Remove `System.Web` dependencies

6. **Static Files and Content**
   - Move `Content/` and `Scripts/` to `wwwroot/`
   - Update bundling and minification (use WebOptimizer or built-in features)
   - Update references in views

### 2.2 Entity Framework Core Migration

**Current State**: EF Core 3.1.32 on .NET Framework
**Target State**: EF Core 9 on .NET 9

**Changes Required:**

1. **Update Package References**
   ```xml
   Microsoft.EntityFrameworkCore (3.1.32 → 9.0.x)
   Microsoft.EntityFrameworkCore.SqlServer (3.1.32 → 9.0.x)
   Microsoft.EntityFrameworkCore.Tools (3.1.32 → 9.0.x)
   ```

2. **DbContext Factory Pattern**
   - Remove `SchoolContextFactory.Create()` static pattern
   - Use proper DI with `IDbContextFactory<SchoolContext>` or direct injection

3. **Query Updates**
   - Review LINQ queries for breaking changes in EF Core 9
   - Update any deprecated APIs
   - Optimize for new performance features

4. **DateTime Handling**
   - EF Core 9 has improved datetime2 support
   - Current configuration should work but verify timezone handling

### 2.3 View Engine

**Razor Views**: Mostly compatible but need updates:

1. **Helper Changes**
   - Replace `Html.BeginForm()` with tag helpers
   - Update `@model` declarations if needed
   - Replace validation helpers with tag helpers
   - Update `@section Scripts` patterns

2. **Layout Changes**
   - Update `_Layout.cshtml` for ASP.NET Core
   - Remove `@Styles.Render()` and `@Scripts.Render()` (use link tags)
   - Update menu/navigation for new routing

3. **View Components**
   - Consider converting complex partial views to View Components
   - Improve reusability and testability

---

## 3. Azure Modernization Strategy

### 3.1 Hosting: Azure Container Apps

**Recommendation**: Azure Container Apps

**Why Azure Container Apps:**
- **Serverless container hosting**: Pay only for what you use
- **Auto-scaling**: Automatically scales based on HTTP traffic, CPU, memory, or custom metrics
- **Microservices ready**: Supports microservices architecture for future expansion
- **Built-in load balancing**: No additional configuration needed
- **HTTPS/TLS**: Automatic certificate management
- **Zero infrastructure management**: No VM or cluster maintenance
- **Integrated with Azure services**: Native integration with Service Bus, Blob Storage, SQL
- **CI/CD friendly**: Easy integration with GitHub Actions or Azure DevOps
- **Cost-effective**: Cheaper than App Service for workloads with variable traffic

**Alternative Options Comparison:**

| Service | Pros | Cons | Best For | Est. Monthly Cost |
|---------|------|------|----------|-------------------|
| **Azure Container Apps** | Serverless, auto-scale, modern, flexible | Relatively new service | Modern apps, variable traffic | $20-$100 |
| Azure App Service | Mature, easy to use, PaaS | Less flexible, higher baseline cost | Traditional web apps | $50-$200 |
| Azure Kubernetes Service (AKS) | Full control, enterprise features | Complex, requires K8s expertise | Large-scale, complex apps | $200-$1000+ |
| Azure Container Instances | Simplest container option | No auto-scale, limited features | Simple containers | $30-$100 |
| Azure Functions | True serverless, event-driven | Not suitable for full web apps | Event processing | $5-$50 |

**Decision**: Azure Container Apps provides the best balance of simplicity, cost, and modern features for this application.

### 3.2 Database: Azure SQL Database

**Recommendation**: Azure SQL Database (Serverless tier for dev/test, Provisioned for production)

**Why Azure SQL Database:**
- **Fully managed**: No maintenance, automatic backups, patching
- **High availability**: 99.99% SLA with built-in redundancy
- **Elastic scaling**: Scale up/down based on demand
- **Advanced security**: Built-in threat detection, encryption at rest and in transit
- **Cost-effective**: Serverless tier for development, pay per use
- **Point-in-time restore**: Automatic backups with 7-35 days retention
- **Intelligent performance**: Automatic tuning and query optimization
- **Compatible**: Minimal code changes from SQL Server

**Alternative Options Comparison:**

| Service | Pros | Cons | Best For | Est. Monthly Cost |
|---------|------|------|----------|-------------------|
| **Azure SQL Database** | Managed, scalable, feature-rich | Higher cost than basic options | Production apps, compatibility | $5-$500+ |
| Azure SQL Managed Instance | Full SQL Server compatibility | More expensive | Legacy apps with advanced features | $700-$3000+ |
| Azure Database for PostgreSQL | Open source, cost-effective | Requires code changes | New apps, OSS preference | $20-$300 |
| Azure Cosmos DB | Global distribution, multi-model | Expensive, learning curve | Globally distributed apps | $25-$1000+ |
| SQL Server on VMs | Full control | Self-managed, more work | Lift-and-shift | $100-$500+ |

**Decision**: Azure SQL Database Serverless for dev/test ($5-$40/month), Standard tier for production provides the best value and compatibility.

**Migration Path:**
- Use SQL Server Data Migration Assistant (DMA) for assessment
- Export schema and data from LocalDB
- Import to Azure SQL Database
- Update connection string in `appsettings.json`

### 3.3 Messaging: Azure Service Bus

**Recommendation**: Azure Service Bus (Standard tier)

**Why Azure Service Bus:**
- **Enterprise messaging**: Reliable, high-throughput message queuing
- **Cross-platform**: Works on any OS (replaces Windows-only MSMQ)
- **FIFO guarantee**: Messages processed in order
- **Dead-letter queue**: Automatic handling of failed messages
- **Duplicate detection**: Prevents message duplication
- **Sessions**: Support for message sessions if needed
- **Monitoring**: Built-in metrics and alerts
- **Scalable**: Handles millions of messages
- **SDK support**: Native .NET SDK with async/await patterns

**Alternative Options Comparison:**

| Service | Pros | Cons | Best For | Est. Monthly Cost |
|---------|------|------|----------|-------------------|
| **Azure Service Bus** | Enterprise features, reliable | More expensive than Storage Queue | Critical business messaging | $10-$100 |
| Azure Storage Queue | Very cheap, simple | Limited features, no FIFO | Simple queuing | $1-$10 |
| Azure Event Grid | Event-driven, real-time | Different paradigm | Event broadcasting | $1-$50 |
| Azure Event Hubs | High throughput, streaming | Overkill for simple messaging | IoT, telemetry | $10-$500 |
| SignalR Service | Real-time push | Not a queue, different use case | Real-time notifications | $5-$50 |

**Decision**: Azure Service Bus Standard tier provides enterprise-grade messaging with the features needed to replace MSMQ.

**Migration Path:**
- Replace `System.Messaging` with `Azure.Messaging.ServiceBus`
- Update `NotificationService` to use Service Bus SDK
- Configure connection string in `appsettings.json`
- Implement retry policies and error handling
- Consider adding SignalR for real-time UI updates (optional enhancement)

### 3.4 File Storage: Azure Blob Storage

**Recommendation**: Azure Blob Storage (Hot tier)

**Why Azure Blob Storage:**
- **Scalable**: Unlimited storage capacity
- **Durable**: 99.999999999% (11 nines) durability
- **Cost-effective**: Pay only for what you use
- **CDN integration**: Can serve files through Azure CDN for global performance
- **Access tiers**: Hot, Cool, Archive for cost optimization
- **Security**: Encryption at rest, SAS tokens for secure access
- **Redundancy**: Multiple redundancy options (LRS, GRS, ZRS)
- **SDK support**: Rich .NET SDK with streaming support
- **Static website hosting**: Can host static content directly

**Alternative Options Comparison:**

| Service | Pros | Cons | Best For | Est. Monthly Cost |
|---------|------|------|----------|-------------------|
| **Azure Blob Storage** | Scalable, cheap, feature-rich | N/A | File storage, images | $1-$50 |
| Azure Files | SMB protocol, mountable | More expensive, slower | File shares | $5-$100 |
| Azure Data Lake Storage | Big data analytics | Overkill, expensive | Analytics workloads | $20-$500 |
| Container storage | Built into container | Limited capacity, lost on restart | Temporary files | Included |

**Decision**: Azure Blob Storage Hot tier is the clear winner for storing teaching material images.

**Migration Path:**
- Replace local file system writes with Blob Storage SDK
- Update `CoursesController` to use `BlobContainerClient`
- Store blob URLs in database instead of file paths
- Implement SAS tokens for secure file access
- Consider adding Azure CDN for better performance (optional)

### 3.5 Authentication and Authorization

**Current State**: Windows Authentication (IIS-based)
**Recommendation**: Azure Active Directory (Entra ID) with ASP.NET Core Identity

**Why Azure AD (Entra ID):**
- **Modern authentication**: OAuth 2.0, OpenID Connect
- **Cross-platform**: Works on any OS
- **MFA support**: Built-in multi-factor authentication
- **Conditional access**: Policy-based access control
- **SSO**: Single sign-on across Azure services
- **Managed identities**: Secure service-to-service authentication

**Alternative Options Comparison:**

| Service | Pros | Cons | Best For | Est. Monthly Cost |
|---------|------|------|----------|-------------------|
| **Azure AD (Entra ID)** | Enterprise features, integration | Learning curve | Enterprise apps | Free-$6/user |
| ASP.NET Core Identity | Simple, local | No SSO, more maintenance | Small apps, local auth | Free |
| Azure AD B2C | Consumer scenarios | More complex | Public-facing apps | $0-$20 |
| Third-party (Auth0) | Feature-rich | External dependency, cost | Any | $13-$240 |

**Decision**: Use Azure AD B2C for authentication (free tier supports up to 50,000 users) with ASP.NET Core Identity as a backup option.

**Migration Path:**
- Remove Windows Authentication
- Implement Azure AD B2C authentication
- Convert role-based authorization to claims-based
- Update controllers with `[Authorize]` attributes
- Store user profiles in Azure SQL Database

### 3.6 Monitoring and Diagnostics

**Recommendation**: Azure Application Insights

**Why Application Insights:**
- **Full observability**: Logs, metrics, traces, exceptions
- **Performance monitoring**: Request/dependency tracking
- **Live metrics**: Real-time application health
- **Distributed tracing**: End-to-end transaction tracking
- **Alerting**: Proactive alerts on issues
- **Integration**: Works seamlessly with ASP.NET Core
- **Cost-effective**: First 5GB per month free

**Configuration Needed:**
- Add Application Insights SDK
- Configure instrumentation key in `appsettings.json`
- Enable automatic telemetry collection
- Set up custom metrics for business KPIs

### 3.7 CI/CD Pipeline

**Recommendation**: GitHub Actions (since repo is on GitHub)

**Pipeline Stages:**
1. **Build**: .NET 9 SDK, restore packages, build solution
2. **Test**: Run unit and integration tests
3. **Container Build**: Docker build for Container Apps
4. **Security Scan**: Container vulnerability scanning
5. **Deploy to Dev**: Automatic deployment to dev environment
6. **Deploy to Production**: Manual approval for production

**Required Workflows:**
- `.github/workflows/build.yml`: Build and test
- `.github/workflows/deploy.yml`: Deploy to Azure
- `.github/workflows/pr-validation.yml`: PR checks

---

## 4. Agility Attributes Analysis

### 4.1 Debuggability

**Current State (Score: 5/10)**:
- Limited logging (Debug.WriteLine only)
- No structured logging
- No distributed tracing
- Exception handling is basic
- No production debugging capabilities

**Target State (Score: 9/10)**:
- **Application Insights**: Full telemetry, distributed tracing
- **Structured logging**: Using Microsoft.Extensions.Logging with Serilog
- **Log correlation**: Request ID tracking across all services
- **Exception telemetry**: Automatic exception tracking with stack traces
- **Live debugging**: Snapshot debugger in Application Insights
- **Health checks**: Built-in health check endpoints

**Improvements:**
```csharp
// Current
Debug.WriteLine($"Failed to send notification: {ex.Message}");

// Target
_logger.LogError(ex, "Failed to send notification for {EntityType} {EntityId}", 
    entityType, entityId);
```

**Impact**: Reduced troubleshooting time from hours to minutes in production.

### 4.2 Extensibility

**Current State (Score: 6/10)**:
- Tight coupling to MSMQ and local file system
- Limited abstraction layers
- Hard to add new features without modifying existing code
- No plugin architecture

**Target State (Score: 9/10)**:
- **Dependency Injection**: All dependencies injected, easy to replace
- **Interface-based design**: Abstract dependencies behind interfaces
- **Cloud-agnostic**: Can switch between Azure, AWS, or on-premises with configuration
- **Feature flags**: Azure App Configuration for feature toggles
- **Modular architecture**: Can extract services to separate microservices if needed

**Improvements:**
```csharp
// Current
public class NotificationService
{
    private readonly MessageQueue _queue;
    // Tightly coupled to MSMQ
}

// Target
public interface INotificationService
{
    Task SendNotificationAsync(Notification notification);
}

public class ServiceBusNotificationService : INotificationService
{
    private readonly ServiceBusClient _client;
    // Can be replaced with SignalR, Event Grid, etc.
}
```

**Impact**: New features can be added with minimal changes to existing code. Easy to A/B test new implementations.

### 4.3 Portability

**Current State (Score: 2/10)**:
- **Windows-only**: Requires Windows for MSMQ, IIS, Windows Authentication
- **IIS-dependent**: Cannot run on Linux or containers (without significant changes)
- **LocalDB**: Development database is Windows-only

**Target State (Score: 10/10)**:
- **Cross-platform**: Runs on Windows, Linux, macOS
- **Container-ready**: Dockerfile for consistent deployment
- **Cloud-agnostic**: Can deploy to any cloud provider
- **No OS-specific dependencies**: All cloud services have cross-platform SDKs

**Improvements:**
- Containerized application runs anywhere
- Development on any OS (Windows, Linux, macOS)
- CI/CD works on any platform
- Can deploy to Azure, AWS, GCP, or on-premises Kubernetes

**Impact**: Development team flexibility, reduced infrastructure lock-in, global deployment options.

### 4.4 Scalability

**Current State (Score: 3/10)**:
- **Single server**: Can only scale vertically (bigger VM)
- **MSMQ limitations**: Single server message queue
- **File system storage**: Not suitable for multiple servers
- **No load balancing**: Session affinity required
- **LocalDB**: Not suitable for production scale

**Target State (Score: 9/10)**:
- **Horizontal scaling**: Azure Container Apps auto-scales based on load
- **Stateless**: No server affinity required
- **Distributed storage**: Blob Storage and Service Bus support unlimited scale
- **Database scalability**: Azure SQL Database can scale to thousands of DTUs
- **Global distribution**: Can deploy to multiple regions with Traffic Manager

**Scalability Metrics:**

| Metric | Current | Target | Improvement |
|--------|---------|--------|-------------|
| Concurrent users | 10-50 | 1,000-10,000+ | 100-200x |
| Requests/second | 10 | 1,000+ | 100x |
| Storage capacity | Limited by disk | Unlimited | ∞ |
| Database connections | 100 | 1,000+ | 10x |
| Deployment time | 15-30 min | 2-5 min | 5x faster |

**Impact**: Application can handle growth without architecture changes. Auto-scaling reduces costs during low traffic periods.

### 4.5 Securability

**Current State (Score: 4/10)**:
- **Windows Authentication**: Works but not modern, no MFA
- **No secrets management**: Connection strings in Web.config
- **No encryption in transit**: HTTP endpoints possible
- **Limited access control**: Basic role-based authorization
- **No audit logging**: No tracking of who did what

**Target State (Score: 9/10)**:
- **Modern authentication**: Azure AD with MFA, Conditional Access
- **Secrets management**: Azure Key Vault for all secrets
- **Encryption**: TLS 1.3 for all communications
- **Managed identities**: No credentials in code or configuration
- **RBAC**: Fine-grained role-based access control
- **Audit logging**: Complete audit trail in Application Insights
- **Security scanning**: Automated vulnerability scanning in CI/CD
- **Compliance**: Built-in compliance tools (Azure Policy, Azure Security Center)

**Security Improvements:**
```csharp
// Current - Connection string in Web.config (insecure)
<add name="DefaultConnection" connectionString="Server=..." />

// Target - Managed Identity with Key Vault
builder.Services.AddDbContext<SchoolContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection")
    )
);
// Connection string retrieved from Key Vault using Managed Identity
```

**Compliance Support:**
- GDPR-ready with data residency options
- HIPAA compliance available (Business Associate Agreement)
- SOC 2, ISO 27001 certified infrastructure
- Built-in threat detection and response

**Impact**: Enterprise-grade security, reduced risk of data breaches, compliance certification-ready.

### 4.6 Testability

**Current State (Score: 4/10)**:
- **No unit tests**: No test project in solution
- **Hard to test**: Tight coupling makes unit testing difficult
- **Manual testing**: Requires running full application
- **No mocking**: Dependencies not abstracted
- **No integration tests**: Database tests require full setup

**Target State (Score: 9/10)**:
- **Unit testable**: All dependencies injected and mockable
- **Integration tests**: In-memory database for fast tests
- **End-to-end tests**: Automated UI tests with Playwright/Selenium
- **Test isolation**: Each test runs independently
- **Continuous testing**: Automated test execution in CI/CD
- **Code coverage**: 70%+ code coverage target

**Testing Structure:**
```
ContosoUniversity.Tests/
├── Unit/
│   ├── Controllers/
│   ├── Services/
│   └── Models/
├── Integration/
│   ├── Data/
│   └── Services/
└── E2E/
    └── Scenarios/
```

**Testing Improvements:**
```csharp
// Current - Hard to test
public class StudentsController : BaseController
{
    // db created in base constructor, can't mock
}

// Target - Easy to test
public class StudentsController : Controller
{
    private readonly ISchoolContext _context;
    private readonly INotificationService _notifications;
    
    public StudentsController(ISchoolContext context, INotificationService notifications)
    {
        _context = context;
        _notifications = notifications;
    }
}

// Test
[Fact]
public async Task Create_ValidStudent_SendsNotification()
{
    var mockContext = new Mock<ISchoolContext>();
    var mockNotifications = new Mock<INotificationService>();
    var controller = new StudentsController(mockContext.Object, mockNotifications.Object);
    
    await controller.Create(new Student { /* ... */ });
    
    mockNotifications.Verify(x => x.SendNotificationAsync(It.IsAny<Notification>()), Times.Once);
}
```

**Impact**: Faster development cycles, fewer bugs in production, easier refactoring, better code quality.

### 4.7 Understandability

**Current State (Score: 6/10)**:
- **Good documentation**: README files for features
- **Mixed patterns**: Some modern patterns (EF Core), some legacy (BaseController)
- **Inconsistent**: Mix of async/sync code
- **Limited comments**: Code mostly self-explanatory but some areas need comments

**Target State (Score: 9/10)**:
- **Consistent architecture**: Clear separation of concerns (Controllers, Services, Repositories)
- **Design patterns**: Well-documented use of DI, Repository, Factory patterns
- **API documentation**: OpenAPI/Swagger for API endpoints
- **Architecture diagrams**: C4 model diagrams for system understanding
- **Onboarding guide**: Developer setup guide with troubleshooting
- **Code style**: Consistent code style enforced with EditorConfig and analyzers

**Documentation Improvements:**
- Architecture Decision Records (ADRs) for major decisions
- API documentation with Swagger/OpenAPI
- Sequence diagrams for complex workflows
- Developer onboarding guide
- Deployment runbook

**Code Quality Tools:**
- StyleCop/Roslyn analyzers for consistent code style
- SonarQube/SonarCloud for code quality metrics
- Markdown linting for documentation
- Architecture fitness functions to enforce design rules

**Impact**: Reduced onboarding time for new developers, easier code reviews, better maintainability.

---

## 5. Issues and Solutions

### 5.1 Technical Debt

**Issue 1: Hybrid Architecture - EF Core 3.1 on .NET Framework**
- **Problem**: Using EF Core on .NET Framework is not ideal and limits features
- **Impact**: Performance penalties, missing EF Core 9 features
- **Solution**: Migrate to .NET 9 with EF Core 9 for full feature set
- **Effort**: 3-5 days

**Issue 2: BaseController Anti-pattern**
- **Problem**: Controllers inherit from BaseController which instantiates DbContext in constructor
- **Impact**: Violates dependency injection principles, hard to test
- **Solution**: Use constructor injection for DbContext and services
- **Effort**: 2-3 days

**Issue 3: Static Factory Pattern**
- **Problem**: `SchoolContextFactory.Create()` creates context statically
- **Impact**: Cannot control lifetime, hard to test, potential connection leaks
- **Solution**: Register DbContext in DI container with appropriate lifetime
- **Effort**: 1 day

**Issue 4: Synchronous I/O**
- **Problem**: Most database operations are synchronous (no async/await)
- **Impact**: Thread starvation under load, poor scalability
- **Solution**: Convert to async/await patterns throughout
- **Effort**: 3-4 days

### 5.2 Windows-Specific Dependencies

**Issue 5: MSMQ Dependency**
- **Problem**: `System.Messaging` and MSMQ are Windows-only
- **Impact**: Cannot run on Linux, cannot containerize easily
- **Solution**: Replace with Azure Service Bus
- **Code Changes**: Update `NotificationService` to use Azure.Messaging.ServiceBus
- **Effort**: 2-3 days

**Issue 6: Windows Authentication**
- **Problem**: IIS Windows Authentication is not portable
- **Impact**: Cannot run on non-Windows systems
- **Solution**: Implement Azure AD B2C or ASP.NET Core Identity
- **Effort**: 3-5 days

**Issue 7: Local File System Storage**
- **Problem**: Files stored in local file system not suitable for scale-out
- **Impact**: Cannot run on multiple servers, files lost on container restart
- **Solution**: Migrate to Azure Blob Storage
- **Effort**: 2-3 days

### 5.3 Configuration and Secrets

**Issue 8: Secrets in Configuration**
- **Problem**: Connection strings and sensitive data in Web.config
- **Impact**: Security risk, not suitable for source control
- **Solution**: Use Azure Key Vault with Managed Identity
- **Effort**: 2 days

**Issue 9: Environment-Specific Configuration**
- **Problem**: Web.config transformations are error-prone
- **Impact**: Deployment errors, manual configuration changes
- **Solution**: Use appsettings.json with environment variables and Key Vault
- **Effort**: 1-2 days

### 5.4 Data Layer

**Issue 10: Entity Framework Core 3.1 (EOL)**
- **Problem**: EF Core 3.1 is end-of-life
- **Impact**: No security updates, missing new features
- **Solution**: Upgrade to EF Core 9
- **Breaking Changes**: Review query behavior changes, update LINQ queries if needed
- **Effort**: 2-3 days

**Issue 11: Database Initialization Strategy**
- **Problem**: `DbInitializer` recreates database on model changes
- **Impact**: Data loss in production
- **Solution**: Use EF Core migrations for production deployments
- **Effort**: 1-2 days

### 5.5 Testing

**Issue 12: No Automated Tests**
- **Problem**: No unit, integration, or E2E tests
- **Impact**: Regressions not caught, refactoring risky
- **Solution**: Add comprehensive test suite (70%+ coverage)
- **Effort**: 5-10 days (ongoing)

**Issue 13: No Test Data Strategy**
- **Problem**: Testing requires manual data setup
- **Impact**: Inconsistent testing, time-consuming
- **Solution**: Implement test data builders and fixtures
- **Effort**: 2-3 days

### 5.6 DevOps

**Issue 14: No CI/CD Pipeline**
- **Problem**: Manual builds and deployments
- **Impact**: Slow, error-prone, no automation
- **Solution**: Implement GitHub Actions pipeline
- **Effort**: 3-5 days

**Issue 15: No Infrastructure as Code**
- **Problem**: Manual Azure resource creation
- **Impact**: Inconsistent environments, hard to reproduce
- **Solution**: Use Azure Bicep or Terraform for IaC
- **Effort**: 3-4 days

### 5.7 Performance

**Issue 16: N+1 Query Problem**
- **Problem**: Some queries may cause N+1 selects (e.g., loading related entities)
- **Impact**: Poor performance at scale
- **Solution**: Use `.Include()` appropriately, review all queries
- **Effort**: 2-3 days

**Issue 17: No Caching Strategy**
- **Problem**: Every request hits the database
- **Impact**: Unnecessary database load, slower responses
- **Solution**: Implement caching with Azure Cache for Redis or in-memory cache
- **Effort**: 2-3 days

### 5.8 Security

**Issue 18: No Input Validation**
- **Problem**: Limited server-side validation beyond model annotations
- **Impact**: Security vulnerabilities (XSS, SQL injection via EF could be a concern)
- **Solution**: Implement FluentValidation, input sanitization
- **Effort**: 2-3 days

**Issue 19: No CSRF Protection**
- **Problem**: Forms may be vulnerable to CSRF attacks
- **Impact**: Security risk
- **Solution**: Enable ASP.NET Core anti-forgery tokens
- **Effort**: 1 day

**Issue 20: No Rate Limiting**
- **Problem**: No protection against abuse or DDoS
- **Impact**: Service degradation, costs
- **Solution**: Implement rate limiting middleware or Azure API Management
- **Effort**: 1-2 days

### 5.9 Monitoring

**Issue 21: No Health Checks**
- **Problem**: Cannot monitor application health automatically
- **Impact**: Downtime not detected early, no auto-recovery
- **Solution**: Implement ASP.NET Core health checks
- **Effort**: 1 day

**Issue 22: No Structured Logging**
- **Problem**: Debug.WriteLine only, no log aggregation
- **Impact**: Hard to troubleshoot production issues
- **Solution**: Implement Serilog with Application Insights sink
- **Effort**: 1-2 days

---

## 6. Migration Plan

### 6.1 Migration Strategy

**Approach**: Incremental migration with parallel running

**Phases:**
1. **Phase 0**: Assessment and Planning (2 weeks)
2. **Phase 1**: Foundation - Core Migration (4 weeks)
3. **Phase 2**: Azure Services Integration (3 weeks)
4. **Phase 3**: Testing and Quality (2 weeks)
5. **Phase 4**: Deployment and Cutover (1 week)

**Total Timeline**: 12 weeks (3 months)

### 6.2 Phase 0: Assessment and Planning (2 weeks)

**Objectives:**
- Complete technical assessment
- Set up development environment
- Create Azure infrastructure
- Establish team and processes

**Tasks:**

**Week 1:**
- [ ] **Day 1-2**: Complete application inventory and dependency analysis
- [ ] **Day 3-4**: Set up Azure subscription and resource groups
- [ ] **Day 5**: Team kickoff, tools setup, access provisioning

**Week 2:**
- [ ] **Day 1-2**: Create Azure resources (SQL Database, Service Bus, Storage)
- [ ] **Day 3-4**: Set up GitHub repository, branching strategy, CI/CD skeleton
- [ ] **Day 5**: Sprint planning for Phase 1

**Deliverables:**
- ✅ Migration plan document (this document)
- ✅ Azure resources created (Dev environment)
- ✅ Team access and tools configured
- ✅ Git repository and branching strategy
- ✅ Detailed task breakdown for Phase 1

### 6.3 Phase 1: Foundation - Core Migration (4 weeks)

**Objectives:**
- Convert project to .NET 9
- Migrate to ASP.NET Core MVC
- Update Entity Framework Core to 9
- Remove Windows-specific dependencies (stub replacements)

**Week 1: Project Structure**
- [ ] Create new .NET 9 project structure (SDK-style)
- [ ] Set up solution structure with test projects
- [ ] Migrate packages.config to PackageReference
- [ ] Update all NuGet packages to .NET 9 compatible versions
- [ ] Create `Program.cs` and initial startup configuration
- [ ] Convert Web.config to appsettings.json
- [ ] Set up dependency injection container

**Week 2: Controllers and Views**
- [ ] Migrate controllers from ASP.NET MVC to ASP.NET Core MVC
  - [ ] Update BaseController to use constructor injection
  - [ ] Update StudentsController
  - [ ] Update CoursesController
  - [ ] Update InstructorsController
  - [ ] Update DepartmentsController
  - [ ] Update HomeController
  - [ ] Update NotificationsController (stub for now)
- [ ] Convert ActionResult to IActionResult
- [ ] Update routing to ASP.NET Core conventions
- [ ] Test basic navigation and CRUD operations

**Week 3: Views and Static Files**
- [ ] Move Content/ and Scripts/ to wwwroot/
- [ ] Update _Layout.cshtml for ASP.NET Core
- [ ] Update all Razor views
  - [ ] Replace HTML helpers with tag helpers
  - [ ] Update form submissions
  - [ ] Fix validation
  - [ ] Test each view
- [ ] Set up static file middleware
- [ ] Update bundling and minification

**Week 4: Data Layer**
- [ ] Update Entity Framework Core to version 9
- [ ] Update SchoolContext for .NET 9
- [ ] Remove SchoolContextFactory, use DI
- [ ] Update DbInitializer to use migrations
- [ ] Create initial EF Core migration
- [ ] Test all CRUD operations
- [ ] Convert synchronous operations to async/await

**Deliverables:**
- ✅ .NET 9 project structure
- ✅ All controllers migrated and functional
- ✅ All views rendering correctly
- ✅ EF Core 9 integrated with migrations
- ✅ Basic application functional on .NET 9

### 6.4 Phase 2: Azure Services Integration (3 weeks)

**Objectives:**
- Integrate Azure SQL Database
- Replace MSMQ with Azure Service Bus
- Replace local file storage with Azure Blob Storage
- Implement Azure AD authentication

**Week 1: Database Migration**
- [ ] Export schema and data from LocalDB
- [ ] Create Azure SQL Database (Serverless Dev tier)
- [ ] Run database migrations on Azure SQL
- [ ] Update connection string to use Azure SQL
- [ ] Test database connectivity and operations
- [ ] Implement connection resilience (retry policies)
- [ ] Set up Azure SQL firewall rules

**Week 2: Messaging and Storage**
- [ ] Create Azure Service Bus namespace and queue
- [ ] Update NotificationService to use Azure Service Bus
  - [ ] Replace System.Messaging with Azure.Messaging.ServiceBus
  - [ ] Implement send message functionality
  - [ ] Implement receive message functionality
  - [ ] Add error handling and retry logic
- [ ] Create Azure Blob Storage account
- [ ] Update file upload functionality
  - [ ] Replace File.WriteAllBytes with BlobContainerClient
  - [ ] Update file retrieval to use blob URLs
  - [ ] Generate SAS tokens for secure access
  - [ ] Update views to display blob images

**Week 3: Authentication and Security**
- [ ] Set up Azure AD B2C tenant
- [ ] Register application in Azure AD B2C
- [ ] Implement Azure AD B2C authentication
  - [ ] Add authentication middleware
  - [ ] Update [Authorize] attributes
  - [ ] Convert roles to claims
- [ ] Set up Azure Key Vault
- [ ] Move secrets to Key Vault
  - [ ] Connection strings
  - [ ] Service Bus connection string
  - [ ] Storage account connection string
- [ ] Implement Managed Identity for Key Vault access
- [ ] Test authentication flows

**Deliverables:**
- ✅ Application connected to Azure SQL Database
- ✅ MSMQ replaced with Azure Service Bus
- ✅ File storage migrated to Azure Blob Storage
- ✅ Azure AD B2C authentication implemented
- ✅ Secrets managed in Azure Key Vault

### 6.5 Phase 3: Testing and Quality (2 weeks)

**Objectives:**
- Implement comprehensive test suite
- Add monitoring and logging
- Improve code quality
- Performance testing

**Week 1: Testing**
- [ ] Set up test projects (Unit, Integration, E2E)
- [ ] Write unit tests for controllers (70% coverage target)
- [ ] Write unit tests for services
- [ ] Write integration tests for data layer
- [ ] Write E2E tests for critical user journeys
- [ ] Set up test data builders and fixtures
- [ ] Configure test runs in CI/CD pipeline

**Week 2: Monitoring and Quality**
- [ ] Set up Application Insights
  - [ ] Configure instrumentation
  - [ ] Add custom telemetry
  - [ ] Set up dashboards
  - [ ] Configure alerts
- [ ] Implement structured logging with Serilog
- [ ] Add health check endpoints
- [ ] Implement rate limiting
- [ ] Add CSRF protection
- [ ] Perform security scan
- [ ] Run performance tests
- [ ] Code review and refactoring

**Deliverables:**
- ✅ 70%+ code coverage with automated tests
- ✅ Application Insights fully configured
- ✅ Structured logging implemented
- ✅ Security hardening complete
- ✅ Performance benchmarks established

### 6.6 Phase 4: Deployment and Cutover (1 week)

**Objectives:**
- Containerize application
- Deploy to Azure Container Apps
- Set up CI/CD pipeline
- Production cutover

**Week 1:**
- [ ] Day 1-2: Containerization
  - [ ] Create Dockerfile
  - [ ] Build and test container locally
  - [ ] Push container to Azure Container Registry
  - [ ] Test container deployment
- [ ] Day 3-4: Azure Container Apps
  - [ ] Create Container App environment
  - [ ] Configure scaling rules
  - [ ] Configure environment variables
  - [ ] Deploy application
  - [ ] Configure custom domain and SSL
  - [ ] Test all functionality in Azure
- [ ] Day 5: Production Cutover
  - [ ] Final production deployment
  - [ ] Smoke tests
  - [ ] Monitor for issues
  - [ ] Document known issues
  - [ ] Retrospective

**Deliverables:**
- ✅ Dockerized application
- ✅ CI/CD pipeline fully functional
- ✅ Application deployed to Azure Container Apps
- ✅ Production environment live and stable
- ✅ Documentation complete

### 6.7 Post-Migration Tasks

**Immediate (Week 12-13):**
- [ ] Monitor production metrics
- [ ] Address any deployment issues
- [ ] Performance tuning based on real traffic
- [ ] User training and documentation

**Short-term (Month 2-3):**
- [ ] Implement caching strategy (Azure Cache for Redis)
- [ ] Add Azure CDN for static content
- [ ] Implement real-time notifications with SignalR
- [ ] Set up production database backup schedule
- [ ] Implement disaster recovery plan

**Medium-term (Month 4-6):**
- [ ] Evaluate microservices architecture
- [ ] Implement API versioning
- [ ] Add API Gateway (Azure API Management)
- [ ] Implement advanced monitoring and alerting
- [ ] Performance optimization based on metrics

---

## 7. Cost Considerations

### 7.1 Azure Services Monthly Costs (Estimates)

**Development Environment:**

| Service | Tier | Monthly Cost (USD) |
|---------|------|-------------------|
| Azure SQL Database | Serverless (1 vCore) | $5-$10 |
| Azure Service Bus | Standard | $10 |
| Azure Blob Storage | Hot tier (10GB) | $0.50 |
| Azure Container Apps | Consumption | $5-$20 |
| Application Insights | 1GB data | Free |
| Azure AD B2C | Free tier | $0 |
| **Total Dev** | | **$20-$40** |

**Production Environment (Small):**

| Service | Tier | Monthly Cost (USD) |
|---------|------|-------------------|
| Azure SQL Database | S1 (20 DTU) | $30 |
| Azure Service Bus | Standard | $10 |
| Azure Blob Storage | Hot tier (50GB, 10k ops/mo) | $2 |
| Azure Container Apps | 2 replicas, 0.5 vCPU each | $40-$80 |
| Application Insights | 5GB data | $10 |
| Azure AD B2C | 50K MAU | $0 |
| Azure Key Vault | Standard | $1 |
| Azure Container Registry | Basic | $5 |
| **Total Production** | | **$98-$138** |

**Production Environment (Medium - 1000 concurrent users):**

| Service | Tier | Monthly Cost (USD) |
|---------|------|-------------------|
| Azure SQL Database | S3 (100 DTU) | $150 |
| Azure Service Bus | Standard | $10 |
| Azure Blob Storage | Hot tier (200GB, 100k ops/mo) | $8 |
| Azure Container Apps | 5 replicas, 1 vCPU each | $200-$300 |
| Application Insights | 20GB data | $50 |
| Azure AD B2C | 50K MAU | $0 |
| Azure Key Vault | Standard | $1 |
| Azure Container Registry | Standard | $20 |
| Azure Cache for Redis (optional) | C1 (1GB) | $36 |
| **Total Production** | | **$475-$575** |

### 7.2 Cost Optimization Strategies

1. **Use Serverless/Consumption Tiers**
   - Azure SQL Serverless: Auto-pause during inactivity
   - Container Apps: Scale to zero during low traffic

2. **Reserved Instances**
   - 1-year commitment: 40% savings
   - 3-year commitment: 60% savings

3. **Development Cost Savings**
   - Use free tiers where possible
   - Share dev resources across team
   - Auto-shutdown dev resources overnight

4. **Monitoring and Alerts**
   - Set up budget alerts
   - Monitor unused resources
   - Right-size resources based on metrics

### 7.3 On-Premises vs Azure TCO Comparison (3 years)

**On-Premises (Single Server):**

| Item | Cost (USD) |
|------|-----------|
| Server hardware | $5,000 |
| Windows Server licenses | $1,500 |
| SQL Server Standard license | $3,717 |
| Maintenance and support | $3,600 |
| Power and cooling | $1,800 |
| Staff time (management) | $15,000 |
| **Total (3 years)** | **$30,617** |
| **Monthly average** | **$850** |

**Azure (Medium Production):**

| Item | Cost (USD) |
|------|-----------|
| Azure services (36 months @ $500/mo) | $18,000 |
| Initial migration (one-time) | $30,000 |
| Ongoing maintenance (reduced by 50%) | $7,500 |
| **Total (3 years)** | **$55,500** |
| **Monthly average** | **$1,542** |

**Analysis:**
- Higher initial cost due to migration effort
- Lower operational burden
- Better scalability and reliability
- Reduced staff time requirements
- Pay-as-you-grow model
- After year 1, Azure is more cost-effective when factoring in:
  - High availability (99.95% SLA)
  - Automatic scaling
  - Disaster recovery
  - Security features
  - Time savings

---

## 8. Risks and Mitigation

### 8.1 Technical Risks

**Risk 1: Breaking Changes in Migration**
- **Probability**: High
- **Impact**: High
- **Mitigation**: 
  - Comprehensive test suite before migration
  - Incremental migration approach
  - Parallel running of old and new systems
  - Rollback plan for each phase

**Risk 2: Performance Degradation**
- **Probability**: Medium
- **Impact**: High
- **Mitigation**:
  - Performance baseline before migration
  - Load testing at each phase
  - Application Insights monitoring
  - Caching strategy
  - Query optimization

**Risk 3: Data Loss During Migration**
- **Probability**: Low
- **Impact**: Critical
- **Mitigation**:
  - Multiple backups before migration
  - Validation of data after migration
  - Read-only period during cutover
  - Checksum validation of migrated data

**Risk 4: Azure Service Outages**
- **Probability**: Low
- **Impact**: High
- **Mitigation**:
  - Multi-region deployment (for critical workloads)
  - Health checks and auto-recovery
  - Circuit breaker pattern
  - Comprehensive monitoring and alerts

### 8.2 Project Risks

**Risk 5: Timeline Overrun**
- **Probability**: Medium
- **Impact**: Medium
- **Mitigation**:
  - 20% buffer in timeline
  - Agile approach with 2-week sprints
  - Regular progress reviews
  - Early identification of blockers

**Risk 6: Skill Gaps**
- **Probability**: Medium
- **Impact**: Medium
- **Mitigation**:
  - Training on .NET 9 and Azure
  - Pair programming
  - Code reviews
  - External consultant if needed

**Risk 7: Scope Creep**
- **Probability**: High
- **Impact**: Medium
- **Mitigation**:
  - Clear requirements and scope
  - Change control process
  - Phase 2 features deferred to post-migration
  - Product owner approval for changes

### 8.3 Business Risks

**Risk 8: User Resistance to Change**
- **Probability**: Medium
- **Impact**: Medium
- **Mitigation**:
  - User training sessions
  - Early user feedback
  - Phased rollout
  - Support resources available

**Risk 9: Cost Overruns**
- **Probability**: Medium
- **Impact**: Medium
- **Mitigation**:
  - Budget monitoring and alerts
  - Right-sizing resources
  - Reserved instances for savings
  - Regular cost reviews

**Risk 10: Security Vulnerabilities**
- **Probability**: Low
- **Impact**: High
- **Mitigation**:
  - Security scanning in CI/CD
  - Penetration testing
  - Azure Security Center monitoring
  - Regular security audits

---

## 9. Success Criteria

### 9.1 Technical Success Criteria

- [ ] Application runs on .NET 9
- [ ] All features functional on Azure
- [ ] 99.9% uptime SLA achieved
- [ ] Page load time < 2 seconds
- [ ] API response time < 500ms (95th percentile)
- [ ] Zero data loss during migration
- [ ] 70%+ code coverage
- [ ] All critical security vulnerabilities resolved
- [ ] Cross-platform deployment (Windows, Linux)

### 9.2 Business Success Criteria

- [ ] Migration completed within 12 weeks
- [ ] Budget within 10% of estimate
- [ ] Zero critical bugs in production
- [ ] User satisfaction score > 8/10
- [ ] Staff productivity maintained or improved
- [ ] Reduced operational costs (after year 1)

### 9.3 Agility Success Criteria

- [ ] Deployment time reduced from 30 min to < 5 min
- [ ] Time to resolve production issues reduced by 50%
- [ ] New feature development time reduced by 25%
- [ ] Onboarding time for new developers reduced by 40%
- [ ] Infrastructure provisioning automated (IaC)
- [ ] Can scale to 10x current load without architecture changes

---

## 10. Conclusion

### 10.1 Summary

This migration plan provides a comprehensive roadmap for transforming the ContosoUniversity application from a legacy .NET Framework 4.8 application into a modern, cloud-native .NET 9 application hosted on Azure. The plan addresses all key technical requirements, provides detailed Azure service recommendations with comparisons, and includes a phased implementation approach.

### 10.2 Key Benefits

**Technical Benefits:**
- Modern .NET 9 framework with latest features
- Cross-platform compatibility (Windows, Linux, macOS)
- Cloud-native architecture for better scalability
- Enterprise-grade security and compliance
- Improved performance and reliability

**Business Benefits:**
- Reduced operational costs (long-term)
- Better scalability for growth
- Reduced time to market for new features
- Improved developer productivity
- Future-proof architecture

**Agility Benefits:**
- **Debuggability**: 5/10 → 9/10 (80% improvement)
- **Extensibility**: 6/10 → 9/10 (50% improvement)
- **Portability**: 2/10 → 10/10 (400% improvement)
- **Scalability**: 3/10 → 9/10 (200% improvement)
- **Securability**: 4/10 → 9/10 (125% improvement)
- **Testability**: 4/10 → 9/10 (125% improvement)
- **Understandability**: 6/10 → 9/10 (50% improvement)

### 10.3 Recommended Next Steps

1. **Immediate (Week 1):**
   - Review and approve this migration plan
   - Secure budget and resources
   - Set up Azure subscription
   - Assign project team

2. **Short-term (Week 2-4):**
   - Begin Phase 0 (Assessment and Planning)
   - Set up development environment
   - Create Azure resources for dev environment
   - Set up CI/CD skeleton

3. **Medium-term (Month 2-3):**
   - Execute Phase 1 (Core Migration)
   - Execute Phase 2 (Azure Services Integration)
   - Begin testing

4. **Long-term (Month 3+):**
   - Complete testing and deployment
   - Production cutover
   - Post-migration optimization
   - Plan Phase 2 enhancements

### 10.4 Final Recommendations

1. **Start with Phase 0**: Don't rush into coding. Proper planning and setup will save time later.

2. **Prioritize Testing**: Invest in a comprehensive test suite early. It will pay dividends throughout the migration.

3. **Use Feature Flags**: Implement feature flags to enable gradual rollout and easy rollback.

4. **Monitor Everything**: Set up Application Insights from day one. You can't optimize what you can't measure.

5. **Keep It Simple**: Don't over-engineer. Start with the recommended architecture and enhance based on actual needs.

6. **Involve Users Early**: Get user feedback on the new system before final cutover.

7. **Plan for Rollback**: Always have a rollback plan at each phase.

8. **Document as You Go**: Don't leave documentation for the end. Document decisions and changes immediately.

9. **Celebrate Milestones**: This is a significant project. Celebrate phase completions with the team.

10. **Think Long-term**: This migration sets the foundation for the next 5-10 years. Make architectural decisions with future growth in mind.

---

## Appendix

### A. Glossary

- **ADR**: Architecture Decision Record
- **AKS**: Azure Kubernetes Service
- **CRUD**: Create, Read, Update, Delete
- **DI**: Dependency Injection
- **DTU**: Database Transaction Unit (Azure SQL metric)
- **EF Core**: Entity Framework Core
- **FIFO**: First In, First Out
- **IaC**: Infrastructure as Code
- **MAU**: Monthly Active Users
- **MSMQ**: Microsoft Message Queuing
- **MVC**: Model-View-Controller
- **RBAC**: Role-Based Access Control
- **SAS**: Shared Access Signature (Azure Storage)
- **SLA**: Service Level Agreement
- **TCO**: Total Cost of Ownership
- **TPH**: Table-per-Hierarchy (EF Core inheritance pattern)

### B. References

- [.NET 9 Documentation](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-9)
- [ASP.NET Core Migration Guide](https://learn.microsoft.com/en-us/aspnet/core/migration/mvc)
- [Entity Framework Core 9 Documentation](https://learn.microsoft.com/en-us/ef/core/)
- [Azure Container Apps Documentation](https://learn.microsoft.com/en-us/azure/container-apps/)
- [Azure SQL Database Documentation](https://learn.microsoft.com/en-us/azure/azure-sql/)
- [Azure Service Bus Documentation](https://learn.microsoft.com/en-us/azure/service-bus-messaging/)
- [Azure Blob Storage Documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/)
- [Azure Application Insights Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview)

### C. Migration Checklist

#### Pre-Migration
- [ ] Backup all code and data
- [ ] Document current system behavior
- [ ] Create test data set
- [ ] Set up Azure subscription
- [ ] Provision Azure resources
- [ ] Team training completed

#### Migration
- [ ] Project converted to .NET 9
- [ ] Controllers migrated
- [ ] Views migrated
- [ ] EF Core updated to version 9
- [ ] Azure SQL Database integrated
- [ ] Azure Service Bus integrated
- [ ] Azure Blob Storage integrated
- [ ] Authentication migrated
- [ ] Tests written and passing
- [ ] Application Insights configured
- [ ] Docker container created

#### Post-Migration
- [ ] Production deployment successful
- [ ] All smoke tests passed
- [ ] Performance benchmarks met
- [ ] Security scan completed
- [ ] User acceptance testing completed
- [ ] Documentation updated
- [ ] Monitoring alerts configured
- [ ] Team trained on new system

### D. Contact Information

**Project Team:**
- Project Manager: [TBD]
- Lead Developer: [TBD]
- DevOps Engineer: [TBD]
- Azure Architect: [TBD]

**Escalation Path:**
- Level 1: Development Team
- Level 2: Technical Lead
- Level 3: CTO / Engineering Manager

---

**Document Version**: 1.0
**Last Updated**: 2024
**Author**: GitHub Copilot
**Approved By**: [Pending]
**Next Review Date**: [TBD]
