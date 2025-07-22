import 'package:flutter/foundation.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

void main() {
  debugPrint('🧪 Testing Flutter Fake Filler Data Generation');
  debugPrint('================================================');

  // Test email generation
  debugPrint('\n📧 Email Generation:');
  for (int i = 0; i < 3; i++) {
    debugPrint('  ${DataGenerator.email()}');
  }

  // Test phone generation
  debugPrint('\n📱 Phone Generation:');
  for (int i = 0; i < 3; i++) {
    debugPrint('  ${DataGenerator.phoneNumber()}');
  }

  // Test name generation
  debugPrint('\n👤 Name Generation:');
  for (int i = 0; i < 3; i++) {
    debugPrint('  ${DataGenerator.fullName()}');
  }

  // Test date generation
  debugPrint('\n📅 Date Generation:');
  for (int i = 0; i < 3; i++) {
    debugPrint('  ${DataGenerator.date()}');
  }

  // Test website generation
  debugPrint('\n🌐 Website Generation:');
  for (int i = 0; i < 3; i++) {
    debugPrint('  ${DataGenerator.website()}');
  }

  // Test contextual data generation
  debugPrint('\n🎯 Contextual Data Generation:');
  debugPrint(
    '  Email field: ${DataGenerator.getDataForInputType('email', 'email')}',
  );
  debugPrint(
    '  Phone field: ${DataGenerator.getDataForInputType('tel', 'phone')}',
  );
  debugPrint(
    '  Name field: ${DataGenerator.getDataForInputType('text', 'name')}',
  );
  debugPrint(
    '  Age field: ${DataGenerator.getDataForInputType('number', 'age')}',
  );
  debugPrint(
    '  Website field: ${DataGenerator.getDataForInputType('url', 'website')}',
  );

  // Test words generation
  debugPrint('\n📝 Text Generation:');
  debugPrint('  Short text: ${DataGenerator.words(3)}');
  debugPrint('  Medium text: ${DataGenerator.words(7)}');
  debugPrint('  Paragraph: ${DataGenerator.paragraph()}');

  debugPrint('\n✅ All data generation tests completed!');
}
