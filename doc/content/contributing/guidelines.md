# Contributing Guidelines

Thank you for your interest in contributing to Flutter Fake Filler! This guide will help you get started with contributing to the project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)

## 🤝 Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct:

- **Be respectful**: Treat everyone with respect and kindness
- **Be inclusive**: Welcome newcomers and help them get started
- **Be constructive**: Provide helpful feedback and suggestions
- **Be patient**: Understand that people have different skill levels and backgrounds

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have:

- Flutter SDK >=3.0.0 installed
- Dart SDK >=3.0.0
- Git installed
- A GitHub account
- Your preferred IDE (VS Code, Android Studio, or IntelliJ)

### Fork and Clone

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/flutter_fake_filler.git
   cd flutter_fake_filler
   ```
3. **Add the upstream remote**:
   ```bash
   git remote add upstream https://github.com/nishansr/flutter_fake_filler.git
   ```

## 🛠️ Development Setup

### Initial Setup

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the example app**:
   ```bash
   cd example
   flutter pub get
   flutter run
   ```

3. **Run tests**:
   ```bash
   flutter test
   ```

### Project Structure

```
flutter_fake_filler/
├── lib/
│   ├── flutter_fake_filler.dart      # Main export file
│   └── src/
│       ├── data_generator.dart       # Data generation logic
│       ├── dummy_data.dart          # Sample data arrays
│       ├── fake_filler_widget.dart  # Main widget
│       └── form_field_detector.dart # Field detection logic
├── test/
│   └── flutter_fake_filler_test.dart # Unit tests
├── example/
│   └── main.dart                    # Example implementation
├── docs/                            # Documentation
└── pubspec.yaml                     # Package configuration
```

## 🎯 How to Contribute

### Types of Contributions

We welcome various types of contributions:

1. **🐛 Bug Fixes** - Fix issues and improve stability
2. **✨ New Features** - Add new functionality
3. **📚 Documentation** - Improve docs and examples
4. **🧪 Tests** - Add or improve test coverage
5. **🔧 Performance** - Optimize existing code
6. **🎨 UI/UX** - Improve user experience

### Finding Issues to Work On

- Check the [GitHub Issues](https://github.com/nishansr/flutter_fake_filler/issues)
- Look for issues labeled:
  - `good first issue` - Perfect for newcomers
  - `help wanted` - Community contributions welcome
  - `bug` - Bug fixes needed
  - `enhancement` - New features
  - `documentation` - Documentation improvements

### Creating Issues

Before creating a new issue:

1. **Search existing issues** to avoid duplicates
2. **Use the issue templates** when available
3. **Provide detailed information**:
   - Clear description of the problem/feature
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Flutter/Dart version information
   - Code samples when relevant

## 🔄 Pull Request Process

### Before You Start

1. **Check existing PRs** to avoid duplicate work
2. **Create or comment on an issue** to discuss your changes
3. **Fork and create a branch** for your changes

### Creating a Pull Request

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes** following our coding standards

3. **Write tests** for your changes

4. **Update documentation** if needed

5. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add new field detection for currency inputs"
   ```

6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request** on GitHub

### PR Requirements

Your pull request must:

- ✅ Pass all existing tests
- ✅ Include tests for new functionality
- ✅ Follow coding standards
- ✅ Update documentation if needed
- ✅ Have a clear, descriptive title
- ✅ Include a detailed description

### PR Template

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Manual testing completed
- [ ] Example app tested

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
```

## 📏 Coding Standards

### Dart Style Guide

Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart):

```dart
// ✅ Good
class FormFieldDetector {
  Map<String, dynamic> getFieldInfo(Element element) {
    // Implementation
  }
}

// ❌ Avoid
class form_field_detector {
  map<string, dynamic> get_field_info(element e) {
    // Implementation
  }
}
```

### Code Formatting

Use `dart format` to format your code:

```bash
dart format lib/ test/ example/
```

### Linting

Follow the analysis options in `analysis_options.yaml`:

```bash
dart analyze
```

### Documentation Comments

Document public APIs:

```dart
/// Generates dummy data for form fields.
/// 
/// The [inputType] determines what kind of data to generate.
/// Optional [maxLength] and [maxLines] constrain the output.
/// 
/// Example:
/// ```dart
/// final generator = DataGenerator();
/// final email = generator.getDataForInputType('email');
/// print(email); // 'john.doe@example.com'
/// ```
class DataGenerator {
  /// Generates appropriate dummy data for the given input type.
  String getDataForInputType(
    String inputType, {
    int? maxLength,
    int? maxLines,
  }) {
    // Implementation
  }
}
```

## 🧪 Testing Guidelines

### Writing Tests

1. **Unit Tests** - Test individual functions and classes
2. **Widget Tests** - Test widget behavior
3. **Integration Tests** - Test complete user workflows

### Test Structure

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fake_filler/src/data_generator.dart';

void main() {
  group('DataGenerator', () {
    late DataGenerator generator;

    setUp(() {
      generator = DataGenerator();
    });

    test('should generate email addresses', () {
      final email = generator.getDataForInputType('email');
      expect(email, contains('@'));
      expect(email, contains('.'));
    });

    test('should respect maxLength constraint', () {
      final shortText = generator.getDataForInputType('text', maxLength: 10);
      expect(shortText.length, lessThanOrEqualTo(10));
    });
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/data_generator_test.dart
```

### Test Coverage

Aim for high test coverage:
- New features should have 80%+ coverage
- Bug fixes should include regression tests
- Edge cases should be tested

## 📖 Documentation

### Types of Documentation

1. **API Documentation** - Dart doc comments in code
2. **User Guide** - How to use the package
3. **Examples** - Working code samples
4. **README** - Project overview and quick start

### Documentation Standards

- **Clear and concise** - Easy to understand
- **Code examples** - Show how to use features
- **Up to date** - Keep docs current with code changes
- **Accessible** - Consider different skill levels

### Building Documentation

The documentation is built with Docsify:

```bash
# Install docsify-cli globally
npm install -g docsify-cli

# Serve documentation locally
cd docs
docsify serve

# Open http://localhost:3000
```

## 🏷️ Release Process

### Version Numbering

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR** version for incompatible API changes
- **MINOR** version for backwards-compatible functionality
- **PATCH** version for backwards-compatible bug fixes

### Release Checklist

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Ensure all tests pass
4. Update documentation
5. Create release PR
6. Tag release after merge

## 🐛 Bug Reports

### Before Reporting

1. **Search existing issues**
2. **Try the latest version**
3. **Check documentation**

### Bug Report Template

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- Flutter version: [e.g. 3.13.0]
- Dart version: [e.g. 3.1.0]
- Package version: [e.g. 1.2.0]
- Platform: [e.g. Android, iOS, Web]

**Additional context**
Any other context about the problem.
```

## 💡 Feature Requests

### Before Requesting

1. **Check existing issues** for similar requests
2. **Consider if it fits** the package scope
3. **Think about implementation** complexity

### Feature Request Template

```markdown
**Is your feature request related to a problem?**
A clear description of what the problem is.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Other solutions you've considered.

**Additional context**
Any other context or screenshots.
```

## 📞 Getting Help

If you need help:

1. **Check the documentation** first
2. **Search existing issues** for similar problems
3. **Create a new issue** with detailed information
4. **Join discussions** in existing issues

## 🎉 Recognition

Contributors will be:
- **Listed in CONTRIBUTORS.md**
- **Mentioned in release notes**
- **Credited in documentation**

Thank you for contributing to Flutter Fake Filler! 🚀
