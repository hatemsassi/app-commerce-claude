---
description: Find DB-writing @Service methods missing @Transactional
---

Review all @Service classes in this project.
Find any public method that writes to the database (save, delete, update operations)
without @Transactional. List them: class name, method name, recommendation.
