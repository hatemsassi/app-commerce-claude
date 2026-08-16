---
description: Scan services and repositories for N+1 query risks
---

Scan all @Service and @Repository classes for N+1 query risks.
Look for: collections accessed inside loops, lazy relationships fetched in
toResponse() mapping, missing JOIN FETCH in JPQL.
Report: class, method, risk, suggested fix.
