## 1.1.2

* **BUG FIX**: Improved error handling for SnackBar display
  - Added robust error handling to prevent "No Overlay widget found" exceptions
  - Enhanced compatibility with custom app architectures and BLoC patterns
  - Graceful fallback to console logging when SnackBar display is unavailable
  - Better support for apps that don't use MaterialApp or have custom widget structures
* **STABILITY**: Enhanced MaterialApp wrapping logic
  - Improved handling of route-based navigation to prevent black screen issues
  - Better preservation of original MaterialApp properties
  - Enhanced compatibility with apps using `onGenerateRoute` and `initialRoute`

## 1.1.1

* **CODE QUALITY**: Improved code formatting to follow Dart conventions
  - Reformatted arrays to have one element per line for better readability
  - Enhanced git diff clarity and code maintainability
  - Improved code review experience with cleaner formatting
* **DOCUMENTATION**: Enhanced GitHub Pages documentation site
  - Complete API documentation with examples
  - Comprehensive usage guides and tutorials
  - Professional documentation layout with search functionality
* **INFRASTRUCTURE**: Improved package publishing setup
  - Dual directory structure for GitHub Pages and pub.dev compliance
  - Optimized package size with `.pubignore` configuration
  - Enhanced repository accessibility and validation

## 1.1.0

* **NEW FEATURE**: Added `showSnackbar` property to control snackbar display
  - By default, snackbar is shown (`showSnackbar: true`)
  - Set to `false` to disable snackbar notifications
  - Maintains backward compatibility with existing implementations
* **ENHANCEMENT**: Added comprehensive documentation throughout the codebase
  - Detailed inline documentation for all classes and methods
  - Added parameter descriptions and usage examples
  - Improved code maintainability and developer experience
* **IMPROVEMENT**: Enhanced form field detection and data generation logic
* **COMPATIBILITY**: Added `FakeFillerWidget` typedef for backward compatibility
* **TESTING**: Added comprehensive widget tests for new functionality

## 0.0.1

* Initial release with basic fake data filling functionality
* Support for various input types: email, phone, date, URL, names, etc.
* Automatic form field detection and intelligent data generation
* Customizable floating action button for manual form filling
