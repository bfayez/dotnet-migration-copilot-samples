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
