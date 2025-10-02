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
