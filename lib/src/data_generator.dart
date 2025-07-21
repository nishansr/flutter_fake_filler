import 'dart:math';
import 'dummy_data.dart';

class DataGenerator {
  static final Random _random = Random();

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

  static String words(int wordCount, [int maxLength = 0]) {
    if (wordCount <= 0) return '';
    
    String resultPhrase = "";

    for (int i = 0; i < wordCount; i++) {
      String word = DummyData.wordBank[_random.nextInt(DummyData.wordBank.length)];
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

  static String date() {
    final randomYear = randomNumber(1990, DateTime.now().year);
    final randomMonth = randomNumber(1, 12);
    final randomDay = randomNumber(1, 28);

    return "${randomYear.toString().padLeft(4, '0')}-${randomMonth.toString().padLeft(2, '0')}-${randomDay.toString().padLeft(2, '0')}";
  }

  static String firstName() {
    return DummyData.firstNames[_random.nextInt(DummyData.firstNames.length)];
  }

  static String lastName() {
    return DummyData.lastNames[_random.nextInt(DummyData.lastNames.length)];
  }

  static String fullName() {
    return "${firstName()} ${lastName()}";
  }

  static String paragraph({int minWords = 10, int maxWords = 50, int maxLength = 200}) {
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

  static String website() {
    String scrambledWord = DataGenerator.scrambledWord(minLength: 3, maxLength: 8).toLowerCase();
    final randomDomain = DummyData.domains[randomNumber(0, DummyData.domains.length - 1)];
    String result = "https://www.$scrambledWord$randomDomain";
    
    // Ensure website URL is not too long
    if (result.length > 50) {
      scrambledWord = DataGenerator.scrambledWord(minLength: 3, maxLength: 5).toLowerCase();
      result = "https://$scrambledWord.com";
    }
    
    return result;
  }

  static String getDataForInputType(String? inputType, String? fieldName, {int? maxLength, int? maxLines}) {
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
    else if (fieldName.contains('firstname') || fieldName.contains('first_name')) {
      result = firstName();
    }
    else if (fieldName.contains('lastname') || fieldName.contains('last_name')) {
      result = lastName();
    }
    else if (fieldName.contains('name') || fieldName.contains('username')) {
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
          String line = paragraph(minWords: 3, maxWords: 8, maxLength: lengthPerLine);
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
          result = paragraph(minWords: 5, maxWords: 15, maxLength: paragraphLength);
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
        int cutPoint = [lastSpace, lastNewline].where((i) => i >= 0).fold(-1, (prev, curr) => curr > prev ? curr : prev);
        
        // Only cut at word/line boundary if it doesn't make the result too short
        if (cutPoint > 0 && cutPoint > maxLength * 0.6) {
          result = result.substring(0, cutPoint);
        }
      }
    }

    return result.trim(); // Remove any trailing whitespace
  }
}
