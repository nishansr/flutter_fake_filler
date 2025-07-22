import 'package:flutter/material.dart';

/// A utility class for detecting and analyzing text input fields in a Flutter widget tree.
///
/// The [FormFieldDetector] provides methods to traverse the widget tree and locate
/// [TextField] and [TextFormField] widgets, extracting their controllers and
/// metadata for automated form filling purposes.
///
/// This class is designed to work with the Flutter Fake Filler package to
/// automatically detect form fields and generate appropriate fake data for them.
class FormFieldDetector {
  /// Discovers all [TextEditingController] instances in the widget tree.
  ///
  /// Performs a depth-first traversal of the widget tree starting from the
  /// provided context to locate all [TextField] and [TextFormField] widgets
  /// that have associated controllers.
  ///
  /// The method uses a visitor pattern to safely traverse the widget tree,
  /// handling any potential errors that might occur during traversal without
  /// stopping the discovery process.
  ///
  /// Parameters:
  /// - [context]: The [BuildContext] to start the widget tree traversal from
  ///
  /// Returns:
  /// A [List] of unique [TextEditingController] instances found in the tree.
  /// Duplicate controllers are automatically filtered out.
  ///
  /// Example:
  /// ```dart
  /// final controllers = FormFieldDetector.findTextFields(context);
  /// print('Found ${controllers.length} text fields');
  /// ```
  static List<TextEditingController> findTextFields(BuildContext context) {
    final List<TextEditingController> controllers = [];
    final Set<TextEditingController> uniqueControllers = {};

    // Find the root widget context
    void visitor(Element element) {
      try {
        final widget = element.widget;

        if (widget is TextField && widget.controller != null) {
          uniqueControllers.add(widget.controller!);
        } else if (widget is TextFormField && widget.controller != null) {
          uniqueControllers.add(widget.controller!);
        }

        element.visitChildren(visitor);
      } catch (e) {
        // Ignore individual widget errors and continue traversal
      }
    }

    try {
      context.visitChildElements(visitor);
    } catch (e) {
      // Ignore context traversal errors
    }

    controllers.addAll(uniqueControllers);
    return controllers;
  }

  /// Extracts metadata and configuration from a text field controller.
  ///
  /// Analyzes the widget tree to find the [TextField] or [TextFormField]
  /// associated with the given controller and extracts useful metadata
  /// for data generation purposes.
  ///
  /// The method attempts to determine:
  /// - **Input type**: Derived from [TextInputType] (email, phone, number, etc.)
  /// - **Field name**: Extracted from label text, hint text, or other identifiers
  /// - **Length constraints**: Maximum character length if specified
  /// - **Line constraints**: Maximum number of lines for multi-line fields
  ///
  /// This information is used by the data generator to provide contextually
  /// appropriate fake data for each field type.
  ///
  /// Parameters:
  /// - [controller]: The [TextEditingController] to analyze
  /// - [context]: The [BuildContext] for widget tree traversal
  ///
  /// Returns:
  /// A [Map] containing field metadata with the following keys:
  /// - `'inputType'`: String representing the input type ('text', 'email', 'tel', etc.)
  /// - `'fieldName'`: String containing the field name or label
  /// - `'maxLength'`: int? representing maximum character length
  /// - `'maxLines'`: int? representing maximum number of lines
  ///
  /// Example:
  /// ```dart
  /// final info = FormFieldDetector.getFieldInfo(emailController, context);
  /// print('Field type: ${info['inputType']}'); // 'email'
  /// print('Field name: ${info['fieldName']}'); // 'Email Address'
  /// ```
  static Map<String, dynamic> getFieldInfo(
    TextEditingController controller,
    BuildContext context,
  ) {
    // Try to find the associated TextField/TextFormField to get more info
    String inputType = 'text';
    String fieldName = '';
    int? maxLength;
    int? maxLines;
    bool found = false;

    void visitor(Element element) {
      if (found) return; // Stop searching once found

      try {
        final widget = element.widget;

        if (widget is TextField && widget.controller == controller) {
          // Extract input type from keyboard type
          if (widget.keyboardType == TextInputType.emailAddress) {
            inputType = 'email';
          } else if (widget.keyboardType == TextInputType.phone) {
            inputType = 'tel';
          } else if (widget.keyboardType == TextInputType.number) {
            inputType = 'number';
          } else if (widget.keyboardType == TextInputType.url) {
            inputType = 'url';
          } else if (widget.keyboardType == TextInputType.datetime) {
            inputType = 'date';
          }

          // Extract maxLength and maxLines
          maxLength = widget.maxLength;
          maxLines = widget.maxLines;

          // Try to extract field name from decoration
          if (widget.decoration?.labelText != null) {
            fieldName = widget.decoration!.labelText!;
          } else if (widget.decoration?.hintText != null) {
            fieldName = widget.decoration!.hintText!;
          }
          found = true;
          return;
        } else if (widget is TextFormField && widget.controller == controller) {
          // For TextFormField, extract what we can
          // Note: TextFormField's properties are more limited

          // Try to extract field name if decoration is available through reflection
          // This is a simplified approach - in practice, TextFormField properties
          // might need more complex extraction
          found = true;
          return;
        }

        element.visitChildren(visitor);
      } catch (e) {
        // Ignore individual widget errors and continue
      }
    }

    try {
      context.visitChildElements(visitor);
    } catch (e) {
      // Ignore context traversal errors
    }

    return {
      'inputType': inputType,
      'fieldName': fieldName,
      'maxLength': maxLength,
      'maxLines': maxLines,
    };
  }
}
