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
