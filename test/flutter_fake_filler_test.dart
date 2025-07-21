import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

void main() {
  group('DataGenerator Tests', () {
    test('generates email addresses', () {
      final email = DataGenerator.email();
      expect(email, contains('@'));
      expect(email, contains('example'));
    });

    test('generates phone numbers', () {
      final phone = DataGenerator.phoneNumber();
      expect(phone.length, greaterThan(10));
      expect(phone, contains('('));
      expect(phone, contains(')'));
    });

    test('generates names', () {
      final firstName = DataGenerator.firstName();
      final lastName = DataGenerator.lastName();
      final fullName = DataGenerator.fullName();
      
      expect(firstName.isNotEmpty, true);
      expect(lastName.isNotEmpty, true);
      expect(fullName, contains(' '));
    });

    test('generates dates', () {
      final date = DataGenerator.date();
      expect(date, matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
    });

    test('generates websites', () {
      final website = DataGenerator.website();
      expect(website, startsWith('https://www.'));
      expect(website, contains('.'));
    });

    test('generates words', () {
      final words = DataGenerator.words(3);
      expect(words.split(' ').length, 3);
    });

    test('generates appropriate data for input types', () {
      final email = DataGenerator.getDataForInputType('email', 'email');
      final phone = DataGenerator.getDataForInputType('tel', 'phone');
      final name = DataGenerator.getDataForInputType('text', 'name');
      
      expect(email, contains('@'));
      expect(phone.length, greaterThan(10));
      expect(name, contains(' '));
    });
  });
}
