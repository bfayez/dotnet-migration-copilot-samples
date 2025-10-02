# Task: Run Database Migrations on Azure SQL

## Phase
Phase 2: Azure Services Integration (Week 1)

## Description
Apply EF Core migrations to Azure SQL Database and import seed data for development and testing.

## Objectives
- Apply EF Core migrations to Azure SQL
- Import seed data
- Verify database schema
- Test database operations
- Document migration process

## Prerequisites
- Azure SQL Database created
- EF Core migrations ready
- Database export scripts ready
- Connection string available

## Dependencies
- Phase 2: Task 02 - Create Azure SQL Database

## Tasks
1. **Update Connection String:**
   - Get Azure SQL connection string from portal
   - Add to appsettings.Development.json
   - Store in user secrets locally
   - Verify connection string format
   ```json
   {
     "ConnectionStrings": {
       "DefaultConnection": "Server=tcp:sql-contoso-dev.database.windows.net,1433;Initial Catalog=ContosoUniversity;..."
     }
   }
   ```

2. **Test Connection:**
   - Test connection from application
   - Verify firewall allows connection
   - Test with SQL Server Management Studio
   - Resolve any connection issues

3. **Apply Migrations Using EF Core:**
   - Run migration command
   ```bash
   dotnet ef database update --connection "connection_string"
   ```
   - Verify migration applied successfully
   - Check for errors in output
   - Verify all tables created

4. **Alternative: Apply Migration Script:**
   - Run generated migration.sql script
   - Execute using SSMS or Azure Data Studio
   - Verify execution completed
   - Check for errors

5. **Verify Schema:**
   - Connect to Azure SQL with SSMS
   - Verify all tables exist
   - Check indexes and constraints
   - Verify foreign key relationships
   - Check column types and nullability

6. **Import Seed Data:**
   - Run DbInitializer seed logic
   - Or execute seed data SQL script
   - Verify data imported correctly
   - Check referential integrity

7. **Verify Data:**
   - Query tables to verify data
   - Check row counts
   - Verify relationships between tables
   - Test sample queries

8. **Update Application Configuration:**
   - Update connection string in application
   - Test application with Azure SQL
   - Verify CRUD operations work
   - Test all major features

9. **Configure Migration Automation:**
   - Update Program.cs to apply migrations on startup (dev only)
   - Test automatic migration application
   - Document manual migration process for production

10. **Test Database Operations:**
    - Test Create operations
    - Test Read operations
    - Test Update operations
    - Test Delete operations
    - Test complex queries with joins
    - Test pagination and sorting

11. **Performance Testing:**
    - Compare performance with LocalDB
    - Test query response times
    - Monitor DTU usage
    - Identify slow queries

## Deliverables
- [ ] Connection string configured
- [ ] Migrations applied to Azure SQL
- [ ] Database schema verified
- [ ] Seed data imported
- [ ] Application connected to Azure SQL
- [ ] All CRUD operations tested
- [ ] Performance benchmarks documented
- [ ] Migration process documented

## Acceptance Criteria
- Database schema matches local database
- All migrations applied successfully
- Seed data imported correctly
- Application connects to Azure SQL
- All database operations work
- Performance is acceptable
- No errors in application logs
- Documentation is complete

## Estimated Effort
1 day

## Notes
- Always back up before running migrations
- Test migrations on dev database first
- Monitor DTU usage during testing
- Keep LocalDB as backup during transition
- Document any performance issues
- Plan for production migration separately
- Use connection resiliency in application
- Test error scenarios (connection failures, timeouts)
- Consider using migration bundles for production
