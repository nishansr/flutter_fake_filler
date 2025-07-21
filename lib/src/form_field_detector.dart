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

  static Map<String, dynamic> getFieldInfo(TextEditingController controller, BuildContext context) {
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
