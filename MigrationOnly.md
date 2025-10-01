# .NET 9 Migration Analysis for ContosoUniversity

## Executive Summary

This document provides a comprehensive analysis of what is required to migrate the ContosoUniversity application from .NET Framework 4.8 with ASP.NET MVC 5 to .NET 9 with ASP.NET Core. The analysis focuses strictly on migration requirements without modernization recommendations.

---

## Current Application State

### Technology Stack
- **Framework**: .NET Framework 4.8
- **Web Framework**: ASP.NET MVC 5.2.9
- **ORM**: Entity Framework Core 3.1.32
- **Database**: SQL Server LocalDB
- **UI Libraries**: Bootstrap 5.3.3, jQuery 3.7.1
- **Messaging**: Microsoft Message Queue (MSMQ) for notifications
- **Authentication**: Windows Authentication (IIS Express)
- **Bundling/Minification**: System.Web.Optimization
- **Target Platform**: Windows-only (due to MSMQ and System.Web dependencies)

### Application Components
1. **Controllers**: Student, Course, Instructor, Department, Notifications, Home management
2. **Data Layer**: Entity Framework Core with DbContext
3. **Models**: Domain entities (Student, Course, Instructor, Department) with view models
4. **Services**: NotificationService (MSMQ-based)
5. **Views**: Razor views with ASP.NET MVC 5 syntax
6. **Static Content**: Bootstrap CSS, jQuery scripts, custom CSS/JS

---

## Migration Requirements

### 1. Project File Migration

#### Current State
- Uses legacy `.csproj` format (XML-based with `PackageReference` via `packages.config`)
- Target framework: `net48`
- Web application project type with MSBuild properties

#### Required Changes
- Convert to SDK-style project format
- Update target framework to `net9.0`
- Remove `packages.config` and migrate to PackageReference in `.csproj`
- Remove legacy MSBuild imports and properties:
  - `Microsoft.WebApplication.targets`
  - IIS Express configurations
  - `MvcBuildViews` settings
  - SQL Client native binary copy targets

#### Migration Steps
1. Create new `ContosoUniversity.csproj` with SDK-style format
2. Set `<TargetFramework>net9.0</TargetFramework>`
3. Add `<Project Sdk="Microsoft.NET.Sdk.Web">`
4. Convert PackageReferences from `packages.config`
5. Remove `AssemblyInfo.cs` (properties moved to project file)

---

### 2. ASP.NET MVC 5 to ASP.NET Core Migration

#### Current Dependencies to Replace

**ASP.NET MVC 5 Components:**
- `System.Web.Mvc` → ASP.NET Core MVC
- `System.Web.Razor` → ASP.NET Core Razor
- `System.Web.WebPages` → ASP.NET Core Pages
- `System.Web.Optimization` → ASP.NET Core bundling (built-in or BundleMinifier)
- `System.Web.Helpers` → ASP.NET Core equivalents

#### Required Code Changes

##### A. Application Startup
**Current**: `Global.asax` with `Application_Start()`
```csharp
// Global.asax.cs
protected void Application_Start()
{
    AreaRegistration.RegisterAllAreas();
    FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
    RouteConfig.RegisterRoutes(RouteTable.Routes);
    BundleConfig.RegisterBundles(BundleTable.Bundles);
    InitializeDatabase();
}
```

**Required**: `Program.cs` with WebApplicationBuilder
```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllersWithViews();
builder.Services.AddDbContext<SchoolContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
// Configure other services

var app = builder.Build();
// Configure middleware pipeline
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");
app.Run();
```

**Files to Remove**:
- `Global.asax` and `Global.asax.cs`
- `App_Start/RouteConfig.cs`
- `App_Start/FilterConfig.cs`
- `App_Start/BundleConfig.cs`

**Files to Create**:
- `Program.cs`

##### B. Configuration System
**Current**: `Web.config` with `<appSettings>` and `<connectionStrings>`

**Required**: `appsettings.json` and `appsettings.Development.json`
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=(LocalDb)\\MSSQLLocalDB;Initial Catalog=ContosoUniversityNoAuthEFCore;Integrated Security=True;MultipleActiveResultSets=True"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "NotificationQueuePath": ".\\Private$\\ContosoUniversityNotifications"
}
```

**Files to Remove**:
- `Web.config`
- `Web.Debug.config`
- `Web.Release.config`

**Files to Create**:
- `appsettings.json`
- `appsettings.Development.json`

##### C. Controller Changes
**Current**: Inherit from `System.Web.Mvc.Controller`
```csharp
using System.Web.Mvc;

