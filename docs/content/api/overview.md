# API Reference

Complete API documentation for Flutter Fake Filler package.

## Overview

The Flutter Fake Filler package provides a simple yet powerful API for automatically filling form fields with dummy data. The main entry point is the `FakeFillerWidget` class.

## Classes

### FakeFillerWidget

The main widget that wraps your form and provides fake filling functionality.

#### Constructor

```dart
FakeFillerWidget({
  Key? key,
  required Widget child,
  FloatingActionButtonLocation? fabLocation,
  double? fabRightOffset,
  double? fabBottomOffset,
})
```

#### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | `Key?` | No | `null` | Widget key for identification |
| `child` | `Widget` | **Yes** | - | The widget tree to wrap (typically containing form fields) |
| `fabLocation` | `FloatingActionButtonLocation?` | No | `null` | Standard Flutter FAB location. If null, uses custom positioning |
| `fabRightOffset` | `double?` | No | `16.0` | Distance from right edge when using custom positioning |
| `fabBottomOffset` | `double?` | No | `16.0` | Distance from bottom edge when using custom positioning |

#### Example Usage

```dart
// Basic usage
FakeFillerWidget(
  child: MyFormWidget(),
)

// With standard FAB location
FakeFillerWidget(
  fabLocation: FloatingActionButtonLocation.centerFloat,
  child: MyFormWidget(),
)

// With custom positioning
FakeFillerWidget(
  fabRightOffset: 20.0,
  fabBottomOffset: 80.0,
  child: MyFormWidget(),
)
```

### FormFieldDetector

Internal class responsible for detecting and analyzing form fields in the widget tree.

#### Methods

##### getFieldInfo

```dart
Map<String, dynamic> getFieldInfo(Element element)
```

Extracts metadata from a form field element.

**Parameters:**
- `element` - The widget element to analyze

**Returns:**
A map containing field information:
- `type` - The detected field type (email, phone, name, etc.)
- `maxLength` - Maximum character limit (if specified)
- `maxLines` - Maximum line limit (if specified)
- `label` - Field label text
- `hint` - Field hint text

**Example Output:**
```dart
{
  'type': 'email',
  'maxLength': 50,
  'maxLines': 1,
  'label': 'Email Address',
  'hint': 'Enter your email'
}
```

### DataGenerator

Internal class that generates appropriate dummy data based on field information.

#### Methods

##### getDataForInputType

```dart
String getDataForInputType(
  String inputType, {
  int? maxLength,
  int? maxLines,
})
```

Generates dummy data for a specific input type with constraints.

**Parameters:**
- `inputType` - The type of field (email, phone, name, etc.)
- `maxLength` - Optional character limit
- `maxLines` - Optional line limit

**Returns:**
Generated dummy text appropriate for the field type.

**Supported Input Types:**
- `email` - Email addresses
- `phone` - Phone numbers
- `name` - Personal names
- `password` - Secure passwords
- `url` - Website URLs
- `number` - Numeric values
- `address` - Street addresses
- `text` - Generic text content

## Field Detection

### Supported Field Types

The package automatically detects field types based on:

1. **Keyboard Type** (`keyboardType` property)
2. **Field Properties** (`obscureText`, etc.)
3. **Text Hints** (keywords in labels and hints)

### Detection Keywords

| Field Type | Keywords | Keyboard Types |
|------------|----------|----------------|
| Email | email, mail, e-mail | `TextInputType.emailAddress` |
| Phone | phone, mobile, tel, telephone | `TextInputType.phone` |
| Name | name, first, last, full | `TextInputType.name` |
| Password | password, pass, secret | N/A (uses `obscureText: true`) |
| URL | url, website, link, web | `TextInputType.url` |
| Number | age, count, quantity | `TextInputType.number` |
| Address | address, street, location | `TextInputType.streetAddress` |

## Constraint Handling

### Character Limits (maxLength)

```dart
TextField(
  maxLength: 50,  // Will be respected
  decoration: InputDecoration(labelText: 'Description'),
)
```

**Behavior:**
- Generated text will not exceed the specified character limit
- Text is truncated at word boundaries when possible
- Handles edge cases (0, negative values)

### Line Limits (maxLines)

```dart
TextField(
  maxLines: 3,  // Will be respected
  decoration: InputDecoration(labelText: 'Comments'),
)
```

**Behavior:**
- Content is distributed across the specified number of lines
- Each line gets roughly equal content
- Handles single-line and unlimited line scenarios

### Combined Constraints

```dart
TextField(
  maxLength: 100,
  maxLines: 2,
  decoration: InputDecoration(labelText: 'Bio'),
)
```

**Behavior:**
- Character limit takes precedence
- Content is distributed across available lines
- Word boundaries are preserved when possible

## Error Handling

