# MATRIMONIAL PLATFORM - AI DEVELOPMENT RULES

## CORE PRINCIPLE
Always generate production-grade, secure, scalable code.

---

## ARCHITECTURE RULES

- Use microservices strictly
- Each service must be independent
- No shared database between services
- API Gateway is mandatory
- Service communication via REST or Kafka

---

## BACKEND RULES (SPRING BOOT)

- Use Java 21 + Spring Boot 3+
- Follow clean architecture
- Controller must be thin
- Business logic in service layer only
- Use DTOs always (never expose entities)
- Use constructor injection only

---

## SECURITY RULES

- JWT authentication mandatory
- BCrypt password hashing
- Role-based access control (USER, ADMIN, PREMIUM)
- Rate limiting for public APIs
- Validate all inputs strictly
- Never expose stack traces

---

## DATABASE RULES

- PostgreSQL only
- Use Flyway migrations
- UUID as primary keys
- Use indexes for search-heavy fields
- Avoid N+1 queries

---

## FRONTEND RULES (THYMELEAF)

- Use reusable fragments (header, footer, navbar)
- Mobile-first responsive design
- TailwindCSS preferred
- Clean SaaS-style UI
- Dark mode support required

---

## PWA RULES

- Must include manifest.json
- Service worker required
- Offline fallback pages required
- Installable on mobile devices
- Push notifications enabled

---

## API RULES

- RESTful APIs only
- Versioning required (/api/v1/)
- Standard response format:
  {
    "success": true,
    "message": "",
    "data": {}
  }

---

## CODE QUALITY RULES

- No duplicate code
- Small reusable functions
- No God classes
- Follow SOLID principles
- Proper naming conventions

---

## FORBIDDEN

- No hardcoded secrets
- No field injection
- No direct entity exposure
- No insecure auth flows
- No unvalidated input handling