# ksfinalb -- https://www.baeldung.com/java-neo4j -- Embedded Neo4J
https://stackoverflow.com/questions/24412434/it-is-possible-to-start-an-embedded-instance-of-apache-spark-node -- Apache Spark Embedded Server <br />
https://github.com/zestprime/springboot/tree/main/spring-ai-rag-db --- https://www.youtube.com/watch?v=WAx9W2rwgYU --- Spring AI - Build Chatbot for your Database using RAG pattern with locally running Ollama LLM model <br />
https://github.com/danvega/java-rag --- https://www.youtube.com/watch?v=6Pgmr7xMjiY --- Java + RAG: Create an AI-Powered Financial Advisor using Spring AI <br />
https://community.taiga.io/t/taiga-30min-setup/170 --- Taiga: Your opensource agile project management software --- https://developers.plane.so/self-hosting/overview -- Plane tool <br />
## Application Access Table

| Application    | Web Access (Public)                          | Web Access (After Login) | API Access (Public)         | API Access (Protected, JWT) | Mobile Access (Public)                        | Mobile Access (After Login) | API Access (Public)         | API Access (Protected, JWT) |
|----------------|----------------------------------------------|--------------------------|-----------------------------|-----------------------------|-----------------------------------------------|-----------------------------|-----------------------------|-----------------------------|
| dental_hygiene | `/login` (no session)                        | `/dh/web` (session)      | `/register`                 | `/dh/api` (JWT token)       | `/login` (no session)                         | `/dh/mobile` (session)      | `/register`                 | `/dh/api` (JWT token)       |
| ksm            | `/login` (no session)                        | `/ksm/web` (session)     | `/register`                 | `/ksm/api` (JWT token)      | `/login` (no session)                         | `/ksm/mobile` (session)     | `/register`                 | `/ksm/api` (JWT token)      |
| shoppingcart   | `/login` (no session)                        | `/sc/web` (session)      | `/register`                 | `/sc/api` (JWT token)       | `/login` (no session)                         | `/sc/mobile` (session)      | `/register`                 | `/sc/api` (JWT token)       |
| blogs          | `/login` (no session)                        | `/blog/web` (session)    | `/register`                 | `/blog/api` (JWT token)     | `/login` (no session)                         | `/blog/mobile` (session)    | `/register`                 | `/blog/api` (JWT token)     |
| GIG            | `/login` (no session)                        | `/gig/web` (session)     | `/register`                 | `/gig/api` (JWT token)      | `/login` (no session)                         | `/gig/mobile` (session)     | `/register`                 | `/gig/api` (JWT token)      |

## dental_hygiene: Roles & URL Access Table

| Role         | Can Access `/add_doctor` | Can Access `/add_patient`         | Can Access `/add_staff` | Can Access `/add_prescription` |
|--------------|-------------------------|-----------------------------------|------------------------|-------------------------------|
| **ADMIN**    | Yes                     | No                                | No                     | No                            |
| **SUPERADMIN** | Yes                   | Yes (also available to all users without login) | Yes                | No                            |
| **DOCTOR**   | No                      | No                                | No                     | Yes                           |
| **PATIENT**  | No                      | No                                | No                     | No                            |
| **STAFF**    | No                      | No                                | No                     | No                            |

> **Note:**
> - `/add_patient` is accessible to **SUPERADMIN** and **all users (even without login)**.
> - `/add_staff` is accessible **only to SUPERADMIN**.
> - `/add_doctor` is accessible to **ADMIN and SUPERADMIN**.
> - `/add_prescription` is accessible **only to DOCTOR**.

## ksmatri: Roles & URL Access Table

| Role                | Can Access `/add_regionalcenter` | Can Access `/add_profile`         | Can Access `/approve_regionalcenter` | Can Access `/search_grooms` | Can Access `/search_brides` | Can Access `/approve_profile` |
|---------------------|----------------------------------|-----------------------------------|--------------------------------------|-----------------------------|-----------------------------|-------------------------------|
| **ADMIN**           | Yes                              | No                                | No                                   | No                          | No                          | No                            |
| **SUPERADMIN**      | Yes                              | No                                | Yes                                  | No                          | No                          | No                            |
| **BRIDE**           | No                               | No                                | No                                   | Yes                         | No                          | No                            |
| **GROOM**           | No                               | No                                | No                                   | No                          | Yes                         | No                            |
| **REGIONAL_CENTER** | No                               | No                                | No                                   | No                          | No                          | Yes                           |

> **Note:**
> - `/add_profile` is accessible to **all users (even without login)**.
> - `/add_regionalcenter` is accessible to **ADMIN and SUPERADMIN**.
> - `/approve_regionalcenter` is accessible **only to SUPERADMIN**.
> - `/search_grooms` is accessible **only to BRIDE**.
> - `/search_brides` is accessible **only to GROOM**.
> - `/approve_profile` is accessible **only to REGIONAL_CENTER**.

Until REGIONAL_CENTER can't get approved by SUPERADMIN, It can approve profiles.

> **State Transition:**
> - **States:** `Represent the different conditions or situations of a system at a given time.`
> - **Events:** `Trigger transitions between states.`
> - **Transitions:** `The movement from one state to another, often associated with actions.`
> - **Guards:** `Conditions that must be met for a transition to occur.`
> - **Actions:** `Code executed as a result of a transition.`

<meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'nonce-RandomValue'; style-src 'self'; object-src 'none';">
<script nonce="RandomValue" type="text/javascript"></script>
