# Basic Examples

Get started with Flutter Fake Filler using these simple, practical examples.

## Simple Form Example

The most basic implementation - wrap your form with `FakeFillerWidget`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class BasicFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FakeFillerWidget(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Form submission logic
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Result**: A floating action button appears that will fill all three fields with appropriate dummy data when tapped.

## Login Form Example

A typical login form with email and password fields:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          constraints: BoxConstraints(maxWidth: 400),
          child: FakeFillerWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Email: ${_emailController.text}');
                      print('Password: ${_passwordController.text}');
                    },
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

## Registration Form Example

A more complex form with multiple field types and constraints:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: FakeFillerWidget(
          fabLocation: FloatingActionButtonLocation.endFloat,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Personal Information Section
              Text(
                'Personal Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24),
              
              // Account Information Section
              Text(
                'Account Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                maxLength: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                maxLength: 50,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),
              
              // Additional Information
              Text(
                'Additional Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Website',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                  hintText: 'Tell us about yourself',
                ),
                maxLines: 3,
                maxLength: 200,
              ),
              SizedBox(height: 24),
              
              ElevatedButton(
                onPressed: () {
                  // Registration logic
                },
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Contact Form Example

A form with text area and various contact fields:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FakeFillerWidget(
          fabRightOffset: 20,
          fabBottomOffset: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get in Touch',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We\'d love to hear from you. Send us a message!',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 24),
              
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              
              TextField(
                decoration: InputDecoration(
                  labelText: 'Subject',
                  prefixIcon: Icon(Icons.subject),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLength: 100,
              ),
              
              TextField(
                decoration: InputDecoration(
                  labelText: 'Message',
                  prefixIcon: Icon(Icons.message),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter your message here...',
                ),
                maxLines: 5,
                maxLength: 500,
              ),
              
              SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Message sent!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Send Message',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Profile Form Example

A user profile form with mixed field types:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: FakeFillerWidget(
            fabLocation: FloatingActionButtonLocation.centerFloat,
            child: Column(
              children: [
                // Profile Picture Section
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Change Photo'),
                ),
                SizedBox(height: 24),
                
                // Personal Details
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a display name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter an email';
                    }
                    if (!value!.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Website',
                    border: OutlineInputBorder(),
                    hintText: 'https://example.com',
                  ),
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 16),
                
                // Address Information
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                
                // Bio Section
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                    hintText: 'Tell us about yourself...',
                  ),
                  maxLines: 4,
                  maxLength: 300,
                ),
                SizedBox(height: 24),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Profile updated!')),
                            );
                          }
                        },
                        child: Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## Try These Examples

1. Copy any of the above examples into your Flutter project
2. Import the `flutter_fake_filler` package
3. Run your app and tap the floating action button
4. Watch as all form fields are automatically filled with appropriate dummy data

## Next Steps

- [Advanced Examples](advanced.md)
- [Field Types Guide](../features/field-types.md)
- [Customization Options](../features/customization.md)
