import 'package:flutter/material.dart';

import '../utils/validator.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  _AuthMode _authMode = _AuthMode.Signup;
  Map<String, String> _authData = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Container(
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Authenticate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'E-Mail'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => _authData['email'] = value ?? '',
              validator: (value) => Validator.validateEmail(value),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              controller: _passwordController,
              onSaved: (value) => _authData['password'] = value ?? '',
              validator: (value) => _authMode == _AuthMode.Login ? null : Validator.validatePassword(value),
            ),
            const SizedBox(height: 20),
            if (_authMode == _AuthMode.Signup)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                onSaved: (value) => _authData['confirmPassword'] = value ?? '',
                validator: (value) {
                  if (value != _authData['password']) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text(_authMode == _AuthMode.Login ? 'Login' : 'Signup')),
          ],
        ),
      ),
    );
  }

  void _submit() {
    // Handle form submission
    // You can add validation and API calls here
    print('Form submitted');
  }
}

enum _AuthMode { Signup, Login }
