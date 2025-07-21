# Field Types Support

Flutter Fake Filler intelligently detects different types of form fields and generates appropriate dummy data for each type.

## Supported Field Types

### 📧 Email Fields
**Detection**: Fields with email keyboard type or email-related hints
```dart
TextField(
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
  ),
)
```
**Generated Data**: `john.doe@example.com`, `sarah.smith@gmail.com`

### 📱 Phone Number Fields
**Detection**: Fields with phone keyboard type or phone-related hints
```dart
TextField(
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(
    labelText: 'Phone',
    hintText: 'Enter phone number',
  ),
)
```
**Generated Data**: `(555) 123-4567`, `+1-234-567-8900`

### 👤 Name Fields
**Detection**: Fields with person name keyboard type or name-related hints
```dart
TextField(
  keyboardType: TextInputType.name,
  decoration: InputDecoration(
    labelText: 'Full Name',
    hintText: 'Enter your name',
  ),
)
```
**Generated Data**: `John Smith`, `Sarah Johnson`, `Michael Brown`

### 🔒 Password Fields
**Detection**: Fields with obscured text
```dart
TextField(
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Password',
    hintText: 'Enter password',
  ),
)
```
**Generated Data**: `SecurePass123!`, `MyP@ssw0rd2024`

### 🌐 URL Fields
**Detection**: Fields with URL keyboard type or URL-related hints
```dart
TextField(
  keyboardType: TextInputType.url,
  decoration: InputDecoration(
    labelText: 'Website',
    hintText: 'Enter website URL',
  ),
)
```
**Generated Data**: `https://example.com`, `https://flutter.dev`

### 🔢 Number Fields
**Detection**: Fields with number keyboard type
```dart
TextField(
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    labelText: 'Age',
    hintText: 'Enter your age',
  ),
)
```
**Generated Data**: `25`, `42`, `18`

### 📍 Address Fields
**Detection**: Fields with street address keyboard type or address-related hints
```dart
TextField(
  keyboardType: TextInputType.streetAddress,
  decoration: InputDecoration(
    labelText: 'Address',
    hintText: 'Enter your address',
  ),
)
```
**Generated Data**: `123 Main Street, Anytown, CA 12345`

### 📝 Generic Text Fields
**Detection**: Standard text fields without specific type
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Comments',
    hintText: 'Enter comments',
  ),
)
```
**Generated Data**: Context-appropriate sentences and paragraphs

## Field Constraint Handling

### Character Limits (maxLength)
```dart
TextField(
  maxLength: 50,
  decoration: InputDecoration(
    labelText: 'Short Description',
  ),
)
```
- Generated text respects character limits
- Truncates at word boundaries when possible
- Handles edge cases (maxLength of 1, 0, or negative)

### Line Limits (maxLines)
```dart
TextField(
  maxLines: 3,
  decoration: InputDecoration(
    labelText: 'Multi-line Comments',
  ),
)
```
- Generates appropriate number of lines
- Distributes content evenly across lines
- Handles single-line and unlimited line scenarios

### Combined Constraints
```dart
TextField(
  maxLength: 200,
  maxLines: 4,
  decoration: InputDecoration(
    labelText: 'Detailed Description',
  ),
)
```
- Respects both character and line limits
- Prioritizes character limits over line limits
- Ensures realistic content distribution

## Custom Field Detection

### Adding Custom Keywords
You can influence field detection by using specific keywords in your field labels, hints, or variable names:

```dart
// Email detection keywords
TextField(
  decoration: InputDecoration(
    labelText: 'Email Address', // Contains 'email'
  ),
)

// Phone detection keywords  
TextField(
  decoration: InputDecoration(
    hintText: 'Phone number', // Contains 'phone'
  ),
)

// Name detection keywords
TextField(
  decoration: InputDecoration(
    labelText: 'First Name', // Contains 'name'
  ),
)
```

### Detection Keywords by Type

| Field Type | Keywords |
|------------|----------|
| Email | email, mail, e-mail |
| Phone | phone, mobile, tel, telephone |
| Name | name, first, last, full |
| Password | password, pass, secret |
| URL | url, website, link, web |
| Address | address, street, location |

## Troubleshooting Field Detection

### Field Not Detected?
1. Check if the field is a `TextField` or `TextFormField`
2. Ensure the field is visible in the widget tree
3. Add descriptive labels or hints
4. Use appropriate `keyboardType`

### Wrong Data Type Generated?
1. Use more specific keywords in labels/hints
2. Set the correct `keyboardType`
3. Check for conflicting field properties

### Custom Field Types
For specialized field types not covered by default detection, you can:
1. Use specific keywords in field labels
2. Set appropriate keyboard types
3. Consider contributing new detection patterns to the package

## Next Steps

- [Customization Options](customization.md)
- [API Reference](../api/overview.md)
- [Examples](../examples/basic.md)
