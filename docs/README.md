# Flutter Fake Filler

A powerful Flutter package that automatically fills forms with realistic dummy data during development and testing. Save time and streamline your development workflow!

## ✨ What is Flutter Fake Filler?

Flutter Fake Filler is a development tool that adds a floating action button to your Flutter app, which when tapped, automatically fills all empty form fields with appropriate dummy data. It's perfect for:

- **Developers** testing form flows and validation
- **QA Teams** quickly filling forms during testing
- **Designers** seeing forms with realistic data
- **Demo Purposes** showcasing apps with populated forms

## 🎯 Key Features

### 🚀 Easy Integration
Just wrap your `MaterialApp` with `FakeFiller` - no complex setup required!

```dart
FakeFiller(
  enabled: true,
  child: MaterialApp(
    home: MyFormScreen(),
  ),
)
```

### 🎯 Smart Field Detection
Automatically detects field types and generates appropriate data:

| Field Type | Detection Method | Generated Data |
|------------|------------------|----------------|
| **Names** | Label contains 'name', 'firstName', 'lastName' | John Smith, Mary Johnson |
| **Email** | `TextInputType.emailAddress` or 'email' in label | john.smith@email.com |
| **Phone** | `TextInputType.phone` or 'phone' in label | (555) 123-4567 |
| **URL** | `TextInputType.url` or 'website' in label | https://example.com |
| **Numbers** | `TextInputType.number` or 'age', 'count' in label | 25, 1234 |
| **Bio/Description** | 'bio', 'description', 'comment' in label | Multi-line descriptive text |

### 🎨 Highly Customizable
Control every aspect of appearance and behavior:

```dart
FakeFiller(
  enabled: kDebugMode,                              // Only in debug mode
  fabIcon: Icons.auto_awesome,                      // Custom icon
  fabBackgroundColor: Colors.deepPurple,           // Custom color
  fabTooltip: 'Fill forms automatically',          // Custom tooltip
  fabLocation: FloatingActionButtonLocation.endFloat, // Standard positioning
  // Or custom positioning:
  fabRightOffset: 20.0,
  fabBottomOffset: 80.0,
  child: MaterialApp(...),
)
```

### 📏 Constraint Support
Respects your field constraints:

- **maxLength**: Truncates generated text to fit
- **maxLines**: Generates appropriate multi-line content
- **Word boundaries**: Intelligent truncation at word breaks

```dart
TextField(
  maxLength: 50,        // ✅ Content will be ≤ 50 characters
  maxLines: 3,          // ✅ Content will use multiple lines
  decoration: InputDecoration(
    labelText: 'Bio',   // ✅ Generates biographical text
  ),
)
```

## 🚀 Quick Start

### 1. Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_fake_filler: ^1.0.0
```

### 2. Import and Use

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FakeFiller(
      enabled: true,
      child: MaterialApp(
        home: MyFormScreen(),
      ),
    );
  }
}
```

### 3. Create Your Form

```dart
class MyFormScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Full Name'),
          ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
    );
  }
}
```

### 4. Tap and Fill!

Run your app and tap the floating action button (⚡) - watch all empty fields get filled with realistic data!

## 🎨 Customization Examples

### Standard Positioning
```dart
FakeFiller(
  fabLocation: FloatingActionButtonLocation.centerFloat,
  fabBackgroundColor: Colors.green,
  child: MaterialApp(...),
)
```

### Custom Positioning
```dart
FakeFiller(
  fabRightOffset: 30.0,   // 30px from right edge
  fabBottomOffset: 100.0, // 100px from bottom
  fabBackgroundColor: Colors.orange,
  child: MaterialApp(...),
)
```

### Development Only
```dart
FakeFiller(
  enabled: kDebugMode, // Only enabled in debug builds
  child: MaterialApp(...),
)
```

## 🎯 How It Works

