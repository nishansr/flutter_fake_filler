import 'dart:math';
import 'dummy_data.dart';

/// Utility class for generating various types of dummy data for form fields.
///
/// This class provides static methods to create realistic fake data including:
/// - Personal information (names, emails, phone numbers)
/// - Web-related data (URLs, email addresses)
/// - Text content (words, sentences, paragraphs)
/// - Numeric data (random numbers, dates)
/// - Context-aware data based on field types and constraints
///
/// All methods are designed to respect field constraints like maxLength
/// and maxLines while generating appropriate content for different input types.
///
/// Example usage:
/// ```dart
/// final email = DataGenerator.email();
/// final name = DataGenerator.fullName();
/// final text = DataGenerator.getDataForInputType('email', 'userEmail');
/// ```
class DataGenerator {
  /// Private constructor to prevent instantiation.
  /// This class is intended to be used only through its static methods.
  DataGenerator._();

  /// Random number generator instance used throughout the class.
  ///
  /// Uses a single instance to ensure consistent randomization
  /// while avoiding the overhead of creating multiple Random objects.
  static final Random _random = Random();

  /// Generates a random integer within the specified range.
  ///
  /// Parameters:
  /// - [start]: The minimum value (inclusive)
  /// - [end]: The maximum value (inclusive)
  /// - [decimalPlaces]: Number of decimal places for precision (default: 0)
  ///
  /// Returns an integer between [start] and [end] inclusive.
  /// If [start] > [end], the values are automatically swapped.
  /// If [start] == [end], returns that value.
  ///
  /// Example:
  /// ```dart
  /// final age = DataGenerator.randomNumber(18, 65); // Random age
  /// final score = DataGenerator.randomNumber(0, 100); // Random score
  /// ```
  static int randomNumber(int start, int end, [int decimalPlaces = 0]) {
    if (start > end) {
      // Swap if start is greater than end
      int temp = start;
      start = end;
      end = temp;
    }

    if (start == end) {
      return start; // Return the value if they're equal
    }

    final min = start;
    final max = end;
    double result = _random.nextDouble() * (max - min + 1) + min;

    if (decimalPlaces > 0) {
      result = double.parse(result.toStringAsFixed(decimalPlaces));
      result = result > max ? max.toDouble() : result;
      return result.toInt();
    }

    return result.floor();
  }

  /// Generates a scrambled (pseudo-random) word with alternating consonants and vowels.
  ///
  /// Creates pronounceable words by alternating between consonants and vowels,
  /// making the generated text more natural-sounding than pure random characters.
  ///
  /// Parameters:
  /// - [minLength]: Minimum word length (default: 3, minimum: 1)
  /// - [maxLength]: Maximum word length (default: 15, maximum: 50)
  ///
  /// Returns a randomly generated word that follows basic phonetic patterns.
  ///
  /// Example:
  /// ```dart
  /// final word = DataGenerator.scrambledWord(); // e.g., "beloto"
  /// final shortWord = DataGenerator.scrambledWord(minLength: 2, maxLength: 5);
  /// ```
  static String scrambledWord({int minLength = 3, int maxLength = 15}) {
    if (minLength <= 0) minLength = 1;
    if (maxLength < minLength) maxLength = minLength;
    if (maxLength > 50) maxLength = 50; // Reasonable upper limit

    final wordLength = randomNumber(minLength, maxLength);
    String resultWord = "";
    bool odd = true;

    while (resultWord.length < wordLength) {
      final newSymbol = odd
          ? DummyData.consonants[_random.nextInt(DummyData.consonants.length)]
          : DummyData.vowels[_random.nextInt(DummyData.vowels.length)];

      odd = !odd;
      resultWord += newSymbol;
    }

    return resultWord;
  }

