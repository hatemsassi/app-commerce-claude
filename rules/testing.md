# Testing Rules
- Test class naming: `[ClassName]Test.java`.
- Use `@ExtendWith(MockitoExtension.class)` for unit tests.
- Use `@WebMvcTest` for controller tests; mock all dependencies with `@MockBean`.
- Follow the AAA pattern, commenting each section:
  ```
  // Arrange
  // Act
  // Assert
  ```
- Test names: `should_[expected]_when_[condition]`.
- One assertion block per test.
- Never test private methods.