public class StudentsController : BaseController
{
    public ActionResult Index() { }
}
```

**Required**: Inherit from `Microsoft.AspNetCore.Mvc.Controller`
```csharp
using Microsoft.AspNetCore.Mvc;

public class StudentsController : BaseController
{
    public IActionResult Index() { }
}
```

**Key Changes Needed**:
1. Change `ActionResult` to `IActionResult`
2. Replace `HttpNotFound()` with `NotFound()`
3. Replace `HttpStatusCodeResult` with `StatusCodeResult` or `BadRequestResult()`
4. Update `[Bind(Include = "...")]` to `[Bind("...")]` or use explicit parameters
5. Update `[ValidateAntiForgeryToken]` usage (same in Core)
6. Replace `Request.Files` with `IFormFile` for file uploads
7. Remove `using System.Web.Mvc` and add `using Microsoft.AspNetCore.Mvc`

##### D. Dependency Injection
**Current**: Manual instantiation in controllers
```csharp
protected SchoolContext db;
protected NotificationService notificationService = new NotificationService();

public BaseController()
{
    db = SchoolContextFactory.Create();
}
```

**Required**: Constructor injection
```csharp
private readonly SchoolContext _context;
private readonly NotificationService _notificationService;

public BaseController(SchoolContext context, NotificationService notificationService)
{
    _context = context;
    _notificationService = notificationService;
}
```

**Service Registration in Program.cs**:
```csharp
builder.Services.AddScoped<NotificationService>();
builder.Services.AddDbContext<SchoolContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
```

##### E. Razor View Changes
**Current**: ASP.NET MVC 5 Razor syntax
```cshtml
@using System.Web.Mvc
@using System.Web.Mvc.Html
```

**Required**: ASP.NET Core Razor syntax
```cshtml
@using Microsoft.AspNetCore.Mvc
@using Microsoft.AspNetCore.Mvc.Rendering
```

**Specific Changes**:
1. Update `@Html.AntiForgeryToken()` usage (remains the same)
2. Replace `@Styles.Render()` with `<link>` tags or TagHelpers
3. Replace `@Scripts.Render()` with `<script>` tags or TagHelpers
4. Update `_ViewStart.cshtml` and `_Layout.cshtml` for Core conventions
5. Remove `Views/Web.config` (no longer needed)

---

### 3. Entity Framework Core Migration

#### Current State
- Entity Framework Core 3.1.32 (already using EF Core, not EF6)
- Package: `Microsoft.EntityFrameworkCore.SqlServer 3.1.32`

#### Required Changes
- Upgrade to Entity Framework Core 9.x
- Update package: `Microsoft.EntityFrameworkCore.SqlServer` to version 9.x
- Update `DbContext` registration to use ASP.NET Core DI

#### Code Changes
**Current `SchoolContextFactory.cs`**:
```csharp
public static class SchoolContextFactory
{
    public static SchoolContext Create()
    {
        var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        var optionsBuilder = new DbContextOptionsBuilder<SchoolContext>();
        optionsBuilder.UseSqlServer(connectionString);
        return new SchoolContext(optionsBuilder.Options);
    }
}
```

**Required**: Remove factory, use DI in `Program.cs`
```csharp
builder.Services.AddDbContext<SchoolContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
```

**Files to Remove**:
- `Data/SchoolContextFactory.cs`

**EF Core Compatibility**:
- The existing `SchoolContext` code is compatible with EF Core 9
- Model configurations will work as-is
- Migration commands change from EF6 to EF Core CLI

---

### 4. NuGet Package Updates

#### Packages to Remove (ASP.NET Framework-specific)
```xml
<!-- Web Framework -->
Microsoft.AspNet.Mvc (5.2.9)
Microsoft.AspNet.Razor (3.2.9)
Microsoft.AspNet.WebPages (3.2.9)
Microsoft.AspNet.Web.Optimization (1.1.3)
Microsoft.Web.Infrastructure (2.0.1)

<!-- Bundling/Optimization -->
WebGrease (1.5.2)
Antlr (3.4.1.9004)