### Widget Tree Traversal

The package includes comprehensive error handling for:

- **Null Elements** - Safely handles missing or null widget elements
- **Type Casting** - Graceful fallback when widget types don't match
- **Property Access** - Safe access to widget properties that may not exist

### Constraint Validation

Input constraints are validated and sanitized:

```dart
// These edge cases are handled safely:
TextField(maxLength: 0)     // Treated as no limit
TextField(maxLength: -5)    // Treated as no limit
TextField(maxLines: 0)      // Treated as single line
TextField(maxLines: -1)     // Treated as unlimited
```

## Customization

### FAB Positioning

#### Standard Locations

Use Flutter's built-in positioning:

```dart
FakeFillerWidget(
  fabLocation: FloatingActionButtonLocation.centerFloat,
  child: form,
)
```

**Available Locations:**
- `FloatingActionButtonLocation.centerFloat`
- `FloatingActionButtonLocation.centerDocked`
- `FloatingActionButtonLocation.endFloat`
- `FloatingActionButtonLocation.endDocked`
- `FloatingActionButtonLocation.startFloat`
- `FloatingActionButtonLocation.startDocked`
- `FloatingActionButtonLocation.miniCenterFloat`
- `FloatingActionButtonLocation.miniEndFloat`
- `FloatingActionButtonLocation.miniStartFloat`

#### Custom Positioning

Use offset-based positioning:

```dart
FakeFillerWidget(
  fabRightOffset: 20.0,   // Distance from right
  fabBottomOffset: 80.0,  // Distance from bottom
  child: form,
)
```

### Color Integration

The FAB automatically integrates with your app's theme:

- Respects `FloatingActionButtonTheme`
- Automatically calculates contrasting colors
- Supports both light and dark themes

## Best Practices

### Development vs Production

```dart
Widget buildForm() {
  Widget form = MyFormWidget();
  
  // Only show in debug mode
  if (kDebugMode) {
    form = FakeFillerWidget(child: form);
  }
  
  return form;
}
```

### Performance Optimization

```dart
// ✅ Good - Wrap only the form
Scaffold(
  appBar: AppBar(title: Text('App')),
  body: Column(
    children: [
      ExpensiveWidget(),
      Expanded(
        child: FakeFillerWidget(
          child: FormSection(),
        ),
      ),
    ],
  ),
)

// ❌ Avoid - Wrapping entire screen
FakeFillerWidget(
  child: Scaffold(
    // Entire app wrapped
  ),
)
```

### Form Validation Compatibility

The package works seamlessly with form validation:

```dart
Form(
  key: _formKey,
  child: FakeFillerWidget(
    child: Column(
      children: [
        TextFormField(
          validator: (value) => value?.isEmpty == true 
            ? 'Required' : null,
        ),
      ],
    ),
  ),
)
```

## Migration Guide

### From Version 1.x to 2.x

If upgrading from an earlier version:

```dart
// Old API (if applicable)
FakeFillerWidget(
  child: form,
  position: FabPosition.bottomRight,
)

// New API
FakeFillerWidget(
  child: form,
  fabLocation: FloatingActionButtonLocation.endFloat,
)
```

## Troubleshooting

### Common Issues

#### Fields Not Detected
```dart
// ❌ May not be detected
Widget buildField() => TextField();

// ✅ Better detection
TextField(
  decoration: InputDecoration(labelText: 'Email'),
  keyboardType: TextInputType.emailAddress,
)
```

#### FAB Not Visible
```dart
// Ensure FAB is not behind other widgets
FakeFillerWidget(
  fabBottomOffset: 100.0, // Above bottom navigation
  child: form,
)
```

#### Wrong Data Generated
```dart
// ❌ Generic field
TextField(decoration: InputDecoration(labelText: 'Field'))

// ✅ Specific field type
TextField(
  decoration: InputDecoration(labelText: 'Email Address'),
  keyboardType: TextInputType.emailAddress,
)
```

## Platform Support

| Platform | Supported | Notes |
|----------|-----------|-------|
| Android | ✅ | Full support |
| iOS | ✅ | Full support |
| Web | ✅ | Full support |
| macOS | ✅ | Full support |
| Windows | ✅ | Full support |
| Linux | ✅ | Full support |

## Dependencies

The package has minimal dependencies:
- Flutter SDK >=3.0.0
- No external dependencies

## License

This package is licensed under the MIT License. See the [LICENSE](https://github.com/nishansr/flutter_fake_filler/blob/main/LICENSE) file for details.

## Support

- [GitHub Issues](https://github.com/nishansr/flutter_fake_filler/issues)
- [Package Documentation](https://pub.dev/packages/flutter_fake_filler)
- [Example Code](https://github.com/nishansr/flutter_fake_filler/tree/main/example)
