import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FakeFiller(
      enabled: true, // Enable the fake filler
      fabBackgroundColor: Colors.deepPurple, // Custom FAB color
      fabIcon: Icons.auto_awesome, // Custom icon
      fabTooltip: 'Auto-fill all empty fields',
      showSnackbar: true, // Show snackbar after filling (default: true)
      // Use standard Flutter FAB locations
      fabLocation: FloatingActionButtonLocation.endFloat,
      
      // Alternative: Use custom positioning with offsets
      // fabRightOffset: 20,
      // fabBottomOffset: 80,
      
      child: MaterialApp(
        title: 'Flutter Fake Filler Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _ageController = TextEditingController();
  final _bioController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _ageController.dispose();
    _bioController.dispose();
    _shortDescriptionController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Fake Filler Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Sign Up Form',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tap the floating action button to automatically fill all empty fields with dummy data!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _websiteController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Website URL',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _shortDescriptionController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Short Description (max 50 chars)',
                    border: OutlineInputBorder(),
                    helperText: 'Brief description about yourself',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _commentController,
                  maxLines: 5,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    labelText: 'Comments (max 200 chars, 5 lines)',
                    border: OutlineInputBorder(),
                    helperText: 'Share your thoughts or feedback',
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    // Clear all fields
                    _firstNameController.clear();
                    _lastNameController.clear();
                    _emailController.clear();
                    _phoneController.clear();
                    _websiteController.clear();
                    _ageController.clear();
                    _bioController.clear();
                    _shortDescriptionController.clear();
                    _commentController.clear();
                  },
                  child: const Text('Clear All Fields'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
 * Alternative configurations:
 * 
 * // Silent mode - no snackbars shown
 * FakeFiller(
 *   enabled: true,
 *   showSnackbar: false, // Disable snackbar notifications
 *   child: MaterialApp(...),
 * )
 * 
 * // Custom positioning with snackbars disabled
 * FakeFiller(
 *   enabled: true,
 *   showSnackbar: false,
 *   fabRightOffset: 30.0,
 *   fabBottomOffset: 100.0,
 *   child: MaterialApp(...),
 * )
 */