<!-- Compiler -->
Microsoft.CodeDom.Providers.DotNetCompilerPlatform (2.0.1)

<!-- Framework Libraries -->
NETStandard.Library (2.0.3) - not needed in .NET 9
```

#### Packages to Update
```xml
<!-- Entity Framework Core -->
Microsoft.EntityFrameworkCore (3.1.32 → 9.0.x)
Microsoft.EntityFrameworkCore.SqlServer (3.1.32 → 9.0.x)
Microsoft.EntityFrameworkCore.Tools (3.1.32 → 9.0.x)

<!-- JSON Serialization -->
Newtonsoft.Json (13.0.3 → keep or migrate to System.Text.Json)

<!-- Client Libraries -->
jQuery (3.7.1 → 3.7.1) - keep as-is
Bootstrap (5.3.3 → 5.3.3) - keep as-is
jQuery.Validation (1.21.0 → 1.21.0) - keep as-is
```

#### Packages to Add
```xml
<!-- ASP.NET Core packages are implicitly included via SDK -->
<!-- May need explicit packages for: -->
Microsoft.AspNetCore.Mvc.Razor.RuntimeCompilation (for development-time view compilation)
```

---

### 5. Windows-Specific Dependencies

#### MSMQ (System.Messaging)
**Current**: Uses `System.Messaging` namespace for Microsoft Message Queue
```csharp
using System.Messaging;

public class NotificationService
{
    private readonly MessageQueue _queue;
    // MSMQ-specific code
}
```

**Issue**: `System.Messaging` is Windows-only and not supported in .NET Core/.NET 5+

**Required for Migration**:
Three options to consider:

**Option 1: Keep MSMQ (Windows-only deployment)**
- Use the community package: `Experimental.System.Messaging` (NuGet)
- Application remains Windows-only
- Limited support and maintenance

**Option 2: Abstract the messaging layer**
- Create `INotificationService` interface
- Keep MSMQ implementation for Windows
- Allow future replacement with cross-platform messaging

**Option 3: Replace with cross-platform alternative** (Not recommended for migration-only, but noted for future)
- Would require replacing NotificationService entirely

**Recommended for Migration**: Use `Experimental.System.Messaging` package to maintain existing functionality with minimal code changes.

#### Impact
- Application will remain Windows-only if MSMQ is retained
- `NotificationService.cs` needs package reference update
- No code changes required if using `Experimental.System.Messaging`

---

### 6. Authentication and Authorization

#### Current State
- Windows Authentication configured in Web.config
- IIS Express configuration for Windows Authentication
- No custom authentication code

#### Required Changes
- Configure Windows Authentication in `Program.cs`:
```csharp
builder.Services.AddAuthentication(IISDefaults.AuthenticationScheme);
builder.Services.AddAuthorization();
```

- Update `launchSettings.json` for IIS Express/Kestrel settings
- Remove Web.config authentication settings

**Files to Create**:
- `Properties/launchSettings.json`

---

### 7. Static File Serving and Bundling

#### Current State
- Uses `System.Web.Optimization` for bundling and minification
- BundleConfig.cs defines script and style bundles
- Content served from `Content/` and `Scripts/` folders

#### Required Changes
**Static Files**:
- Add `app.UseStaticFiles();` in middleware pipeline
- Rename/move static files to `wwwroot/` folder structure:
  - `Content/` → `wwwroot/css/`
  - `Scripts/` → `wwwroot/js/`
  - `favicon.ico` → `wwwroot/favicon.ico`

**Bundling Options**:
1. **Manual references** (simplest for migration):
   - Replace `@Scripts.Render()` with individual `<script>` tags
   - Replace `@Styles.Render()` with individual `<link>` tags

2. **Use WebOptimizer** (optional, maintains similar functionality):
   ```
   dotnet add package LigerShark.WebOptimizer.Core
   ```

---

### 8. File Upload Changes

#### Current Implementation
The application has file upload functionality for teaching materials:
```csharp
// Current code uses Request.Files (System.Web)
var file = Request.Files[0];
```

#### Required Changes
Replace with `IFormFile`:
```csharp
public async Task<IActionResult> Upload(IFormFile file)
{
    if (file != null && file.Length > 0)
    {
        var fileName = Path.GetFileName(file.FileName);
        var filePath = Path.Combine(_hostEnvironment.WebRootPath, "uploads", fileName);
        using (var stream = new FileStream(filePath, FileMode.Create))
        {
            await file.CopyToAsync(stream);
        }
    }
}
```

**Service Injection Required**:
```csharp
private readonly IWebHostEnvironment _hostEnvironment;

