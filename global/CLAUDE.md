# Java Conventions

## Stack
- Java 21
- Spring Boot 4.1.0
- Maven

## Dependency Injection
- Always use `@RequiredArgsConstructor` with `final` fields.
- Never use `@Autowired`.

## Entities
- Annotate with `@Getter @Setter @Builder @NoArgsConstructor @AllArgsConstructor`.
- Never use `@Data` on entities.

## DTOs
- Annotate with `@Data @Builder @NoArgsConstructor @AllArgsConstructor`.

## Money
- Always use `BigDecimal` for money fields.
- Never use `double` or `float`.

## Tests
- JUnit 5, Mockito, AssertJ, MockMvc.
- Always use AssertJ `assertThat`.
- Never use `assertEquals`.

## Communication Style
- Show diffs, not full rewrites.
- Ask before deleting any file.
- Be direct and technical.