  /// Generates a specified number of words from the word bank.
  ///
  /// Selects random words from [DummyData.wordBank] and combines them
  /// into a coherent phrase. Respects maximum length constraints when provided.
  ///
  /// Parameters:
  /// - [wordCount]: Number of words to generate (must be > 0)
  /// - [maxLength]: Optional maximum total character length (default: 0 = no limit)
  ///
  /// Returns a string containing the specified number of words,
  /// or fewer words if maxLength constraint is hit.
  ///
  /// Example:
  /// ```dart
  /// final phrase = DataGenerator.words(3); // "lorem ipsum dolor"
  /// final short = DataGenerator.words(5, 20); // Respects 20 char limit
  /// ```
  static String words(int wordCount, [int maxLength = 0]) {
    if (wordCount <= 0) return '';

    String resultPhrase = "";

    for (int i = 0; i < wordCount; i++) {
      String word =
          DummyData.wordBank[_random.nextInt(DummyData.wordBank.length)];
      final phraseLength = resultPhrase.length;

      if (phraseLength == 0 ||
          resultPhrase.substring(phraseLength - 1, phraseLength) == "." ||
          resultPhrase.substring(phraseLength - 1, phraseLength) == "?") {
        word = word.substring(0, 1).toUpperCase() + word.substring(1);
      }

      String newPhrase = phraseLength > 0 ? "$resultPhrase $word" : word;

      // Check if adding this word would exceed maxLength
      if (maxLength > 0 && newPhrase.length > maxLength) {
        break;
      }

      resultPhrase = newPhrase;
    }

    // Final check and truncate if necessary
    if (maxLength > 0 && resultPhrase.length > maxLength) {
      resultPhrase = resultPhrase.substring(0, maxLength);
      // Try to end at word boundary
      int lastSpace = resultPhrase.lastIndexOf(' ');
      if (lastSpace > 0 && lastSpace > maxLength * 0.7) {
        resultPhrase = resultPhrase.substring(0, lastSpace);
      }
    }

    return resultPhrase;
  }

  /// Generates a random email address with a realistic username and domain.
  ///
  /// Creates an email by combining a random username (3-8 characters) with
  /// an "example" domain prefix and a random domain extension from the
  /// available domains list. Ensures the email doesn't exceed 50 characters.
  ///
  /// Returns:
  /// A string representing a fake email address.
  ///
  /// Example:
  /// ```dart
  /// final email = DataGenerator.email(); // "lorem@example.com"
  /// ```
  static String email() {
    String username = scrambledWord(minLength: 3, maxLength: 8).toLowerCase();
    final domain = DummyData.domains[_random.nextInt(DummyData.domains.length)];
    String result = "$username@example$domain";

    // Ensure email is not too long (basic check)
    if (result.length > 50) {
      username = scrambledWord(minLength: 3, maxLength: 5).toLowerCase();
      result = "$username@example.com";
    }

    return result;
  }

  /// Generates a random phone number using the specified template format.
  ///
  /// Replaces placeholder characters in the template with random digits:
  /// - 'X' is replaced with a digit from 1-9 (no leading zeros)
  /// - 'x' is replaced with a digit from 0-9
  /// - All other characters are preserved as-is
  ///
  /// Parameters:
  /// - [template]: The phone number format template. Defaults to "(XXX) XXX-XXXX"
  ///
  /// Returns:
  /// A string representing a formatted phone number.
  ///
  /// Example:
  /// ```dart
  /// final phone = DataGenerator.phoneNumber(); // "(555) 123-4567"
  /// final custom = DataGenerator.phoneNumber("XXX-XXX-XXXX"); // "555-123-4567"
  /// ```
  static String phoneNumber([String template = "(XXX) XXX-XXXX"]) {
    String telephone = "";

    for (int i = 0; i < template.length; i++) {
      if (template[i] == "X") {
        telephone += randomNumber(1, 9).toString();
      } else if (template[i] == "x") {
        telephone += randomNumber(0, 9).toString();
      } else {
        telephone += template[i];
      }
    }

    return telephone;
  }

  /// Generates a random date in YYYY-MM-DD format.
  ///
  /// Creates a date with:
  /// - Year: random between 1990 and current year
  /// - Month: random between 1-12
  /// - Day: random between 1-28 (to avoid invalid dates)
  ///
  /// Returns:
  /// A string representing a date in ISO 8601 format (YYYY-MM-DD).
  ///
  /// Example:
  /// ```dart
  /// final date = DataGenerator.date(); // "2023-05-15"
  /// ```
  static String date() {
    final randomYear = randomNumber(1990, DateTime.now().year);
    final randomMonth = randomNumber(1, 12);
    final randomDay = randomNumber(1, 28);

    return "${randomYear.toString().padLeft(4, '0')}-${randomMonth.toString().padLeft(2, '0')}-${randomDay.toString().padLeft(2, '0')}";
  }

  /// Generates a random first name from the available first names collection.
  ///
  /// Returns:
  /// A string representing a randomly selected first name.
  ///
  /// Example:
  /// ```dart
  /// final name = DataGenerator.firstName(); // "John" or "Sarah"
  /// ```
  static String firstName() {
    return DummyData.firstNames[_random.nextInt(DummyData.firstNames.length)];
  }

  /// Generates a random last name from the available last names collection.
  ///
  /// Returns:
  /// A string representing a randomly selected last name.
  ///
  /// Example:
  /// ```dart
  /// final name = DataGenerator.lastName(); // "Smith" or "Johnson"
  /// ```
  static String lastName() {
    return DummyData.lastNames[_random.nextInt(DummyData.lastNames.length)];
  }

