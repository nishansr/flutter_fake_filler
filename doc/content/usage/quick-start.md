# Quick Start

Get Flutter Fake Filler working in your app in under 5 minutes!

## 🎯 Goal

By the end of this guide, you'll have a working form that can be automatically filled with dummy data.

## 🚀 Step 1: Basic Setup

Wrap your `MaterialApp` with `FakeFiller`:

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
      enabled: true, // Enable the fake filler
      child: MaterialApp(
        title: 'My App',
        home: MyFormScreen(),
      ),
    );
  }
}
```

## 📝 Step 2: Create a Form

Create a simple form with text fields:

```dart
class MyFormScreen extends StatefulWidget {
  @override
  _MyFormScreenState createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quick Start Demo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
```

## ⚡ Step 3: Test It!

1. **Run your app**: `flutter run`
2. **Look for the FAB**: You'll see a floating action button (⚡) in the bottom-right corner
3. **Tap to fill**: Tap the button and watch all empty fields get filled with realistic data!

## 🎯 What You'll See

When you tap the floating action button:

- **Name field**: Gets filled with "John Smith" or similar
- **Email field**: Gets filled with "john.smith@email.com" 
- **Phone field**: Gets filled with "(555) 123-4567"

## 🎨 Step 4: Customize (Optional)

Make it your own with custom styling:

```dart
FakeFiller(
  enabled: true,
  fabIcon: Icons.auto_awesome,           // Custom icon
  fabBackgroundColor: Colors.deepPurple, // Custom color
  fabTooltip: 'Fill my forms!',          // Custom tooltip
  child: MaterialApp(...),
)
```

## 🔧 Production Setup

For production apps, only enable in debug mode:

```dart
import 'package:flutter/foundation.dart';

FakeFiller(
  enabled: kDebugMode, // Only enabled in debug builds
  child: MaterialApp(...),
)
```

## ✅ You're Done!

That's it! You now have:

- ✅ A working form auto-filler
- ✅ Smart field detection
- ✅ Realistic dummy data generation
- ✅ Development-friendly setup

## 🚀 Next Steps

Now that you have the basics working, explore more features:

- [📖 Configuration Options](options.md) - Customize appearance and behavior
- [🎨 Advanced Customization](../features/customization.md) - Deep customization options
- [📝 More Examples](../examples/simple-form.md) - See more complex examples
- [🎯 Field Detection](../features/field-detection.md) - Understanding how fields are detected

## 💡 Tips

- **Use descriptive labels**: "Email", "Phone", "Name" help with field detection
- **Set keyboard types**: `TextInputType.emailAddress`, `TextInputType.phone`, etc.
- **Always use controllers**: Fields need `TextEditingController` to be detected
- **Test early**: Add FakeFiller early in development for maximum benefit

---

**Ready for more?** → [Configuration Options](options.md)
