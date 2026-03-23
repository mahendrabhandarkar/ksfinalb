# Objective: Multi-Tenant Architecture & Thymeleaf Integrations

The goal is to implement a multi-module access control system comprising `dental_hygiene`, `ksm`, `shoppingcart`, `blogs`, and `GIG`. This requires defining varying web, API, and mobile access patterns, configuring JWT with a `tenant` claim for tenant context, integrating Thymeleaf for web interfaces adhering to CSP guidelines, and building sample controllers with strict Role-Based Access Control (RBAC).

## Proposed Changes

### Configuration & Dependencies
#### [MODIFY] [pom.xml](file:///d:/ksfinalb/pom.xml)
- Add the `spring-boot-starter-thymeleaf` dependency to enable Thymeleaf templating for the web modules.

### Security & JWT Enhancements
#### [MODIFY] [JwtUtils.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/security/jwt/JwtUtils.java)
- Update [generateTokenForUser](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/security/jwt/JwtUtils.java#27-43) to include a `tenant` claim to differentiate which module's API is being accessed (e.g., `DENTAL_HYGIENE`, `KSM`, etc.).
- Update [validateToken](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/security/jwt/JwtUtils.java#57-71) and claim extractors to expose the `tenant` type.

#### [MODIFY] [AuthTokenFilter.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/security/jwt/AuthTokenFilter.java)
- Extract the `tenant` claim from the validated JWT.
- Set up a custom `TenantContextHolder` (to be created) to pass the tenant context down to controllers so each module knows its context.

#### [MODIFY] [LoginRequest.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/request/LoginRequest.java)
- Add a `tenant` field so API/Mobile clients can specify which module they are authenticating against when fetching a JWT token.

#### [MODIFY] [ShopConfig.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/security/config/ShopConfig.java)
- Add Content-Security-Policy (CSP) headers adhering to global standards (e.g., prohibiting inline scripts with `script-src 'self' 'nonce-...'`, restricting `object-src`, and blocking framing with `frame-ancestors 'none'`) to all protected and public endpoints.
- Add base security rules to permit web UI paths (e.g., `/dh/web/**`, `/login`) while restricting API endpoints (`/dh/api/**`) behind the JWT filter, keeping RBAC enforcement explicit.

### Multi-Tenant Core Services
#### [NEW] [TenantContextHolder.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/security/jwt/TenantContextHolder.java)
- A `ThreadLocal` based utility to hold the current request's tenant.

#### [NEW] [TenantEnum.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/enums/TenantEnum.java)
- Defining `DENTAL_HYGIENE`, `KSM`, `SHOPPINGCART`, `BLOGS`, `GIG`.

### API & Web Controllers with RBAC and Mobile APIs
Each module will have a set of identical architectural patterns: Web paths (Thymeleaf with Session), Web API (JWT-protected), Mobile Web (Session), and Mobile API (JWT-protected). Note that Mobile APIs will use the same backend endpoints as the standard API, differing by client interaction.

#### [NEW] [DentalHygieneControllers.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/controller/dental/DentalHygieneControllers.java)
- **Web & Mobile Session**: `/dh/web`, `/dh/mobile`
- **Mobile & Web APIs (JWT protected)**: `/dh/api/**`. Mobile Flutter app points to these APIs.
- **RBAC Rules**:
  - `POST /dh/api/add_doctor` [JWT Required]: Role `ADMIN` or `SUPERADMIN`.
  - `POST /dh/api/add_patient` [Public/Open]: Open to all (no login required) or `SUPERADMIN`.
  - `POST /dh/api/add_staff` [JWT Required]: Role `SUPERADMIN`.
  - `POST /dh/api/add_prescription` [JWT Required]: Role `DOCTOR`.

#### [NEW] [KsmatriControllers.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/controller/ksm/KsmatriControllers.java)
- **Web & Mobile Session**: `/ksm/web`, `/ksm/mobile`
- **Mobile & Web APIs (JWT protected)**: `/ksm/api/**`. Mobile Flutter app points to these APIs.
- **RBAC Rules**:
  - `POST /ksm/api/add_regionalcenter` [JWT Required]: Role `ADMIN` or `SUPERADMIN`.
  - `POST /ksm/api/add_profile` [Public/Open]: Open to all users without login.
  - `POST /ksm/api/approve_regionalcenter` [JWT Required]: Role `SUPERADMIN`.
  - `GET /ksm/api/search_grooms` [JWT Required]: Role `BRIDE`.
  - `GET /ksm/api/search_brides` [JWT Required]: Role `GROOM`.
  - `POST /ksm/api/approve_profile` [JWT Required]: Role `REGIONAL_CENTER`.

#### [NEW] [ShoppingCartControllers.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/controller/shop/ShoppingCartControllers.java)
- **Web & Mobile Session**: `/sc/web`, `/sc/mobile`
- **Mobile & Web APIs (JWT protected)**: `/sc/api/**`. Mobile Flutter app points here.
- **RBAC Rules**:
  - `GET /sc/api/products` [Public/Open]: Open to all users.
  - `POST /sc/api/checkout` [JWT Required]: Role `USER` or `CUSTOMER`.
  - `POST /sc/api/products` [JWT Required]: Role `ADMIN`.

#### [NEW] [BlogControllers.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/controller/blog/BlogControllers.java)
- **Web & Mobile Session**: `/blog/web`, `/blog/mobile`
- **Mobile & Web APIs (JWT protected)**: `/blog/api/**`.
- **RBAC Rules**:
  - `GET /blog/api/posts` [Public/Open]: Open to all users.
  - `POST /blog/api/posts` [JWT Required]: Role `AUTHOR` or `ADMIN`.
  - `DELETE /blog/api/posts/{id}` [JWT Required]: Role `ADMIN`.

#### [NEW] [GigControllers.java](file:///d:/ksfinalb/src/main/java/com/ks/ksfinalb/controller/gig/GigControllers.java)
- **Web & Mobile Session**: `/gig/web`, `/gig/mobile`
- **Mobile & Web APIs (JWT protected)**: `/gig/api/**`.
- **RBAC Rules**:
  - `GET /gig/api/listings` [Public/Open]: Open to all users.
  - `POST /gig/api/apply` [JWT Required]: Role `FREELANCER`.
  - `POST /gig/api/create_gig` [JWT Required]: Role `CLIENT`.

### Web UI Designs (Thymeleaf Templates)
The UI templates will strictly incorporate `<meta http-equiv="Content-Security-Policy" content="...">` rules and utilize Nonces for any required JS, adhering to [Standards.md](file:///d:/ksfinalb/Standards.md). We will create clean, responsive bootstrap/material designs.
#### [NEW] [dental_dashboard.html](file:///d:/ksfinalb/src/main/resources/templates/dental_dashboard.html)
#### [NEW] [shop_index.html](file:///d:/ksfinalb/src/main/resources/templates/shop_index.html)
#### [NEW] [blog_home.html](file:///d:/ksfinalb/src/main/resources/templates/blog_home.html)
#### [NEW] [gig_board.html](file:///d:/ksfinalb/src/main/resources/templates/gig_board.html)

## Verification Plan

### Automated Tests
- Provide tests checking endpoint restrictions against the roles, including CSP headers.
- Test JWT creation confirming `tenant` is preserved and successfully rejected when accessing a mismatched module's API (e.g., using a `KSM` token to access `/dh/api`).

### Manual Verification
- Deploy and verify Thymeleaf renders with strict Content Security Policies via browser dev tools.
- Send API requests to `/dh/api` and verify access depending on whether `ADMIN`, `DOCTOR`, or `PATIENT` roles are present in the provided JWT.