  /// Generates a random full name by combining a first and last name.
  ///
  /// Returns:
  /// A string representing a complete name with first and last names
  /// separated by a space.
  ///
  /// Example:
  /// ```dart
  /// final name = DataGenerator.fullName(); // "John Smith"
  /// ```
  static String fullName() {
    return "${firstName()} ${lastName()}";
  }

  /// Generates a paragraph of random words with specified constraints.
  ///
  /// Creates a paragraph by generating a random number of words within the
  /// specified range, respecting the maximum length constraint. Automatically
  /// adds proper punctuation at the end if there's space.
  ///
  /// Parameters:
  /// - [minWords]: Minimum number of words to include (default: 10)
  /// - [maxWords]: Maximum number of words to include (default: 50)
  /// - [maxLength]: Maximum character length of the result (default: 200)
  ///
  /// Returns:
  /// A string representing a paragraph of text ending with a period.
  ///
  /// Example:
  /// ```dart
  /// final paragraph = DataGenerator.paragraph(); // "Lorem ipsum dolor sit amet..."
  /// final short = DataGenerator.paragraph(minWords: 3, maxWords: 5, maxLength: 50);
  /// ```
  static String paragraph({
    int minWords = 10,
    int maxWords = 50,
    int maxLength = 200,
  }) {
    if (minWords <= 0) minWords = 1;
    if (maxWords < minWords) maxWords = minWords;
    if (maxLength <= 0) maxLength = 200;

    final wordCount = randomNumber(minWords, maxWords);
    String resultPhrase = words(wordCount, maxLength);

    // Ensure we have some content even if maxLength is very small
    if (resultPhrase.isEmpty && maxLength > 0) {
      resultPhrase = words(1, maxLength);
    }

    // Add period only if there's room and content doesn't already end with punctuation
    if (resultPhrase.isNotEmpty &&
        !RegExp(r'[.!?]$').hasMatch(resultPhrase) &&
        (maxLength == 0 || resultPhrase.length < maxLength)) {
      resultPhrase += ".";
    }

    return resultPhrase;
  }

  /// Generates a random website URL with HTTPS protocol.
  ///
  /// Creates a realistic website URL by combining:
  /// - Protocol: "https://"
  /// - Subdomain: "www." (optional based on length constraints)
  /// - Domain name: randomly generated word (3-8 characters)
  /// - Domain extension: random selection from available domains
  ///
  /// Ensures the URL doesn't exceed 50 characters for practical use.
  ///
  /// Returns:
  /// A string representing a fake website URL.
  ///
  /// Example:
  /// ```dart
  /// final url = DataGenerator.website(); // "https://www.lorem.com"
  /// ```
  static String website() {
    String scrambledWord = DataGenerator.scrambledWord(
      minLength: 3,
      maxLength: 8,
    ).toLowerCase();
    final randomDomain =
        DummyData.domains[randomNumber(0, DummyData.domains.length - 1)];
    String result = "https://www.$scrambledWord$randomDomain";

    // Ensure website URL is not too long
    if (result.length > 50) {
      scrambledWord = DataGenerator.scrambledWord(
        minLength: 3,
        maxLength: 5,
      ).toLowerCase();
      result = "https://$scrambledWord.com";
    }

    return result;
  }

