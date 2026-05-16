# Enterprise Thymeleaf + Spring Boot Microservices Engineering Rules

# PURPOSE

Generate production-grade enterprise applications using:
- Java 21
- Spring Boot 3+
- Thymeleaf
- Spring Security
- Microservice-oriented architecture
- PostgreSQL
- Redis
- Docker
- Kubernetes-ready deployment
- Responsive UI
- PWA support
- Enterprise-grade security

Applications must be:
- scalable
- secure
- responsive
- maintainable
- cloud-ready
- accessible
- production-ready

---

# CORE ARCHITECTURE PRINCIPLES

Always follow:
- Clean Architecture
- Domain-driven modularization
- SOLID principles
- Separation of concerns
- API-first design
- Security-first engineering

Never:
- generate monolithic tightly-coupled logic
- place business logic in controllers
- expose internal entities directly
- hardcode secrets

---

# MICROSERVICE ARCHITECTURE RULES

Use service-oriented boundaries.

Preferred services:
- auth-service
- user-service
- product-service
- order-service
- notification-service
- gateway-service
- config-service
- discovery-service

Each microservice must contain:
- controller
- service
- repository
- dto
- mapper
- security
- config
- exception

Services must:
- be independently deployable
- own their own database
- communicate via REST or messaging

---

# API GATEWAY RULES

Use:
- Spring Cloud Gateway

Gateway responsibilities:
- routing
- authentication validation
- rate limiting
- logging
- request tracing

Never expose internal services directly.

---

# SERVICE DISCOVERY RULES

Use:
- Eureka Server

Services must:
- self-register
- support dynamic discovery

---

# CONFIGURATION RULES

Use:
- Spring Cloud Config Server

Configuration must support:
- dev
- staging
- production

Never commit:
- secrets
- passwords
- API keys

Use:
- Vault
- AWS Secrets Manager
- environment variables

---

# COMMUNICATION RULES

Preferred:
- REST APIs
- OpenFeign clients

Optional:
- Kafka
- RabbitMQ

Use async messaging for:
- notifications
- analytics
- audit events
- background processing

---

# THYMELEAF UI/UX RULES

Generate:
- premium enterprise-grade UI
- responsive layouts
- reusable fragments
- accessible interfaces

Use:
- Thymeleaf Layout Dialect
- reusable template fragments
- modular page structure

Preferred folders:

templates/
├── layouts
├── fragments
├── pages
├── auth
├── dashboard
├── errors
└── components

---

# THYMELEAF TEMPLATE RULES

Use:
- semantic HTML5
- reusable fragments
- clean componentized templates

Mandatory fragments:
- navbar
- sidebar
- footer
- alerts
- modals
- pagination
- breadcrumbs

Never:
- duplicate layouts
- inline large CSS blocks
- inline large JS blocks

---

# RESPONSIVE DESIGN RULES

Mobile-first responsive design is mandatory.

Use:
- TailwindCSS
- Bootstrap 5 utilities if required

Support:
- mobile
- tablet
- desktop
- ultrawide

Rules:
- responsive grids mandatory
- no horizontal overflow
- adaptive navigation
- collapsible sidebar on mobile

Minimum touch targets:
44x44px

---

# UI DESIGN SYSTEM RULES

Preferred aesthetic:
- Vercel-inspired
- Linear-inspired
- enterprise SaaS style
- clean modern dashboards

Use:
- spacing consistency
- typography hierarchy
- subtle shadows
- rounded corners
- proper visual hierarchy

Avoid:
- cluttered layouts
- outdated admin UI
- excessive animations

---

# DARK MODE RULES

Dark mode support is mandatory.

Use:
- CSS variables
- theme toggling
- persistent theme preference

Support:
- system preference detection

---

# ACCESSIBILITY RULES

WCAG AA compliance required.

Mandatory:
- semantic HTML
- keyboard navigation
- aria-labels
- focus indicators
- proper contrast ratios

Never:
- remove focus outlines without replacement

---

# PWA RULES

Applications must support Progressive Web App features.

Generate:
- manifest.json
- service worker
- installable support
- offline caching

Support:
- offline pages
- app icons
- splash screens

Use:
- Workbox if required

---

# FRONTEND PERFORMANCE RULES