public Controller(IWebHostEnvironment hostEnvironment)
{
    _hostEnvironment = hostEnvironment;
}
```

---

### 9. Database Migration Commands

#### Current EF Core 3.1.32 Commands
```bash
# Package Manager Console
Add-Migration InitialCreate
Update-Database

# .NET CLI
dotnet ef migrations add InitialCreate
dotnet ef database update
```

#### Required for .NET 9
The commands remain the same, but tools need update:
```bash
# Install/Update EF Core tools
dotnet tool install --global dotnet-ef
dotnet tool update --global dotnet-ef

# Same migration commands work
dotnet ef migrations add InitialCreate
dotnet ef database update
```

**Note**: Existing EF Core 3.1 database should be compatible with EF Core 9, but thorough testing is required.

---

### 10. Configuration Access Changes

#### Current Code
```csharp
using System.Configuration;

var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
var queuePath = ConfigurationManager.AppSettings["NotificationQueuePath"];
```

#### Required Changes
```csharp
using Microsoft.Extensions.Configuration;

public class NotificationService
{
    private readonly IConfiguration _configuration;
    
    public NotificationService(IConfiguration configuration)
    {
        _configuration = configuration;
    }
    
    private string GetQueuePath()
    {
        return _configuration["NotificationQueuePath"] ?? 
               @".\Private$\ContosoUniversityNotifications";
    }
}
```

All classes needing configuration must use dependency injection to receive `IConfiguration`.

---

## Migration Plan

### Phase 1: Project Structure Setup
1. ✅ **Backup Current Project**
   - Create a backup branch or copy of the current application

2. ✅ **Create New Project Structure**
   - Create new SDK-style `.csproj` file
   - Create `Program.cs` with basic ASP.NET Core setup
   - Create `appsettings.json` and migrate configuration from Web.config
   - Create `Properties/launchSettings.json`

3. ✅ **Setup wwwroot Folder**
   - Create `wwwroot/` folder
   - Move `Content/` to `wwwroot/css/`
   - Move `Scripts/` to `wwwroot/js/`
   - Move `favicon.ico` to `wwwroot/`
   - Move `Uploads/` to `wwwroot/uploads/`

### Phase 2: Code Migration
4. ✅ **Update Controllers**
   - Update all controller base class from `System.Web.Mvc.Controller` to `Microsoft.AspNetCore.Mvc.Controller`
   - Change `ActionResult` to `IActionResult`
   - Update `BaseController` to use constructor injection
   - Update return types: `HttpNotFound()` → `NotFound()`, etc.
   - Update `[Bind]` attributes
   - Update file upload code to use `IFormFile`

5. ✅ **Update Services**
   - Update `NotificationService` to use `IConfiguration` via DI
   - Add `Experimental.System.Messaging` package reference
   - Register services in `Program.cs`

6. ✅ **Update Data Layer**
   - Remove `SchoolContextFactory`
   - Update `SchoolContext` registration in `Program.cs`
   - Update database initialization in `Program.cs`

### Phase 3: Views and UI
7. ✅ **Update Razor Views**
   - Update `_ViewStart.cshtml`
   - Update `_Layout.cshtml` to remove bundling helpers
   - Add direct `<link>` and `<script>` references
   - Update namespace imports
   - Remove `Views/Web.config`

8. ✅ **Update Static References**
   - Replace `@Styles.Render("~/Content/css")` with direct links
   - Replace `@Scripts.Render("~/bundles/jquery")` with direct script tags
   - Update all asset paths to reflect `wwwroot/` structure

### Phase 4: NuGet Packages
9. ✅ **Update NuGet Packages**
   - Remove `packages.config`
   - Add `Microsoft.EntityFrameworkCore` version 9.x packages
   - Add `Experimental.System.Messaging`
   - Keep necessary client libraries (jQuery, Bootstrap)

### Phase 5: Testing and Validation
10. ✅ **Build and Resolve Compilation Errors**
    - Fix any remaining namespace issues
    - Fix any API incompatibilities
    - Ensure all views compile

11. ✅ **Test Database Connectivity**
    - Verify EF Core 9 can connect to existing database
    - Test existing migrations or create new initial migration
    - Verify data access operations

12. ✅ **Test Application Features**
    - Test CRUD operations for all entities
    - Test file upload functionality
    - Test notification system (MSMQ)
    - Test pagination and search

13. ✅ **Test on Target Environment**
    - Deploy to Windows Server with .NET 9 runtime
    - Verify IIS/Kestrel configuration
    - Verify MSMQ functionality

---

## Known Issues and Solutions

### Issue 1: MSMQ Platform Dependency
**Issue**: System.Messaging is Windows-only and not officially supported in .NET Core/.NET 5+

**Solution**: 
- Use `Experimental.System.Messaging` NuGet package (community-maintained)
- Application must be deployed on Windows
- Long-term: Consider abstracting messaging layer for future cross-platform support

**Impact**: Application remains Windows-only, but achieves .NET 9 migration

---

### Issue 2: Entity Framework Core Version Gap
**Issue**: Jumping from EF Core 3.1.32 to EF Core 9.x spans multiple major versions

**Solution**:
- Review [EF Core breaking changes documentation](https://docs.microsoft.com/ef/core/what-is-new/)
- Test database migrations thoroughly
- Key breaking changes to watch:
  - Query behavior changes
  - Lazy loading changes
  - Configuration API changes (should be minimal)

**Impact**: Mostly compatible, but thorough testing required

---

### Issue 3: Bundling and Optimization
**Issue**: System.Web.Optimization not available in ASP.NET Core

**Solution**:
- **For Migration**: Use direct references to CSS/JS files (simplest)
- **Optional**: Use ASP.NET Core bundling middleware (WebOptimizer, BundlerMinifier)
- Browser caching can be configured via middleware

**Impact**: Minimal - modern browsers handle multiple requests efficiently

---

### Issue 4: Windows Authentication on Non-IIS Hosts
**Issue**: Windows Authentication typically requires IIS or IIS Express

**Solution**:
- Configure Windows Authentication in `Program.cs`
- For IIS hosting: Use IIS with Windows Authentication enabled
- For Kestrel: Enable Windows Authentication (may have limitations)
- Ensure `launchSettings.json` has correct authentication settings

**Impact**: Deployment must be on Windows with IIS for full compatibility

---

### Issue 5: SQL Server LocalDB Connection String
**Issue**: LocalDB may require updated connection string format

**Solution**:
- Current connection string should work in .NET 9
- If issues arise, update to: `Server=(localdb)\\mssqllocaldb;Database=ContosoUniversityNoAuthEFCore;Trusted_Connection=True;MultipleActiveResultSets=true`

**Impact**: Minimal - usually no changes needed

---

### Issue 6: File Upload Size Limits
**Issue**: Configuration of max file size differs between ASP.NET Framework and ASP.NET Core

**Current in Web.config**:
```xml
<httpRuntime maxRequestLength="10240" />
<requestLimits maxAllowedContentLength="10485760"/>
```

**Required in Program.cs**:
```csharp
builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = 10485760; // 10 MB
});

