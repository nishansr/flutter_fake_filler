# Installation

Get Flutter Fake Filler up and running in your project in just a few minutes!

## 📋 Requirements

- Flutter SDK: `>=3.0.0`
- Dart SDK: `>=3.0.0`
- Android: API level 21+
- iOS: 11.0+

## 📦 Add Dependency

Add Flutter Fake Filler to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_fake_filler: ^1.0.0
```

## ⬇️ Install Packages

Run the following command in your project directory:

```bash
flutter pub get
```

## 📱 Import Package

Add the import statement to your Dart files:

```dart
import 'package:flutter_fake_filler/flutter_fake_filler.dart';
```

## ✅ Verify Installation

Create a simple test to verify everything is working:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FakeFiller(
      enabled: true,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Test App')),
          body: Center(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Test Field',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

Run this app and you should see a floating action button in the bottom-right corner. Tap it to fill the text field!

## 🚀 Next Steps

- [Quick Start Guide](quick-start.md) - Get up and running in 5 minutes
- [Configuration Options](options.md) - Customize the appearance and behavior
- [Basic Usage](tools.md) - Learn the fundamentals

## 🚨 Troubleshooting

### Package not found
```bash
flutter pub cache repair
flutter clean
flutter pub get
```

### Import errors
- Restart your IDE
- Check the import statement syntax
- Verify the package version in `pubspec.yaml`

### FAB not appearing
- Make sure `enabled: true` is set
- Verify you're using `MaterialApp`
- Check that you wrapped the right widget with `FakeFiller`

---

**Ready to continue?** → [Quick Start Guide](quick-start.md)