  /// Intelligently generates appropriate fake data based on input type and field name.
  ///
  /// This is the core method that analyzes HTML input types and field names
  /// to determine the most appropriate type of fake data to generate. It uses
  /// pattern matching on both the input type attribute and field name to
  /// provide contextually relevant data.
  ///
  /// Supported field types and patterns:
  /// - **Email**: input type "email" or field names containing "email"/"mail"
  /// - **Phone**: input type "tel" or field names containing "phone"/"tel"/"mobile"
  /// - **Date**: input type "date" or field names containing "date"/"birth"
  /// - **URL**: input type "url" or field names containing "url"/"website"
  /// - **Number**: input type "number" or field names containing "age"/"count"/"amount"
  /// - **Name fields**: Detects first name, last name, or full name patterns
  /// - **Multi-line text**: Detects bio, description, comment fields or when maxLines > 1
  /// - **Default**: Random words for unrecognized fields
  ///
  /// Parameters:
  /// - [inputType]: The HTML input type attribute (e.g., "email", "tel", "text")
  /// - [fieldName]: The field name, id, or placeholder text for context
  /// - [maxLength]: Maximum character length constraint (optional)
  /// - [maxLines]: Maximum number of lines for multi-line content (optional)
  ///
  /// Returns:
  /// A string containing appropriate fake data for the detected field type,
  /// respecting length and line constraints.
  ///
  /// Example:
  /// ```dart
  /// // Email field detection
  /// final email = DataGenerator.getDataForInputType("email", null);
  /// // "lorem@example.com"
  ///
  /// // Phone field detection
  /// final phone = DataGenerator.getDataForInputType("tel", "phone_number");
  /// // "(555) 123-4567"
  ///
  /// // Multi-line with constraints
  /// final bio = DataGenerator.getDataForInputType("text", "bio",
  ///   maxLength: 100, maxLines: 3);
  /// // "Lorem ipsum dolor sit amet...\nConsectetur adipiscing elit..."
  /// ```
  static String getDataForInputType(
    String? inputType,
    String? fieldName, {
    int? maxLength,
    int? maxLines,
  }) {
    // Validate input parameters
    if (maxLength != null && maxLength <= 0) {
      return ''; // Return empty string for invalid maxLength
    }
    if (maxLines != null && maxLines <= 0) {
      maxLines = 1; // Default to single line for invalid maxLines
    }

    // Detect field type based on input type and field name
    inputType = inputType?.toLowerCase();
    fieldName = fieldName?.toLowerCase() ?? '';

    String result = '';

    // Email detection
    if (inputType == 'email' ||
        fieldName.contains('email') ||
        fieldName.contains('mail')) {
      result = email();
    }
    // Phone detection
    else if (inputType == 'tel' ||
        fieldName.contains('phone') ||
        fieldName.contains('tel') ||
        fieldName.contains('mobile')) {
      result = phoneNumber();
    }
    // Date detection
    else if (inputType == 'date' ||
        fieldName.contains('date') ||
        fieldName.contains('birth')) {
      result = date();
    }
    // URL detection
    else if (inputType == 'url' ||
        fieldName.contains('url') ||
        fieldName.contains('website')) {
      result = website();
    }
    // Number detection
    else if (inputType == 'number' ||
        fieldName.contains('age') ||
        fieldName.contains('count') ||
        fieldName.contains('amount')) {
      result = randomNumber(1, 100).toString();
    }
    // Name detection
    else if (fieldName.contains('firstname') ||
        fieldName.contains('first_name')) {
      result = firstName();
    } else if (fieldName.contains('lastname') ||
        fieldName.contains('last_name')) {
      result = lastName();
    } else if (fieldName.contains('name') || fieldName.contains('username')) {
      result = fullName();
    }
    // Bio, description, comment, message - multi-line text
    else if (fieldName.contains('bio') ||
        fieldName.contains('description') ||
        fieldName.contains('comment') ||
        fieldName.contains('message') ||
        fieldName.contains('note') ||
        fieldName.contains('about') ||
        (maxLines != null && maxLines > 1)) {
      // Generate multi-line content
      if (maxLines != null && maxLines > 1) {
        List<String> lines = [];
        int targetLines = randomNumber(maxLines > 2 ? 2 : 1, maxLines);

        // Calculate safe length per line to avoid division by zero
        int lengthPerLine = 50; // Default length per line
        if (maxLength != null && maxLength > 0) {
          lengthPerLine = (maxLength / targetLines).floor();
          // Ensure minimum length per line
          if (lengthPerLine < 10) {
            lengthPerLine = 10;
            targetLines = (maxLength / lengthPerLine).floor();
            targetLines = targetLines > 0 ? targetLines : 1;
          }
        }

        for (int i = 0; i < targetLines; i++) {
          String line = paragraph(
            minWords: 3,
            maxWords: 8,
            maxLength: lengthPerLine,
          );
          if (line.isNotEmpty) {
            lines.add(line);
          }
        }
        result = lines.join('\n');
      } else {
        int paragraphLength = maxLength ?? 100;
        // Ensure minimum length for meaningful content
        if (paragraphLength < 10) {
          result = words(1);
        } else {
          result = paragraph(
            minWords: 5,
            maxWords: 15,
            maxLength: paragraphLength,
          );
        }
      }
    }
    // Default to random words for text fields
    else {
      result = words(randomNumber(2, 5));
    }

    // Respect maxLength constraint with improved logic
    if (maxLength != null && maxLength > 0 && result.length > maxLength) {
      if (maxLength < 5) {
        // For very short limits, just truncate
        result = result.substring(0, maxLength);
      } else {
        // Try to end at a word boundary for better readability
        result = result.substring(0, maxLength);
        int lastSpace = result.lastIndexOf(' ');
        int lastNewline = result.lastIndexOf('\n');
        int cutPoint = [lastSpace, lastNewline]
            .where((i) => i >= 0)
            .fold(-1, (prev, curr) => curr > prev ? curr : prev);

        // Only cut at word/line boundary if it doesn't make the result too short
        if (cutPoint > 0 && cutPoint > maxLength * 0.6) {
          result = result.substring(0, cutPoint);
        }
      }
    }

    return result.trim(); // Remove any trailing whitespace
  }
}
