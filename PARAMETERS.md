## FakeFiller Widget Parameters

### Core Parameters
- `child` (required): The child widget to wrap (typically MaterialApp)
- `enabled`: Enable/disable the fake filler functionality (default: true)

### Floating Action Button Customization
- `fabIcon`: Custom icon for the FAB (default: Icons.auto_fix_high)
- `fabBackgroundColor`: Custom background color for the FAB
- `fabTooltip`: Custom tooltip text (default: 'Fill forms with dummy data')

### Positioning Options

#### Option 1: Standard Flutter Locations
Use `fabLocation` with standard Flutter FloatingActionButtonLocation values:
- `FloatingActionButtonLocation.endFloat` (default)
- `FloatingActionButtonLocation.centerFloat`
- `FloatingActionButtonLocation.startFloat`
- `FloatingActionButtonLocation.centerDocked`
- `FloatingActionButtonLocation.endDocked`
- `FloatingActionButtonLocation.startDocked`

#### Option 2: Custom Positioning
Use `fabRightOffset` and `fabBottomOffset` for precise positioning:
- `fabRightOffset`: Distance from the right edge in pixels
- `fabBottomOffset`: Distance from the bottom edge in pixels

### Examples

#### Basic Usage
```dart
FakeFiller(
  enabled: true,
  child: MaterialApp(...),
)
```

#### Custom Color and Standard Position
```dart
FakeFiller(
  enabled: true,
  fabBackgroundColor: Colors.purple,
  fabIcon: Icons.auto_awesome,
  fabLocation: FloatingActionButtonLocation.centerFloat,
  child: MaterialApp(...),
)
```

#### Custom Position
```dart
FakeFiller(
  enabled: true,
  fabBackgroundColor: Colors.teal,
  fabRightOffset: 30.0,
  fabBottomOffset: 120.0,
  child: MaterialApp(...),
)
```

### Notes
- When `fabLocation` is provided, it takes precedence over custom offsets
- Custom background colors automatically get contrasting foreground colors
- The package respects TextField `maxLength` and `maxLines` properties
- Only empty fields are filled to avoid overwriting user input
