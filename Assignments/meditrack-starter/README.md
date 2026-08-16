# MediTrack — Starter (intentionally rough)

A clinic appointment & billing API. **This starter is deliberately messy** — it
works, but it breaks most of the conventions taught in the course. Your job is to
use Claude Code to refactor it and then extend it.

## Run it
1. Run `db/meditrack_schema.sql` in MySQL Workbench (creates `meditrack_db` + seed data).
2. Run it from your IDE (Spring Boot Extension Pack / IntelliJ), or `mvn spring-boot:run`. (No Maven wrapper is bundled — your first refactor task can be to add one with `mvn -N wrapper:wrapper`.)
3. Try it:
   - `GET  http://localhost:8080/doctors`
   - `GET  http://localhost:8080/patients`
   - `POST http://localhost:8080/appointments/book?patientId=1&doctorId=1&date=2026-08-01`
   - `POST http://localhost:8080/appointments/1/cancel`

## What's wrong with it (on purpose)
- Money stored as `double` instead of `BigDecimal`
- `@Data` on JPA entities; entities returned straight from controllers (no DTOs)
- All business logic lives in the controllers; no service layer
- No exception handling — missing rows return `null`, errors are generic `RuntimeException` (HTTP 500)
- Field injection with `@Autowired`
- `ddl-auto=update` and a plain-text DB password in `application.properties`
- Appointment `status` is free text with no transition rules
- `cancel` doesn't restore the doctor's slot or refund a payment
- No tests, no API docs, no validation

> Do **not** start by hand-fixing these. Follow the assignment brief — you'll set up
> a `CLAUDE.md` with `/init`, add rules, and let Claude do the refactoring.
