# Task: Add Health Checks and Security Hardening

## Phase
Phase 3: Testing and Quality (Week 2)

## Description
Implement health checks, rate limiting, CSRF protection, and other security enhancements.

## Objectives
- Add health check endpoints
- Implement rate limiting
- Add CSRF protection
- Add security headers
- Perform security scan

## Dependencies
- Phase 3: Task 05 - Implement Structured Logging with Serilog

## Tasks
1. Add health checks for database, Service Bus, Blob Storage
2. Expose health check endpoint (/health)
3. Add AspNetCoreRateLimit package
4. Configure rate limiting middleware
5. Enable anti-forgery tokens in forms
6. Add security headers middleware (HSTS, CSP, etc.)
7. Configure CORS appropriately
8. Run security scan (OWASP ZAP or similar)
9. Fix identified vulnerabilities
10. Document security measures

## Estimated Effort
2-3 days

## Acceptance Criteria
- Health checks are functional
- Rate limiting works
- CSRF protection enabled
- Security headers configured
- Security scan passed
- Documentation complete
