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
