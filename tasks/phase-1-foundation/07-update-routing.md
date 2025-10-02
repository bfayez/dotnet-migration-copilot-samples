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