1. **Widget Tree Scanning**: When you tap the FAB, the package scans your widget tree for `TextField` and `TextFormField` widgets
2. **Controller Detection**: Finds widgets with `TextEditingController`s
3. **Field Analysis**: Analyzes field properties (keyboard type, labels, constraints)
4. **Data Generation**: Generates appropriate dummy data based on field context
5. **Smart Filling**: Only fills empty fields, preserving user input

## 📱 Supported Widgets

- ✅ `TextField`
- ✅ `TextFormField`
- ✅ Any widget using `TextEditingController`
- ✅ Form builder widgets (that use controllers)

## 🌟 Why Choose Flutter Fake Filler?

### Before Flutter Fake Filler
```
❌ Manually typing test data for every field
❌ Time-consuming form filling during development
❌ Inconsistent test data across team members
❌ Repetitive data entry for testing scenarios
❌ Slow development and testing cycles
```

### After Flutter Fake Filler
```
✅ One-tap form filling with realistic data
✅ Consistent, professional-looking test data
✅ Focus on app logic instead of data entry
✅ Faster development and testing workflows
✅ Better team collaboration with standard data
```

## 📊 Performance

- **Lightweight**: Minimal impact on app size (~15KB)
- **Efficient**: Only scans widget tree when FAB is tapped
- **Memory friendly**: No persistent caching or state
- **Fast**: Instant form filling regardless of form size

## 🤝 Community

- **GitHub**: [flutter_fake_filler](https://github.com/nishansr/flutter_fake_filler)
- **Issues**: Report bugs and request features
- **Discussions**: Share ideas and get help
- **Contributions**: We welcome pull requests!

## 📄 License

MIT License - see [LICENSE](https://github.com/nishansr/flutter_fake_filler/blob/main/LICENSE) file for details.

---

## 🚀 Ready to Get Started?

Choose your path:

- 📦 **New to the package?** → [Installation Guide](content/usage/install.md)
- 🚀 **Want to jump in?** → [Quick Start](content/usage/quick-start.md)
- 🎨 **Need customization?** → [Configuration Options](content/usage/options.md)
- 📝 **Want examples?** → [Examples](content/examples/simple-form.md)

**Happy coding! 🎉**
- 🔧 **Development-friendly** - easily enable/disable in different environments
- ⚡ **Zero configuration** - works out of the box with sensible defaults

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_fake_filler: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Setup

Wrap your `MaterialApp` with the `FakeFiller` widget:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FakeFiller(
      enabled: true, // Set to false in production
      child: MaterialApp(
        title: 'My App',
        home: MyHomePage(),
      ),
    );
  }
}
```

### Customization

```dart
FakeFiller(
  enabled: kDebugMode, // Only enable in debug mode
  fabIcon: Icons.auto_fix_high,
  fabBackgroundColor: Colors.green,
  fabTooltip: 'Auto-fill forms',
  child: MaterialApp(
    // Your app here
  ),
)
```

### Floating Action Button Positioning

The package provides flexible positioning options for the floating action button:

#### Using Standard Flutter Locations

```dart
FakeFiller(
  enabled: true,
  fabBackgroundColor: Colors.deepPurple,
  fabLocation: FloatingActionButtonLocation.centerDocked,
  child: MaterialApp(
    // Your app here
  ),
)
```

Available standard locations:
- `FloatingActionButtonLocation.endFloat` (default)
- `FloatingActionButtonLocation.centerFloat`
- `FloatingActionButtonLocation.startFloat`
- `FloatingActionButtonLocation.centerDocked`
- `FloatingActionButtonLocation.endDocked`
- `FloatingActionButtonLocation.startDocked`

#### Using Custom Positioning

```dart
FakeFiller(
  enabled: true,
  fabBackgroundColor: Colors.teal,
  fabRightOffset: 20.0,  // Distance from right edge
  fabBottomOffset: 100.0, // Distance from bottom edge
  child: MaterialApp(
    // Your app here
  ),
)
```

#### Color and Appearance

```dart
FakeFiller(
  enabled: true,
  fabBackgroundColor: Colors.red,      // Custom background color
  fabIcon: Icons.auto_awesome,         // Custom icon
  fabTooltip: 'Fill all fields',      // Custom tooltip
  child: MaterialApp(
    // Your app here
  ),
)
```

**Note**: When you provide a custom `fabBackgroundColor`, the package automatically calculates the appropriate contrasting color for the icon to ensure good visibility.

### How it works

1. The package adds a floating action button to your app
2. When tapped, it scans the current screen for text fields
3. It intelligently fills each field with appropriate dummy data based on:
   - Input type (email, tel, date, url, number)
   - Field name/label patterns
   - Context clues

### Supported Field Types

- **Email**: Generates realistic email addresses (e.g., `john@example.com`)
- **Phone**: Creates formatted phone numbers (e.g., `(555) 123-4567`)
- **Date**: Provides random dates in YYYY-MM-DD format
- **URL**: Generates website URLs (e.g., `https://www.example.com`)
- **Names**: First names, last names, and full names
- **Numbers**: Random numerical values
- **Text**: Lorem ipsum style text content
- **Multi-line Text**: Intelligently generates content for bio, description, comment fields
- **Length-constrained**: Respects `maxLength` and `maxLines` properties of TextField

