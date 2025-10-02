# Task: Create and Apply EF Core Migrations

## Phase
Phase 1: Foundation - Core Migration (Week 4)

## Description
Replace the DbInitializer pattern with EF Core Migrations for safe database schema management in production.

## Objectives
- Create initial EF Core migration
- Replace DbInitializer with migrations
- Test migration on development database
- Document migration process
- Prepare for production database migration

## Prerequisites
- EF Core 9 configured
- DbContext properly set up
- Database schema understood
- Connection to development database

## Dependencies
- Phase 1: Task 11 - Update DbContext for Dependency Injection and Remove Static Factory

## Tasks
1. **Prepare for Migrations:**
   - Ensure EF Core Tools are installed
   - Verify DbContext configuration
   - Back up current database
   - Document current schema

2. **Create Initial Migration:**
   ```bash
   dotnet ef migrations add InitialCreate
   ```
   - Review generated migration code
   - Verify Up() method captures all entities
   - Verify Down() method for rollback
   - Check for any issues or warnings

3. **Review Migration Code:**
   - Check table definitions
   - Verify indexes
   - Check foreign keys
   - Verify data types
   - Review constraints

4. **Test Migration Locally:**
   ```bash
   dotnet ef database update
   ```
   - Apply migration to development database
   - Verify all tables created
   - Verify relationships are correct
   - Test application with migrated database

5. **Update DbInitializer:**
   - Keep seed data logic
   - Remove database recreation logic
   - Convert to a seeding strategy
   - Apply seed data after migration
   ```csharp
   public static class DbInitializer
   {
       public static async Task SeedAsync(SchoolContext context)
       {
           if (await context.Students.AnyAsync())
               return; // DB has been seeded
               
           // Add seed data
           await context.SaveChangesAsync();
       }
   }
   ```

6. **Update Program.cs:**
   - Apply migrations on startup (development only)
   - Run seed data
   - Handle migration errors gracefully
   ```csharp
   using (var scope = app.Services.CreateScope())
   {
       var context = scope.ServiceProvider.GetRequiredService<SchoolContext>();
       
       if (app.Environment.IsDevelopment())
       {
           await context.Database.MigrateAsync(); // Apply pending migrations
           await DbInitializer.SeedAsync(context);
       }
   }
   ```

7. **Test Migration Workflow:**
   - Test creating new migration
   - Test applying migration
   - Test rolling back migration
   - Test updating from previous migration

8. **Document Migration Process:**
   - Document how to create migrations
   - Document how to apply migrations
   - Document how to rollback migrations
   - Create runbook for production migrations
   - Document troubleshooting steps

9. **Production Migration Strategy:**
   - Plan production migration approach
   - Decide on manual vs automatic migrations
   - Create backup strategy
   - Plan rollback procedure
   - Document production migration steps

## Deliverables
- [ ] Initial EF Core migration created
- [ ] Migration tested on development database
- [ ] DbInitializer updated to seed data only
- [ ] Program.cs configured to apply migrations in development
- [ ] Migration process documented
- [ ] Production migration strategy documented
- [ ] Rollback procedure documented
- [ ] All database operations work with migrations

## Acceptance Criteria
- Migration creates correct database schema
- All tables, indexes, and relationships are correct
- Seed data works correctly
- Can create new migrations successfully
- Can apply and rollback migrations
- Documentation is clear and complete
- Production migration plan is ready
- No data loss during migration

## Estimated Effort
1 day

## Notes
- Always back up database before migration
- Test migrations on non-production data first
- Keep migrations small and focused
- Use meaningful migration names
- Never modify applied migrations
- Consider zero-downtime deployment strategies
- Document any manual steps needed for production
- Test rollback procedure thoroughly
- Consider using migration bundles for production deployment
