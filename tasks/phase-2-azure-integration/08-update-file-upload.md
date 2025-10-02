# Task: Update File Upload to Use Azure Blob Storage

## Phase
Phase 2: Azure Services Integration (Week 2)

## Description
Replace local file system storage with Azure Blob Storage for teaching material uploads.

## Objectives
- Add Azure.Storage.Blobs SDK
- Update CoursesController file upload logic
- Implement blob upload/download methods
- Generate SAS tokens for secure access
- Update views to display blob URLs
- Remove local file system dependencies

## Prerequisites
- Blob Storage account and container created
- Connection string available
- Current file upload code reviewed

## Dependencies
- Phase 2: Task 07 - Create Azure Blob Storage Account and Container

## Tasks
1. Add Azure.Storage.Blobs NuGet package
2. Create BlobStorageService with upload/download/delete methods
3. Register BlobStorageService in DI container
4. Update CoursesController Create/Edit actions to use blob storage
5. Generate SAS tokens for secure file access
6. Update views to use blob URLs instead of local paths
7. Implement file deletion when course is deleted or file replaced
8. Test file upload, download, and deletion
9. Remove local file system upload code
10. Update documentation

## Estimated Effort
2-3 days

## Acceptance Criteria
- Files upload to Blob Storage successfully
- Files are accessible via SAS URLs
- Old files are deleted properly
- No local file system dependencies remain
- All tests pass
