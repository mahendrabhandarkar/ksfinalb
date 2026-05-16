# SECURITY SPEC - MATRIMONIAL PLATFORM

## AUTH SECURITY

- JWT token based authentication
- Refresh token rotation enabled
- Session expiration enforced

---

## PASSWORD SECURITY

- BCrypt hashing only
- Minimum strength validation
- No password logging ever

---

## API SECURITY

- Rate limiting per IP/user
- Input validation mandatory
- CORS properly configured

---

## DATA SECURITY

- Encrypt sensitive user data
- Mask personal data in logs
- No PII exposure in APIs

---

## ATTACK PROTECTION

Protect against:
- SQL Injection
- XSS
- CSRF
- Brute force attacks
- IDOR vulnerabilities

---

## LOGGING RULES

- No sensitive data logs
- Log only metadata
- Use structured logging