/// Static data collections used for generating dummy content.
///
/// This class provides various arrays of words, names, and character sets
/// that are used by the [DataGenerator] to create realistic fake data
/// for form fields during development and testing.
///
/// All data is stored as static constants for optimal performance and
/// memory usage since these values never change during runtime.
class DummyData {
  /// Private constructor to prevent instantiation.
  /// This class is intended to be used only as a static data provider.
  DummyData._();

  /// Collection of consonant letters used for random text generation.
  ///
  /// These consonants are used when generating random words or when
  /// creating phonetically plausible text content. Excludes 'y' as it
  /// can function as both a consonant and vowel.
  static const List<String> consonants = [
    'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 
    'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'z'
  ];

  /// Collection of vowel letters used for random text generation.
  ///
  /// These vowels are combined with consonants to create pronounceable
  /// text sequences and ensure generated content has a natural flow.
  static const List<String> vowels = ['a', 'e', 'i', 'o', 'u'];

  /// Comprehensive word bank for generating realistic text content.
  ///
  /// This collection includes:
  /// - Classic Lorem Ipsum words for traditional placeholder text
  /// - Positive descriptive adjectives for professional content
  /// - Common action and concept words for varied contexts
  /// - Words suitable for bios, descriptions, and general text fields
  ///
  /// The words are carefully selected to create coherent, professional-sounding
  /// text when combined randomly, avoiding offensive or inappropriate content.
  static const List<String> wordBank = [
    'lorem', 'ipsum', 'dolor', 'sit', 'amet', 'consectetur',
    'adipiscing', 'elit', 'sed', 'do', 'eiusmod', 'tempor',
    'incididunt', 'ut', 'labore', 'et', 'dolore', 'magna',
    'aliqua', 'enim', 'ad', 'minim', 'veniam', 'quis',
    'nostrud', 'exercitation', 'ullamco', 'laboris', 'nisi',
    'aliquip', 'ex', 'ea', 'commodo', 'consequat', 'duis',
    'aute', 'irure', 'in', 'reprehenderit', 'voluptate',
    'velit', 'esse', 'cillum', 'fugiat', 'nulla', 'pariatur',
    'excepteur', 'sint', 'occaecat', 'cupidatat', 'non',
    'proident', 'sunt', 'culpa', 'qui', 'officia', 'deserunt',
    'mollit', 'anim', 'id', 'est', 'laborum', 'perspiciatis',
    'unde', 'omnis', 'iste', 'natus', 'error', 'voluptatem',
    'accusantium', 'doloremque', 'laudantium', 'totam', 'rem',
    'aperiam', 'eaque', 'ipsa', 'quae', 'ab', 'illo', 'inventore',
    'veritatis', 'quasi', 'architecto', 'beatae', 'vitae', 'dicta',
    'beautiful', 'amazing', 'wonderful', 'incredible', 'fantastic',
    'brilliant', 'awesome', 'excellent', 'outstanding', 'remarkable',
    'creative', 'innovative', 'inspiring', 'motivating', 'uplifting',
    'positive', 'cheerful', 'delightful', 'charming', 'graceful',
    'elegant', 'sophisticated', 'professional', 'talented', 'skilled',
    'experienced', 'knowledgeable', 'passionate', 'dedicated', 'committed',
    'reliable', 'trustworthy', 'honest', 'authentic', 'genuine',
    'friendly', 'welcoming', 'warm', 'caring', 'thoughtful',
    'considerate', 'helpful', 'supportive', 'encouraging', 'understanding',
    'adventure', 'journey', 'exploration', 'discovery', 'experience',
    'learning', 'growing', 'developing', 'improving', 'achieving',
    'success', 'progress', 'advancement', 'innovation', 'creativity',
    'imagination', 'inspiration', 'motivation', 'determination', 'perseverance',
    'challenge', 'opportunity', 'possibility', 'potential', 'future',
    'dream', 'goal', 'vision', 'mission', 'purpose', 'meaning',
    'value', 'worth', 'importance', 'significance', 'impact',
    'difference', 'change', 'transformation', 'improvement', 'enhancement',
    'quality', 'excellence', 'perfection', 'mastery', 'expertise'
  ];

  /// Common domain extensions for generating realistic email addresses and URLs.
  ///
  /// Includes the most frequently used top-level domains:
  /// - .com (commercial) - most common
  /// - .org (organization) - non-profits
  /// - .net (network) - internet infrastructure
  /// - .edu (education) - educational institutions
  /// - .gov (government) - government agencies
  /// - .mil (military) - military organizations
  /// - .biz (business) - business use
  /// - .info (information) - informational sites
  static const List<String> domains = [
    '.com', '.org', '.net', '.edu', '.gov', '.mil', '.biz', '.info'
  ];

  /// Collection of common first names for generating realistic personal data.
  ///
  /// This list includes:
  /// - Popular first names from various cultural backgrounds
  /// - Both traditional and modern naming conventions
  /// - Gender-neutral options for inclusive data generation
  /// - Names that are easily recognizable and professional
  ///
  /// The selection aims to represent diversity while maintaining
  /// familiarity for testing and development purposes.
  static const List<String> firstNames = [
    'James', 'Mary', 'John', 'Patricia', 'Robert', 'Jennifer',
    'Michael', 'Linda', 'William', 'Elizabeth', 'David', 'Barbara',
    'Richard', 'Susan', 'Joseph', 'Nishan', 'Jessica', 'Thomas', 'Sarah',
    'Christopher', 'Karen', 'Charles', 'Nancy', 'Sajan', 'Daniel', 'Lisa',
    'Matthew', 'Betty', 'Anthony', 'Helen', 'Mark', 'Sandra',
    'Donald', 'Donna', 'Steven', 'Carol', 'Rupesh', 'Paul', 'Yakeen', 'Ruth',
    'Andrew', 'Sharon', 'Joshua', 'Michelle', 'Kenneth', 'Laura',
    'Kevin', 'Emily', 'Brian', 'Kimberly', 'George', 'Deborah',
    'Edward', 'Dorothy', 'Ronald', 'Amy', 'Timothy', 'Angela'
  ];

  /// Collection of common last names/surnames for generating realistic personal data.
  ///
  /// This comprehensive list includes:
  /// - Surnames from various ethnic and cultural backgrounds
  /// - Common family names from different regions and languages
  /// - Names that reflect modern demographic diversity
  /// - Professional-sounding surnames suitable for business contexts
  ///
  /// When combined with first names, these create believable full names
  /// for testing user registration, contact forms, and profile data.
  static const List<String> lastNames = [
    'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia',
    'Miller', 'Davis', 'Rodriguez', 'Martinez', 'Hernandez',
    'Lopez', 'Gonzalez', 'Acharya', 'Adhikari', 'Wilson', 'Anderson', 'Thomas',
    'Taylor', 'Moore', 'Jackson', 'Martin', 'Lee', 'Perez',
    'Thompson', 'White', 'Harris', 'Sanchez', 'Clark', 'Ramirez',
    'Lewis', 'Robinson', 'Walker', 'Bishwokarma', 'Young', 'Allen', 'King',
    'Wright', 'Scott', 'Torres', 'Nguyen', 'Hill', 'Flores',
    'Green', 'Adams', 'Nelson', 'Baker', 'Hall', 'Rivera',
    'Campbell', 'Mitchell', 'Carter', 'Roberts', 'Gomez', 'Phillips'
  ];
}
