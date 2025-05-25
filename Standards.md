Coding Standards:
1. Use of Pure Javascript instead of JQuery, etc. Use Javascript handlers with catch errors.
2. Create Fallback method for WebClient API. And use onErrorResume method in fallback.
3. Use HtmlUtils.htmlEscape() or OWASP Java Encoder to prevent malicious scripts. XSS attack.
4. https://www.baeldung.com/java-maven-owasp-dependency-check -- check CVSS report
5. https://www.baeldung.com/spring-security-block-brute-force-authentication-attempts Brute Force Attempt, Implement Rate-Limit
6. X-Frame-Options or Content-Security-Policy header added.
7. Don't use @PathVariable instead of that use @RequestParam
8. Insecure direct object references (IDOR) attack
9. XSS Attack and Re-Captcha / xCaptcha.
10. Upload file types and double file extensions should be prevented.
11. Add No Javascript enable code
12. Git Repo for configuration used for flutter mobile app, website, etc.
13. WordPress Salt key concept for security.
14. NLWeb: It's create a rich natural language interface for websites using the model of their choice and their own data. It is the fastest and easiest way to effectively turn your website into AI app, allowing query the contents of the site by directly using natural language, just like with an AI assistant or Copilot. NLWeb leverages semi-structured formal like Schema.org, JSONL, Web Scrapper, RSS and other data that websites already publish. http://www.github.com/microsoft/NLWeb
15. Use Spring Hateoas for Hypermedia driven links [Helps to get response in different formats Json, XML, etc]
16. Use feature flags in code and mobile app. Use openfeature [open standard for feature flagging] with spring boot.
17. Material Design for bootstrap [mdb.min.js and mdb-ui-kit] http://m3.material.io -- https://esm.run/@material/web/all.js / https://unpkg.com/@material/web/textfield/outlined-text-field.js?module -- http://github.com/material-components/material-web
18. 