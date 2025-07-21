# Advanced Examples

Explore sophisticated use cases and advanced patterns for Flutter Fake Filler.

## Multi-Step Form with Navigation

A wizard-style form across multiple screens, each with its own fake filler:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class MultiStepFormWizard extends StatefulWidget {
  @override
  _MultiStepFormWizardState createState() => _MultiStepFormWizardState();
}

class _MultiStepFormWizardState extends State<MultiStepFormWizard> {
  PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 3;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Wizard'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / _totalSteps,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentStep = index;
          });
        },
        children: [
          _buildPersonalInfoStep(),
          _buildContactInfoStep(),
          _buildPreferencesStep(),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return FakeFillerWidget(
      fabRightOffset: 16,
      fabBottomOffset: 100, // Above navigation buttons
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Step 1 of $_totalSteps',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                hintText: 'MM/DD/YYYY',
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            
            Spacer(),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoStep() {
    return FakeFillerWidget(
      fabRightOffset: 16,
      fabBottomOffset: 100,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Step 2 of $_totalSteps',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            
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
            SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.streetAddress,
              maxLines: 3,
            ),
            SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Emergency Contact',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            
            Spacer(),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesStep() {
    return FakeFillerWidget(
      fabRightOffset: 16,
      fabBottomOffset: 100,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Step 3 of $_totalSteps',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              maxLength: 20,
            ),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
                hintText: 'Tell us about yourself...',
              ),
              maxLines: 4,
              maxLength: 250,
            ),
            
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
                labelText: 'Interests',
                border: OutlineInputBorder(),
                hintText: 'Comma-separated interests',
              ),
              maxLength: 100,
            ),
            
            Spacer(),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: Text('Previous'),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _currentStep < _totalSteps - 1 ? _nextStep : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration completed!')),
                );
              },
              child: Text(_currentStep < _totalSteps - 1 ? 'Next' : 'Complete'),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Conditional Form Fields

Dynamic form that shows/hides fields based on user selections:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class ConditionalForm extends StatefulWidget {
  @override
  _ConditionalFormState createState() => _ConditionalFormState();
}