### Advanced Features

#### Max Length Support

The package automatically respects `maxLength` constraints on text fields:

```dart
TextField(
  maxLength: 50,
  decoration: InputDecoration(
    labelText: 'Short Description',
  ),
)
```

The generated content will be truncated to fit within the specified length, preferring to cut at word boundaries when possible.

#### Multi-line Support

For fields with `maxLines > 1`, the package generates appropriate multi-line content:

```dart
TextField(
  maxLines: 3,
  maxLength: 200,
  decoration: InputDecoration(
    labelText: 'Bio',
  ),
)
```

The content will be distributed across multiple lines while respecting both line and character limits.

### Field Detection

The package uses intelligent field detection based on:

1. **TextInputType**: `TextInputType.emailAddress`, `TextInputType.phone`, etc.
2. **Field names**: Keywords like "email", "phone", "name", "date" in labels/hints
3. **Context patterns**: Common form field naming conventions

### Example

```dart
class SignUpForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text('Sign Up'),
            ),
            // Tap the floating button to auto-fill all fields!
          ],
        ),
      ),
    );
  }
}
```

## API Reference

### FakeFiller

The main widget that wraps your app and provides the fake filling functionality.

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | `Widget` | required | The widget to wrap (typically MaterialApp) |
| `enabled` | `bool` | `true` | Whether to show the floating action button |
| `fabIcon` | `IconData?` | `Icons.auto_fix_high` | Icon for the floating action button |
| `fabBackgroundColor` | `Color?` | `Theme.primaryColor` | Background color of the FAB |
| `fabTooltip` | `String?` | `'Fill forms with dummy data'` | Tooltip text for the FAB |

### DataGenerator

Utility class for generating different types of dummy data.

#### Methods

- `DataGenerator.email()` - Generates email addresses
- `DataGenerator.phoneNumber()` - Generates phone numbers
- `DataGenerator.fullName()` - Generates full names
- `DataGenerator.firstName()` - Generates first names
- `DataGenerator.lastName()` - Generates last names
- `DataGenerator.date()` - Generates dates
- `DataGenerator.website()` - Generates website URLs
- `DataGenerator.words(int count)` - Generates lorem ipsum text

## Best Practices

1. **Only enable in development**: Use `kDebugMode` to automatically disable in release builds
2. **Test with real data**: Use fake filler for initial development, then test with realistic data
3. **Clear fields before testing**: The package only fills empty fields by default
4. **Form validation**: Ensure your form validation works with the generated dummy data

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the [Fake Filler](https://chrome.google.com/webstore/detail/fake-filler/bnjjngeaknajbdcgpfkgnonkmififhfo) browser extension
- Built with ❤️ for the Flutter community