builder.Services.Configure<IISServerOptions>(options =>
{
    options.MaxRequestBodySize = 10485760;
});
```

**Impact**: Need to configure in code instead of XML

---

### Issue 7: Async/Await Patterns
**Issue**: Current controllers are mostly synchronous; ASP.NET Core best practices favor async

**Solution for Migration**:
- Synchronous code will still work in .NET 9
- No requirement to refactor to async for migration
- Recommend async refactoring as future enhancement (not part of migration)

**Impact**: Code works as-is, but async is recommended for scalability

---

### Issue 8: Session State
**Issue**: If application uses Session (not apparent in provided code, but common in MVC 5)

**Solution**:
- ASP.NET Core requires explicit session configuration
- Add `builder.Services.AddDistributedMemoryCache()` and `builder.Services.AddSession()`
- Add `app.UseSession()` in middleware pipeline

**Impact**: Only if session is used (not evident in current code)

---

## Estimated Migration Effort

### Code Changes Summary
| Component | Files Affected | Estimated Effort |
|-----------|---------------|------------------|
| Project Files | 1 (create new .csproj) | 2 hours |
| Configuration | 3 (appsettings.json, launchSettings.json, remove Web.config) | 2 hours |
| Startup Code | 2 (Program.cs, remove Global.asax) | 3 hours |
| Controllers | 7 (all controllers + BaseController) | 8 hours |
| Services | 1 (NotificationService) | 2 hours |
| Data Layer | 2 (remove factory, update context) | 2 hours |
| Views | ~20 views + layouts | 6 hours |
| Static Files | Reorganize to wwwroot | 2 hours |
| Testing | All features | 8-16 hours |
| **Total** | | **35-43 hours** |

### Dependencies on External Factors
- MSMQ availability in target environment
- Windows Server environment for deployment
- SQL Server database compatibility testing
- No modernization or architectural changes included

---

## Testing Checklist

### Functional Testing
- [ ] Database connection and data retrieval
- [ ] Student CRUD operations
- [ ] Course CRUD operations
- [ ] Instructor CRUD operations
- [ ] Department CRUD operations
- [ ] File upload for teaching materials
- [ ] Pagination functionality
- [ ] Search functionality
- [ ] Notification system (MSMQ)
- [ ] Database initialization/seeding
- [ ] Windows Authentication

### Non-Functional Testing
- [ ] Application startup time
- [ ] Page load performance
- [ ] Database query performance
- [ ] File upload size limits
- [ ] Browser compatibility (CSS/JS)
- [ ] Responsive design (Bootstrap)

### Environment Testing
- [ ] Development environment (Visual Studio + Kestrel)
- [ ] IIS Express
- [ ] IIS on Windows Server
- [ ] SQL Server LocalDB
- [ ] SQL Server (full edition)
- [ ] MSMQ functionality

---

## Post-Migration Recommendations (Not Part of Migration Scope)

The following are **NOT** required for migration but are recommended for future consideration:

1. **Async/Await Refactoring**: Convert synchronous controllers to async for better scalability
2. **Dependency Injection Improvements**: Use interfaces for better testability
3. **Logging**: Replace Debug.WriteLine with ILogger
4. **Error Handling**: Implement global exception handling middleware
5. **API Endpoints**: Consider adding API controllers alongside MVC
6. **Health Checks**: Add health check endpoints for monitoring
7. **MSMQ Replacement**: Abstract messaging to allow future replacement with Azure Service Bus or RabbitMQ
8. **File Storage**: Abstract file storage to allow future use of Azure Blob Storage
9. **Configuration Management**: Use Azure App Configuration or similar for deployment flexibility
10. **Container Support**: Create Dockerfile for containerization (after MSMQ replacement)

These items are explicitly **excluded** from the migration scope as per the requirement to focus only on migration needs.

---

## Conclusion

The ContosoUniversity application can be successfully migrated from .NET Framework 4.8 to .NET 9 with the following key considerations:

### ✅ Straightforward Migrations
- Entity Framework Core 3.1.32 → 9.x (already using EF Core)
- Most business logic and model code remains unchanged
- Views require minimal changes (mostly namespace updates)
- Static files (CSS, JS) remain largely unchanged

### ⚠️ Platform Constraints
- **Windows-Only**: Application must remain on Windows due to MSMQ dependency
- **IIS Recommended**: Windows Authentication works best with IIS
- **No Cross-Platform**: Cannot deploy to Linux/Docker without MSMQ replacement

### 🔧 Significant Changes Required
- Complete project structure overhaul (SDK-style project)
- ASP.NET MVC 5 → ASP.NET Core MVC (different APIs and patterns)
- Dependency Injection throughout
- Configuration system replacement (Web.config → appsettings.json)
- Bundling/optimization system replacement

### 📊 Migration Feasibility
**Feasibility Rating**: ✅ **High** - Migration is definitely achievable

**Complexity Rating**: ⚠️ **Moderate** - Requires systematic approach but no blockers

**Risk Level**: 🟡 **Medium** - MSMQ dependency using community package introduces some risk

**Estimated Timeline**: 35-43 hours of development + 8-16 hours of testing = **1-2 weeks** for a single developer

The migration is well-supported by Microsoft's tooling and documentation, with the primary challenge being the MSMQ dependency which can be addressed using the `Experimental.System.Messaging` package while maintaining Windows hosting requirements.
