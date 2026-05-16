# Spring Boot API Engineering Rules

## Core Principles

- Always generate production-grade code.
- Follow clean architecture.
- Prioritize security first.
- Avoid shortcuts and anti-patterns.
- Write maintainable, scalable, testable code.
- Use Java 21 and Spring Boot 3+.
- Prefer constructor injection over field injection.
- Follow SOLID principles.
- Keep business logic inside services only.
- Controllers must remain thin.
- Never place logic inside entities.

---

# Project Structure

Use this package structure:

com.company.project
│
├── config
├── controller
├── service
│   ├── impl
├── repository
├── dto
│   ├── request
│   ├── response
├── entity
├── mapper
├── security
├── exception
├── validation
├── util
├── constants
└── audit

---

# API Standards

- Use RESTful conventions.
- Use plural resource naming.
- Use versioned APIs:
  /api/v1/products

- Return proper HTTP status codes.

Examples:
200 OK
201 CREATED
204 NO CONTENT
400 BAD REQUEST
401 UNAUTHORIZED
403 FORBIDDEN
404 NOT FOUND
409 CONFLICT
500 INTERNAL SERVER ERROR

- Never expose internal exception details.

- Use consistent API response structure:

{
  "timestamp": "",
  "success": true,
  "message": "",
  "data": {}
}

---

# Controller Rules

- Controllers must only:
  - validate request
  - call service
  - return response

- Never write business logic in controllers.
- Always use DTOs.
- Never expose entities directly.
- Use @Valid for request validation.
- Use ResponseEntity.

---

# Service Rules

- Business logic belongs only in services.
- Services must be interface-driven.
- Use transactions where required.
- Avoid large methods.
- Follow single responsibility principle.

---

# Entity Rules

- Use UUID primary keys.
- Never expose entities to APIs.
- Avoid bidirectional relationships unless necessary.
- Use LAZY loading by default.
- Never store sensitive plaintext data.
- Use auditing fields:
  createdAt
  updatedAt
  createdBy

Example:
@CreationTimestamp
@UpdateTimestamp

---

# DTO Rules

Always separate:
- Request DTOs
- Response DTOs

Never reuse entity classes as DTOs.

Use validation annotations:

@NotBlank
@NotNull
@Email
@Size
@Pattern

---

# Validation Rules

- Validate all incoming requests.
- Never trust client input.
- Sanitize strings where required.
- Add centralized validation handling.

Return readable validation errors.

---

# Exception Handling

Use centralized exception handling.

Create:
- GlobalExceptionHandler

Handle:
- ValidationException
- ResourceNotFoundException
- AccessDeniedException
- IllegalArgumentException
- DataIntegrityViolationException

Never expose stack traces in API responses.

---

# Security Rules

## Authentication

- Use Spring Security.
- Prefer JWT authentication.
- Use stateless sessions.
- Store JWT secret securely.
- Never hardcode secrets.

## Passwords

- Hash passwords using BCrypt.
- Never log passwords.
- Never return passwords.

## Authorization

- Use role-based access control.
- Apply method-level security:
  @PreAuthorize

## Input Security

- Prevent SQL Injection.
- Prevent XSS.
- Prevent CSRF where applicable.
- Validate all user inputs.

## Sensitive Data

Never expose:
- passwords
- tokens
- secrets
- internal IDs
- stack traces

## Headers

Add security headers:
- Content-Security-Policy
- X-Frame-Options
- X-Content-Type-Options

## Rate Limiting

Apply rate limiting for:
- auth APIs
- public APIs

## Logging Security

- Never log sensitive data.
- Mask confidential information.

---

# Database Rules

- Use PostgreSQL.
- Use Flyway or Liquibase migrations.
- Never use ddl-auto=create in production.
- Add indexes for frequently queried fields.
- Use pagination for large datasets.
- Avoid N+1 query problems.

---

# JPA Rules

- Prefer JPQL or Specification APIs.
- Avoid excessive eager loading.
- Use projections when possible.
- Optimize query performance.

---

# Logging Rules

Use SLF4J.

Log:
- startup events
- security events
- failures
- important business events

Do NOT log:
- passwords
- tokens
- sensitive payloads

Use structured logging.

---

# API Documentation

Use OpenAPI / Swagger.

Requirements:
- endpoint descriptions
- request examples
- response examples
- error examples

---

# Testing Rules

Write:
- unit tests
- integration tests

Use:
- JUnit 5
- Mockito
- Testcontainers

Minimum coverage:
- services
- controllers
- security

---

# Performance Rules

- Use caching where required.
- Enable compression.
- Optimize DB queries.
- Avoid unnecessary object creation.
- Use async processing for heavy tasks.

---

# Docker Rules

- Use multi-stage Docker builds.
- Keep images lightweight.
- Never store secrets in Docker images.
- Use environment variables.

---

# Configuration Rules

Use:
application.yml

Separate configs:
- dev
- staging
- prod

Never commit:
- secrets
- API keys
- passwords

Use:
.env
Vault
AWS Secrets Manager

---

# Production Readiness

Must include:
- health checks
- readiness checks
- graceful shutdown
- metrics
- monitoring
- audit logging

Use:
Spring Boot Actuator

---

# Observability

Add:
- centralized logging
- tracing
- metrics

Preferred:
- Prometheus
- Grafana
- OpenTelemetry

---

# Code Quality

- Keep methods small.
- Avoid duplicate code.
- Prefer composition over inheritance.
- Follow naming conventions.
- Write readable code.
- Avoid magic numbers.

---

# Naming Conventions

Classes:
ProductService

Methods:
getProductById

Variables:
productName

Constants:
MAX_RETRY_COUNT

---

# Forbidden Practices

Never:
- expose entities directly
- hardcode secrets
- disable security
- trust client input
- catch generic Exception unnecessarily
- use field injection
- return stack traces
- commit credentials
- use System.out.println

---

# Recommended Dependencies

- spring-boot-starter-web
- spring-boot-starter-security
- spring-boot-starter-validation
- spring-boot-starter-data-jpa
- spring-boot-starter-actuator
- postgresql
- lombok
- mapstruct
- jjwt

---

# Preferred Patterns

Use:
- DTO pattern
- Mapper pattern
- Service layer pattern
- Specification pattern
- Factory pattern where applicable

Avoid:
- God classes
- Fat controllers
- Tight coupling

---

# AI Code Generation Instructions

When generating code:
- Always generate complete production-ready implementations.
- Include validation.
- Include exception handling.
- Include security best practices.
- Include proper imports.
- Include clean architecture.
- Include comments only where useful.
- Generate scalable code.
- Prefer readability over cleverness.

Always assume:
- production environment
- public internet exposure
- enterprise-scale usage