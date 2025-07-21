import 'package:flutter/material.dart';
import 'data_generator.dart';
import 'form_field_detector.dart';

class FakeFiller extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final IconData? fabIcon;
  final Color? fabBackgroundColor;
  final String? fabTooltip;
  final FloatingActionButtonLocation? fabLocation;
  final double? fabRightOffset;
  final double? fabBottomOffset;

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
  });

  @override
  State<FakeFiller> createState() => _FakeFillerState();
}

class _FakeFillerState extends State<FakeFiller> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  
  void _fillForms() {
    final context = _navigatorKey.currentContext ?? this.context;
    
    final controllers = FormFieldDetector.findTextFields(context);
    
    if (controllers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No text fields found on this screen'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    int filledCount = 0;
    for (final controller in controllers) {
      try {
        if (controller.text.isEmpty) {
          final fieldInfo = FormFieldDetector.getFieldInfo(controller, context);
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

    if (filledCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Filled $filledCount text field${filledCount == 1 ? '' : 's'}'),
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

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    // If the child is a MaterialApp, we need to wrap it properly
    if (widget.child is MaterialApp) {
      final materialApp = widget.child as MaterialApp;
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
        checkerboardRasterCacheImages: materialApp.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: materialApp.checkerboardOffscreenLayers,
        showSemanticsDebugger: materialApp.showSemanticsDebugger,
        debugShowCheckedModeBanner: materialApp.debugShowCheckedModeBanner,
        shortcuts: materialApp.shortcuts,
        actions: materialApp.actions,
        restorationScopeId: materialApp.restorationScopeId,
        scrollBehavior: materialApp.scrollBehavior,
      );
    } else {
      // For other widgets, just wrap with the overlay
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

class _FakeFillerOverlay extends StatelessWidget {
  final Widget? child;
  final VoidCallback onFillForms;
  final IconData? fabIcon;
  final Color? fabBackgroundColor;
  final String? fabTooltip;
  final FloatingActionButtonLocation? fabLocation;
  final double? fabRightOffset;
  final double? fabBottomOffset;

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

    // If a specific FAB location is provided, use Scaffold for proper positioning
    if (fabLocation != null) {
      return Scaffold(
        body: child!,
        floatingActionButton: FloatingActionButton(
          onPressed: onFillForms,
          backgroundColor: fabBackgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: fabBackgroundColor != null 
              ? _getContrastingTextColor(fabBackgroundColor!)
              : Theme.of(context).colorScheme.onPrimary,
          tooltip: fabTooltip,
          child: Icon(fabIcon ?? Icons.auto_fix_high),
        ),
        floatingActionButtonLocation: fabLocation,
      );
    }

    // Otherwise use Stack with custom positioning
    return Stack(
      children: [
        child!,
        Positioned(
          right: fabRightOffset ?? 16,
          bottom: fabBottomOffset ?? 16,
          child: FloatingActionButton(
            onPressed: onFillForms,
            backgroundColor: fabBackgroundColor ?? Theme.of(context).colorScheme.primary,
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

  // Helper method to get contrasting text color for better visibility
  Color _getContrastingTextColor(Color backgroundColor) {
    // Calculate luminance to determine if text should be light or dark
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