Optimize:
- CSS delivery
- JS loading
- image loading
- caching

Use:
- lazy loading
- deferred scripts
- compressed assets

Target:
- Lighthouse score above 90

---

# SPRING SECURITY RULES

Mandatory:
- Spring Security 6
- JWT authentication
- BCrypt password hashing
- RBAC authorization

Never:
- expose stack traces
- hardcode credentials
- log sensitive data

Implement:
- session protection
- CSRF protection
- secure headers
- rate limiting

---

# SECURITY HEADERS

Always configure:
- Content-Security-Policy
- X-Frame-Options
- X-Content-Type-Options
- Referrer-Policy
- Strict-Transport-Security

---

# AUTHENTICATION RULES

Support:
- JWT auth
- refresh tokens
- remember-me securely
- MFA-ready architecture

Passwords:
- hashed using BCrypt
- never logged
- never exposed

---

# INPUT VALIDATION RULES

Validate:
- all request payloads
- form inputs
- query params
- path variables

Use:
@NotBlank
@NotNull
@Email
@Pattern
@Size

Never trust client-side validation alone.

---

# EXCEPTION HANDLING RULES

Use centralized exception handling.

Generate:
- GlobalExceptionHandler

Handle:
- validation errors
- access denied
- resource not found
- business exceptions
- database exceptions

Never expose:
- internal stack traces

---

# DATABASE RULES

Use:
- PostgreSQL
- Flyway migrations
- UUID primary keys
- indexed queries

Never:
- use ddl-auto=create in production

Optimize:
- pagination
- query performance
- indexing strategy

---

# JPA RULES

Use:
- LAZY loading
- DTO projections
- Specifications API

Avoid:
- N+1 queries
- excessive eager fetching

---

# REDIS RULES

Use Redis for:
- caching
- sessions
- rate limiting
- temporary tokens

---

# LOGGING RULES

Use:
- SLF4J
- structured JSON logging

Log:
- security events
- failures
- audit trails

Never log:
- passwords
- tokens
- secrets

---

# OBSERVABILITY RULES

Mandatory:
- Spring Boot Actuator
- health checks
- metrics
- tracing

Preferred:
- Prometheus
- Grafana
- OpenTelemetry

---

# DOCKER RULES

Generate:
- multi-stage Docker builds
- production-ready containers

Services must:
- run independently
- support environment configs

Never:
- store secrets in images

---

# KUBERNETES RULES

Generate manifests for:
- deployments
- services
- ingress
- config maps
- secrets

Support:
- autoscaling
- rolling deployments

---

# TESTING RULES

Backend:
- unit tests
- integration tests
- security tests

Frontend:
- UI integration tests

Use:
- JUnit 5
- Mockito
- Testcontainers
- Selenium if required

---

# API DOCUMENTATION RULES

Use:
- OpenAPI / Swagger

Include:
- request examples
- response examples
- auth requirements
- error documentation

---

# EMAIL & NOTIFICATION RULES

Use async processing for:
- emails
- SMS
- notifications

Never block main requests.

---

# FILE STORAGE RULES

Preferred:
- S3-compatible storage

Never:
- store large files locally in production

Validate:
- file types
- file size
- content safety

---

# CODE QUALITY RULES

Always:
- keep methods small
- write reusable components
- avoid duplication
- use meaningful naming

Never:
- use God classes
- tightly couple modules

---

# AI GENERATION RULES

When generating code:
- generate complete implementations
- include security best practices
- include responsive UI
- include accessibility
- include validation
- include loading states
- include proper error handling
- include reusable Thymeleaf fragments
- include scalable architecture

Always assume:
- enterprise production deployment
- public internet exposure
- cloud-native deployment
- high traffic usage

---

# FORBIDDEN PRACTICES

Never:
- expose entities directly
- hardcode secrets
- disable CSRF blindly
- trust frontend validation only
- use field injection
- use System.out.println
- commit credentials
- generate insecure auth flows
- generate non-responsive layouts

---

# FINAL OUTPUT EXPECTATIONS

Every generated system must:
- be production-ready
- be microservice-oriented
- support responsive design
- support PWA
- support accessibility
- include enterprise security
- include reusable Thymeleaf architecture
- support scalability
- support cloud deployment
- include observability
- include monitoring
- include clean maintainable structure