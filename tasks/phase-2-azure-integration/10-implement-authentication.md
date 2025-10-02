# Task: Implement Azure AD B2C Authentication

## Phase
Phase 2: Azure Services Integration (Week 3)

## Description
Implement Azure AD B2C authentication in the application, replacing Windows Authentication.

## Objectives
- Add Microsoft.Identity.Web packages
- Configure authentication middleware
- Update controllers with [Authorize] attributes
- Convert role-based to claims-based authorization
- Test authentication flows

## Prerequisites
- Azure AD B2C tenant configured
- Application registered
- User flows created

## Dependencies
- Phase 2: Task 09 - Set Up Azure AD B2C Tenant

## Tasks
1. Add Microsoft.Identity.Web and Microsoft.Identity.Web.UI packages
2. Configure authentication in Program.cs
3. Add Azure AD B2C settings to appsettings.json
4. Configure authentication middleware
5. Update [Authorize] attributes on controllers
6. Implement claims-based authorization
7. Update _Layout.cshtml with sign-in/sign-out links
8. Test sign-in flow
9. Test sign-out flow
10. Test authorized and unauthorized access
11. Remove Windows Authentication
12. Document authentication setup

## Estimated Effort
2-3 days

## Acceptance Criteria
- Users can sign in with Azure AD B2C
- Users can sign out
- Authorized pages require authentication
- Claims are properly populated
- Windows Authentication is removed
- Documentation is complete
