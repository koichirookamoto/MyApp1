# CLAUDE.md - Guidelines for Claude Code Assistant

## Build Commands
- Build: `xcodebuild -project MyApp1.xcodeproj -scheme MyApp1 build`
- Test all: `xcodebuild -project MyApp1.xcodeproj -scheme MyApp1 test`
- Run single test: `xcodebuild -project MyApp1.xcodeproj -scheme MyApp1 test -only-testing:MyApp1Tests/MyApp1Tests/testMethodName`
- Run app: `xcodebuild -project MyApp1.xcodeproj -scheme MyApp1 run`

## Code Style Guidelines
- **Indentation**: 4 spaces (no tabs)
- **Naming**: 
  - Types (classes, structs, enums): `UpperCamelCase`
  - Variables/functions: `lowerCamelCase`
  - Constants: `lowerCamelCase`
- **Imports**: Group framework imports (SwiftUI, Foundation) before @testable imports
- **Testing**: Use `@Test` annotation with async/await pattern for tests
- **SwiftUI**: Follow declarative pattern with modifiers chained on separate lines
- **File Structure**: Follow Xcode default file header format
- **Error Handling**: Use Swift's native try/catch with async/await where appropriate