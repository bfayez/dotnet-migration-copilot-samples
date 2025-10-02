# Task: Export Schema and Data from LocalDB

## Phase
Phase 2: Azure Services Integration (Week 1)

## Description
Export the database schema and data from LocalDB in preparation for migration to Azure SQL Database.

## Objectives
- Export complete database schema
- Export all data with referential integrity
- Validate exported data
- Create backup scripts
- Document export process

## Prerequisites
- Phase 1 completed (application functional on .NET 9)
- EF Core migrations created
- Access to LocalDB instance
- SQL Server Management Studio or Azure Data Studio

## Dependencies
- Phase 1: Task 12 - Create and Apply EF Core Migrations

## Tasks
1. **Prepare for Export:**
   - Back up current LocalDB database
   - Document database schema
   - Identify data dependencies
   - Plan export strategy

2. **Export Using EF Core Migrations:**
   - Generate migration script
   ```bash
   dotnet ef migrations script -o migration.sql
   ```
   - Review generated SQL script
   - Verify all tables and relationships
   - Save script for deployment

3. **Alternative: Export Using SQL Server Tools:**
   - Use SSMS to generate scripts
   - Include schema and data
   - Configure script options
   - Export to SQL files

4. **Export Data:**
   - Use BCP or SSMS to export data
   - Export in correct dependency order
   - Include all referential constraints
   - Verify data completeness

5. **Create Seed Data Script:**
   - Export sample/test data
   - Create INSERT statements
   - Maintain referential integrity
   - Test script locally

6. **Validate Export:**
   - Verify all tables included
   - Check all data exported
   - Verify foreign key relationships
   - Check for any missing objects

7. **Create Rollback Script:**
   - Create script to rollback migration
   - Test rollback on copy of database
   - Document rollback procedure

8. **Document Export Process:**
   - Document steps taken
   - Note any issues encountered
   - Create checklist for production export
   - Document data volumes

## Deliverables
- [ ] Database schema export script
- [ ] Data export completed
- [ ] EF Core migration script generated
- [ ] Seed data script created
- [ ] Export validated
- [ ] Rollback script created
- [ ] Export process documented
- [ ] Backup of LocalDB created

## Acceptance Criteria
- Complete schema exported successfully
- All data exported with integrity
- Migration script runs without errors
- Seed data script works correctly
- Export is complete and validated
- Documentation is clear
- Rollback procedure tested

## Estimated Effort
1 day

## Notes
- Always create backups before export
- Test exported scripts on fresh database
- Verify row counts match source
- Handle IDENTITY columns correctly
- Export in dependency order for foreign keys
- Consider data size and compression
- Document any transformations needed
- Test import on local SQL Server first
