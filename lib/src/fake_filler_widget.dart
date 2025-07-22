import 'package:flutter/material.dart';
import 'data_generator.dart';
import 'form_field_detector.dart';

/// A Flutter widget that adds a floating action button to automatically fill
/// form fields with dummy data for development and testing purposes.
///
/// This widget wraps your app and provides a floating action button that,
/// when tapped, scans the widget tree for text fields and fills them with
/// appropriate dummy data based on field types and constraints.
///
/// Example:
/// ```dart
/// FakeFiller(
///   enabled: true,
///   showSnackbar: true,
///   fabBackgroundColor: Colors.blue,
///   child: MaterialApp(
///     home: MyFormScreen(),
///   ),
/// )
/// ```
class FakeFiller extends StatefulWidget {
  /// The child widget to wrap (typically a MaterialApp or form screen).
  final Widget child;

  /// Whether the fake filler functionality is enabled.
  /// Set to false to disable the floating action button.
  final bool enabled;

  /// Custom icon for the floating action button.
  /// Defaults to [Icons.auto_fix_high].
  final IconData? fabIcon;

  /// Custom background color for the floating action button.
  /// If null, uses the theme's primary color.
  final Color? fabBackgroundColor;

  /// Custom tooltip text for the floating action button.
  /// Defaults to 'Fill forms with dummy data'.
  final String? fabTooltip;

  /// Standard Flutter location for the floating action button.
  /// When provided, takes precedence over custom offset positioning.
  final FloatingActionButtonLocation? fabLocation;

  /// Distance from the right edge of the screen in pixels.
  /// Only used when [fabLocation] is null.
  final double? fabRightOffset;

  /// Distance from the bottom edge of the screen in pixels.
  /// Only used when [fabLocation] is null.
  final double? fabBottomOffset;

  /// Whether to show snackbar notifications after filling forms.
  /// When true, shows success messages and field count information.
  /// When false, operates silently without notifications.
  final bool showSnackbar;

  /// Creates a [FakeFiller] widget.
  ///
  /// The [child] parameter is required and should contain your app's content.
  /// All other parameters are optional with sensible defaults.
  const FakeFiller({
    super.key,
    required this.child,
    this.enabled = true,
    this.fabIcon = Icons.auto_fix_high,
    this.fabBackgroundColor,
    this.fabTooltip = 'Fill forms with dummy data',
    this.fabLocation,
    this.fabRightOffset,
    this.fabBottomOffset,
    this.showSnackbar = true,
  });

  @override
  State<FakeFiller> createState() => _FakeFillerState();
}

