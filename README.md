# Flutter Fake Filler

A Flutter package that automatically fills form fields with dummy data, inspired by the popular Fake Filler browser extension. Perfect for developers and testers working with forms during development.

## Features

- 🚀 **Easy integration** - just wrap your MaterialApp with FakeFiller widget
- 🎯 **Smart field detection** - automatically detects email, phone, date, and other field types
- 🎲 **Realistic dummy data** - generates appropriate data based on field context
- 🎨 **Customizable** - configure the floating action button appearance
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

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
