# Customization Guide

Flutter Fake Filler offers extensive customization options to match your app's design and workflow requirements.

## Floating Action Button Customization

### Standard Positions
Use Flutter's built-in FAB locations:

```dart
FakeFillerWidget(
  fabLocation: FloatingActionButtonLocation.centerFloat,
  child: YourFormWidget(),
)
```

**Available Positions**:
- `FloatingActionButtonLocation.centerFloat`
- `FloatingActionButtonLocation.centerDocked`
- `FloatingActionButtonLocation.endFloat`
- `FloatingActionButtonLocation.endDocked`
- `FloatingActionButtonLocation.startFloat`
- `FloatingActionButtonLocation.startDocked`
- `FloatingActionButtonLocation.miniCenterFloat`
- `FloatingActionButtonLocation.miniEndFloat`
- `FloatingActionButtonLocation.miniStartFloat`

### Custom Positioning
For precise control, use offset positioning:

```dart
FakeFillerWidget(
  fabRightOffset: 20.0,  // Distance from right edge
  fabBottomOffset: 80.0, // Distance from bottom edge
  child: YourFormWidget(),
)
```

### Position Examples

#### Bottom Right (Default)
```dart
FakeFillerWidget(
  // Uses default positioning
  child: MyForm(),
)
```

#### Top Right Corner
```dart
FakeFillerWidget(
  fabRightOffset: 16.0,
  fabBottomOffset: MediaQuery.of(context).size.height - 100,
  child: MyForm(),
)
```

#### Center of Screen
```dart
FakeFillerWidget(
  fabRightOffset: MediaQuery.of(context).size.width / 2 - 28,
  fabBottomOffset: MediaQuery.of(context).size.height / 2 - 28,
  child: MyForm(),
)
```

## Color Customization

### Automatic Color Contrast
The FAB automatically calculates a contrasting color based on your app's theme:

```dart
// FAB color automatically contrasts with the background
FakeFillerWidget(
  child: MyForm(),
)
```

### Theme Integration
The FAB respects your app's theme:

```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
  ),
  home: Scaffold(
    body: FakeFillerWidget(
      child: MyForm(),
    ),
  ),
)
```

### Dark Mode Support
Automatically adapts to dark mode themes:

```dart
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system,
  home: Scaffold(
    body: FakeFillerWidget(
      child: MyForm(),
    ),
  ),
)
```

## Responsive Design

### Mobile Optimization
```dart
FakeFillerWidget(
  fabLocation: FloatingActionButtonLocation.endFloat,
  child: MyForm(),
)
```

### Tablet Layout
```dart
LayoutBuilder(
  builder: (context, constraints) {
    return FakeFillerWidget(
      fabRightOffset: constraints.maxWidth > 600 ? 40.0 : 16.0,
      fabBottomOffset: constraints.maxWidth > 600 ? 40.0 : 16.0,
      child: MyForm(),
    );
  },
)
```

### Web Layout
```dart
FakeFillerWidget(
  fabRightOffset: 60.0,
  fabBottomOffset: 60.0,
  child: MyForm(),
)
```

## Form Integration Patterns

### Nested in Scaffold
```dart
Scaffold(
  appBar: AppBar(title: Text('My Form')),
  body: FakeFillerWidget(
    fabLocation: FloatingActionButtonLocation.endFloat,
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(/* ... */),
          TextField(/* ... */),
          // More form fields
        ],
      ),
    ),
  ),
)
```

### Multiple Forms
```dart
PageView(
  children: [
    FakeFillerWidget(
      fabRightOffset: 16.0,
      child: PersonalInfoForm(),
    ),
    FakeFillerWidget(
      fabRightOffset: 16.0,
      child: ContactInfoForm(),
    ),
  ],
)
```

### Conditional Display
```dart
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool showFakeFiller = true;

  @override
  Widget build(BuildContext context) {
    Widget formWidget = Column(
      children: [
        TextField(/* ... */),
        TextField(/* ... */),
      ],
    );

    if (showFakeFiller && kDebugMode) {
      return FakeFillerWidget(
        child: formWidget,
      );
    }

    return formWidget;
  }
}
```

## Advanced Customization

### Custom FAB Icon
```dart
FakeFillerWidget(
  child: Builder(
    builder: (context) {
      return Stack(
        children: [
          YourFormWidget(),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () {
                // Custom fill logic
              },
              child: Icon(Icons.auto_fix_high),
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      );
    },
  ),
)
```

### Integration with Existing FABs
```dart
Scaffold(
  body: FakeFillerWidget(
    fabLocation: FloatingActionButtonLocation.endFloat,
    child: YourFormWidget(),
  ),
  floatingActionButton: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      FloatingActionButton(
        heroTag: "save",
        onPressed: () => saveForm(),
        child: Icon(Icons.save),
      ),
      SizedBox(height: 10),
      // FakeFillerWidget FAB will appear here
    ],
  ),
)
```

### Animation Customization
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  child: FakeFillerWidget(
    fabBottomOffset: isExpanded ? 120.0 : 16.0,
    child: MyForm(),
  ),
)
```

## Best Practices

### Development vs Production
```dart
Widget buildForm() {
  Widget form = MyFormWidget();
  
  // Only show fake filler in debug mode
  if (kDebugMode) {
    form = FakeFillerWidget(child: form);
  }
  
  return form;
}
```

### Performance Optimization
```dart
// Wrap only the form part, not the entire screen
Scaffold(
  appBar: AppBar(title: Text('App')),
  body: Column(
    children: [
      ExpensiveWidget(), // Don't wrap this
      Expanded(
        child: FakeFillerWidget(
          child: FormSection(), // Only wrap the form
        ),
      ),
    ],
  ),
)
```

### Accessibility
```dart
FakeFillerWidget(
  child: Semantics(
    label: 'Form with auto-fill capability',
    child: MyForm(),
  ),
)
```

## Common Customization Patterns

### Material Design 3
```dart
FakeFillerWidget(
  fabLocation: FloatingActionButtonLocation.endFloat,
  child: Form(
    child: Column(
      children: [
        // Use Material 3 text fields
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
  ),
)
```

### Cupertino Style
```dart
CupertinoApp(
  home: CupertinoPageScaffold(
    child: FakeFillerWidget(
      child: Column(
        children: [
          CupertinoTextField(
            placeholder: 'Enter name',
          ),
        ],
      ),
    ),
  ),
)
```

## Troubleshooting Customization

### FAB Not Visible?
1. Check if there are conflicting positioned widgets
2. Verify offset values are within screen bounds
3. Ensure the FAB isn't behind other widgets

### Colors Not Matching Theme?
1. Check if custom theme properties are set
2. Verify the app's theme mode (light/dark)
3. Test color contrast in different themes

### Position Not Responsive?
1. Use `MediaQuery` for screen-relative positioning
2. Test on different screen sizes
3. Consider using `LayoutBuilder` for adaptive layouts

## Next Steps

- [API Reference](../api/overview.md)
- [Examples](../examples/advanced.md)
- [Contributing](../contributing/guidelines.md)