/// Internal state class for [FakeFiller].
///
/// Manages the floating action button behavior and form filling logic.
class _FakeFillerState extends State<FakeFiller> {
  /// Navigator key for accessing the current context when filling forms.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// Fills all empty text fields on the current screen with dummy data.
  ///
  /// This method:
  /// 1. Scans the widget tree for TextField and TextFormField widgets
  /// 2. Analyzes each field to determine appropriate data type
  /// 3. Generates dummy data respecting field constraints (maxLength, maxLines)
  /// 4. Updates only empty fields to preserve user input
  /// 5. Shows snackbar notifications if [showSnackbar] is enabled
  void _fillForms() {
    final context = _navigatorKey.currentContext ?? this.context;

    // Find all text field controllers in the current widget tree
    final controllers = FormFieldDetector.findTextFields(context);

    // Show message if no text fields are found
    if (controllers.isEmpty) {
      if (widget.showSnackbar) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No text fields found on this screen'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    int filledCount = 0;

    // Process each text field controller
    for (final controller in controllers) {
      try {
        // Only fill empty fields to preserve user input
        if (controller.text.isEmpty) {
          // Analyze field properties to determine appropriate data type
          final fieldInfo = FormFieldDetector.getFieldInfo(controller, context);

          // Generate dummy data with respect to field constraints
          final dummyData = DataGenerator.getDataForInputType(
            fieldInfo['inputType'],
            fieldInfo['fieldName'],
            maxLength: fieldInfo['maxLength'],
            maxLines: fieldInfo['maxLines'],
          );

          // Ensure we don't set null or problematic data
          if (dummyData.isNotEmpty) {
            controller.text = dummyData;
            filledCount++;
          }
        }
      } catch (e) {
        // Skip this controller if there's an error and continue with others
        continue;
      }
    }

    // Show success/status messages if snackbar notifications are enabled
    if (widget.showSnackbar) {
      if (filledCount > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Filled $filledCount text field${filledCount == 1 ? '' : 's'}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All text fields are already filled'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If disabled, return the child widget without any modifications
    if (!widget.enabled) {
      return widget.child;
    }

    // Special handling for MaterialApp to ensure proper navigator integration
    if (widget.child is MaterialApp) {
      final materialApp = widget.child as MaterialApp;

      // Wrap MaterialApp with our navigator key and overlay
      return MaterialApp(
        key: materialApp.key,
        navigatorKey: _navigatorKey,
        home: _FakeFillerOverlay(
          onFillForms: _fillForms,
          fabIcon: widget.fabIcon,
          fabBackgroundColor: widget.fabBackgroundColor,
          fabTooltip: widget.fabTooltip,
          fabLocation: widget.fabLocation,
          fabRightOffset: widget.fabRightOffset,
          fabBottomOffset: widget.fabBottomOffset,
          child: materialApp.home,
        ),
        // Preserve all original MaterialApp properties
        routes: materialApp.routes ?? const {},
        initialRoute: materialApp.initialRoute,
        onGenerateRoute: materialApp.onGenerateRoute,
        onGenerateInitialRoutes: materialApp.onGenerateInitialRoutes,
        onUnknownRoute: materialApp.onUnknownRoute,
        navigatorObservers: materialApp.navigatorObservers ?? const [],
        builder: materialApp.builder,
        title: materialApp.title,
        onGenerateTitle: materialApp.onGenerateTitle,
        color: materialApp.color,
        theme: materialApp.theme,
        darkTheme: materialApp.darkTheme,
        themeMode: materialApp.themeMode,
        locale: materialApp.locale,
        localizationsDelegates: materialApp.localizationsDelegates,
        localeListResolutionCallback: materialApp.localeListResolutionCallback,
        localeResolutionCallback: materialApp.localeResolutionCallback,
        supportedLocales: materialApp.supportedLocales,
        debugShowMaterialGrid: materialApp.debugShowMaterialGrid,
        showPerformanceOverlay: materialApp.showPerformanceOverlay,
        checkerboardRasterCacheImages:
            materialApp.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: materialApp.checkerboardOffscreenLayers,
        showSemanticsDebugger: materialApp.showSemanticsDebugger,
        debugShowCheckedModeBanner: materialApp.debugShowCheckedModeBanner,
        shortcuts: materialApp.shortcuts,
        actions: materialApp.actions,
        restorationScopeId: materialApp.restorationScopeId,
        scrollBehavior: materialApp.scrollBehavior,
      );
    } else {
      // For other widgets, simply wrap with the overlay
      return _FakeFillerOverlay(
        onFillForms: _fillForms,
        fabIcon: widget.fabIcon,
        fabBackgroundColor: widget.fabBackgroundColor,
        fabTooltip: widget.fabTooltip,
        fabLocation: widget.fabLocation,
        fabRightOffset: widget.fabRightOffset,
        fabBottomOffset: widget.fabBottomOffset,
        child: widget.child,
      );
    }
  }
}

/// Internal overlay widget that provides the floating action button UI.
///
/// This widget handles the positioning and styling of the floating action button
/// and provides two positioning modes:
/// 1. Standard Flutter locations using [FloatingActionButtonLocation]
/// 2. Custom positioning using offset values
class _FakeFillerOverlay extends StatelessWidget {
  /// The child widget to display under the floating action button.
  final Widget? child;

  /// Callback function to execute when the floating action button is tapped.
  final VoidCallback onFillForms;

  /// Custom icon for the floating action button.
  final IconData? fabIcon;

  /// Custom background color for the floating action button.
  final Color? fabBackgroundColor;

  /// Custom tooltip text for the floating action button.
  final String? fabTooltip;

  /// Standard Flutter location for the floating action button.
  /// When provided, takes precedence over custom offset positioning.
  final FloatingActionButtonLocation? fabLocation;

  /// Distance from the right edge of the screen in pixels.
  /// Only used when [fabLocation] is null.
  final double? fabRightOffset;

  /// Distance from the bottom edge of the screen in pixels.
  /// Only used when [fabLocation] is null.
  final double? fabBottomOffset;

  /// Creates a [_FakeFillerOverlay] widget.
  const _FakeFillerOverlay({
    required this.onFillForms,
    this.child,
    this.fabIcon,
    this.fabBackgroundColor,
    this.fabTooltip,
    this.fabLocation,
    this.fabRightOffset,
    this.fabBottomOffset,
  });

  @override
  Widget build(BuildContext context) {
    if (child == null) return const SizedBox.shrink();

    // Use Scaffold with standard positioning if a FAB location is specified
    if (fabLocation != null) {
      return Scaffold(
        body: child!,
        floatingActionButton: FloatingActionButton(
          onPressed: onFillForms,
          backgroundColor:
              fabBackgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: fabBackgroundColor != null
              ? _getContrastingTextColor(fabBackgroundColor!)
              : Theme.of(context).colorScheme.onPrimary,
          tooltip: fabTooltip,
          child: Icon(fabIcon ?? Icons.auto_fix_high),
        ),
        floatingActionButtonLocation: fabLocation,
      );
    }

    // Use Stack with custom positioning for precise control
    return Stack(
      children: [
        child!,
        Positioned(
          right: fabRightOffset ?? 16,
          bottom: fabBottomOffset ?? 16,
          child: FloatingActionButton(
            onPressed: onFillForms,
            backgroundColor:
                fabBackgroundColor ?? Theme.of(context).colorScheme.primary,
            foregroundColor: fabBackgroundColor != null
                ? _getContrastingTextColor(fabBackgroundColor!)
                : Theme.of(context).colorScheme.onPrimary,
            tooltip: fabTooltip,
            child: Icon(fabIcon ?? Icons.auto_fix_high),
          ),
        ),
      ],
    );
  }

  /// Calculates a contrasting text color for the given background color.
  ///
  /// Uses the luminance of the background color to determine whether
  /// black or white text would provide better contrast and readability.
  ///
  /// Returns [Colors.black] for light backgrounds and [Colors.white] for dark backgrounds.
  Color _getContrastingTextColor(Color backgroundColor) {
    // Calculate luminance to determine if text should be light or dark
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
