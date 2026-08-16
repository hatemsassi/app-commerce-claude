---
description: Verify every @RestController method returns a DTO, not an entity
---

Check every @RestController method in this project.
Every return type must be a DTO, ResponseEntity<DTO>, or List<DTO> — never an entity.
Report any violations with file name and line number.
