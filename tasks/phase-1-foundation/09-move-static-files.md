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