class _ConditionalFormState extends State<ConditionalForm> {
  String _userType = 'individual';
  bool _hasWebsite = false;
  bool _needsDelivery = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: FakeFillerWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Type Selection
              Text(
                'Account Type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              RadioListTile<String>(
                title: Text('Individual'),
                value: 'individual',
                groupValue: _userType,
                onChanged: (value) {
                  setState(() {
                    _userType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Business'),
                value: 'business',
                groupValue: _userType,
                onChanged: (value) {
                  setState(() {
                    _userType = value!;
                  });
                },
              ),
              SizedBox(height: 24),
              
              // Common Fields
              TextField(
                decoration: InputDecoration(
                  labelText: _userType == 'business' ? 'Business Name' : 'Full Name',
                  border: OutlineInputBorder(),
                ),
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
              
              // Conditional Business Fields
              if (_userType == 'business') ...[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Company Registration Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tax ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Business Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  maxLength: 200,
                ),
                SizedBox(height: 16),
              ],
              
              // Website Checkbox and Field
              CheckboxListTile(
                title: Text('I have a website'),
                value: _hasWebsite,
                onChanged: (value) {
                  setState(() {
                    _hasWebsite = value!;
                  });
                },
              ),
              
              if (_hasWebsite) ...[
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Website URL',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 16),
              ],
              
              // Delivery Option
              CheckboxListTile(
                title: Text('I need delivery service'),
                value: _needsDelivery,
                onChanged: (value) {
                  setState(() {
                    _needsDelivery = value!;
                  });
                },
              ),
              
              if (_needsDelivery) ...[
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Delivery Address',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Delivery Instructions',
                    border: OutlineInputBorder(),
                    hintText: 'Special instructions for delivery...',
                  ),
                  maxLines: 3,
                  maxLength: 150,
                ),
                SizedBox(height: 16),
              ],
              
              // Contact Information
              Text(
                'Contact Information',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              
              if (_userType == 'business') ...[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Alternative Contact Person',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Alternative Phone',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
              ],
              
              // Submit Button
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully!')),
                    );
                  },
                  child: Text('Submit'),
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

## Form with Validation

A comprehensive form with field validation and error handling:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class ValidatedForm extends StatefulWidget {
  @override
  _ValidatedFormState createState() => _ValidatedFormState();
}

class _ValidatedFormState extends State<ValidatedForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _autoValidate = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validated Form'),
        actions: [
          IconButton(
            icon: Icon(_autoValidate ? Icons.check_circle : Icons.check_circle_outline),
            onPressed: () {
              setState(() {
                _autoValidate = !_autoValidate;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _autoValidate ? 'Auto-validation enabled' : 'Auto-validation disabled'
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidate 
          ? AutovalidateMode.onUserInteraction 
          : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: FakeFillerWidget(
            fabLocation: FloatingActionButtonLocation.endFloat,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                          size: 48,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Complete Registration',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'All fields are required and will be validated',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                
                // Personal Information
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'First name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'First name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Last name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'Last name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                // Contact Information
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                    hintText: '+1 (555) 123-4567',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                ),
                SizedBox(height: 16),
                
                // Security
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    helperText: 'Must be 8+ chars with uppercase, lowercase, and number',
                  ),
                  obscureText: true,
                  validator: _validatePassword,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: _validateConfirmPassword,
                ),
                SizedBox(height: 16),
                
                // Additional Information
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Company (Optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business),
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Website (Optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.web),
                    hintText: 'https://example.com',
                  ),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final urlRegex = RegExp(r'^https?://[\w\-]+(\.[\w\-]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$');
                      if (!urlRegex.hasMatch(value)) {
                        return 'Please enter a valid URL (include http:// or https://)';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Bio (Optional)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                    hintText: 'Tell us about yourself...',
                  ),
                  maxLines: 3,
                  maxLength: 200,
                  validator: (value) {
                    if (value != null && value.length > 200) {
                      return 'Bio must be 200 characters or less';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                
                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Success!'),
                          content: Text('Form submitted successfully with valid data.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fix the errors above'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 16),
                
                // Clear Form Button
                OutlinedButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    _emailController.clear();
                    _phoneController.clear();
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  },
                  child: Text('Clear Form'),
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
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
```

## Responsive Layout with Different FAB Positions

A form that adapts to different screen sizes with responsive FAB positioning:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class ResponsiveForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Form'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine layout based on screen size
          bool isWide = constraints.maxWidth > 600;
          bool isTablet = constraints.maxWidth > 400 && constraints.maxWidth <= 600;
          
          // Calculate FAB position based on screen size
          double fabRightOffset = isWide ? 60.0 : (isTablet ? 30.0 : 16.0);
          double fabBottomOffset = isWide ? 60.0 : (isTablet ? 30.0 : 16.0);
          
          FloatingActionButtonLocation? fabLocation = isWide 
            ? null  // Use custom positioning for wide screens
            : FloatingActionButtonLocation.endFloat;
          
          Widget formContent = _buildFormContent(context, isWide);
          
          return FakeFillerWidget(
            fabLocation: fabLocation,
            fabRightOffset: fabLocation == null ? fabRightOffset : null,
            fabBottomOffset: fabLocation == null ? fabBottomOffset : null,
            child: isWide ? _buildWideLayout(formContent) : _buildNarrowLayout(formContent),
          );
        },
      ),
    );
  }

  Widget _buildWideLayout(Widget formContent) {
    return Row(
      children: [
        // Left side - Information panel
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.blue[50],
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.assignment,
                  size: 64,
                  color: Colors.blue[600],
                ),
                SizedBox(height: 24),
                Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Join thousands of users who trust our platform for their daily workflows.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[700],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 32),
                _buildFeatureList(),
              ],
            ),
          ),
        ),
        // Right side - Form
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                child: formContent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(Widget formContent) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    Icons.assignment,
                    size: 48,
                    color: Colors.blue[600],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Fill out the form below to get started',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          formContent,
        ],
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      'Secure data encryption',
      'Real-time synchronization',
      '24/7 customer support',
      'Mobile app access',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((feature) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green[600],
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              feature,
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 14,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildFormContent(BuildContext context, bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Personal Information
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 16),
        
        TextField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        
        TextField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 16),
        
        // Company Information
        TextField(
          decoration: InputDecoration(
            labelText: 'Company Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.business),
          ),
        ),
        SizedBox(height: 16),
        
        TextField(
          decoration: InputDecoration(
            labelText: 'Job Title',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.work),
          ),
        ),
        SizedBox(height: 16),
        
        // Additional Information
        TextField(
          decoration: InputDecoration(
            labelText: 'Website',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.web),
            hintText: 'https://example.com',
          ),
          keyboardType: TextInputType.url,
        ),
        SizedBox(height: 16),
        
        TextField(
          decoration: InputDecoration(
            labelText: 'How did you hear about us?',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.campaign),
          ),
          maxLines: 2,
          maxLength: 100,
        ),
        
        SizedBox(height: 24),
        
        // Submit Button
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Account created successfully!')),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: isWide ? 20 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Create Account',
            style: TextStyle(
              fontSize: isWide ? 18 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        if (!isWide) ...[
          SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: Text('Already have an account? Sign in'),
          ),
        ],
      ],
    );
  }
}
```

## Development-Only Integration

Show fake filler only in debug mode for production safety:

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fake_filler/flutter_fake_filler.dart';

class ProductionSafeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Production Safe Form'),
        backgroundColor: kDebugMode ? Colors.orange : Colors.blue,
      ),
      body: _buildFormWithConditionalFiller(),
    );
  }

  Widget _buildFormWithConditionalFiller() {
    Widget formWidget = _buildForm();
    
    // Only wrap with FakeFillerWidget in debug mode
    if (kDebugMode) {
      return FakeFillerWidget(
        fabLocation: FloatingActionButtonLocation.endFloat,
        child: formWidget,
      );
    }
    
    return formWidget;
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          if (kDebugMode)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.bug_report, color: Colors.orange[700]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'DEBUG MODE: Fake filler is active',
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Registration',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 30,
                  ),
                  
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
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16),
                  
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(),
                      hintText: 'Tell us about yourself',
                    ),
                    maxLines: 3,
                    maxLength: 150,
                  ),
                  
                  SizedBox(height: 16),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Production registration logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(kDebugMode 
                              ? 'Registration successful (DEBUG)' 
                              : 'Registration successful'
                            ),
                          ),
                        );
                      },
                      child: Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Next Steps

These advanced examples demonstrate the flexibility and power of Flutter Fake Filler in complex scenarios. Try implementing these patterns in your own projects:

- [API Reference](../api/overview.md)
- [Customization Guide](../features/customization.md)
- [Contributing](../contributing/guidelines.md)
