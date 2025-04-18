import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../utils/validator.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  _AuthMode _authMode = _AuthMode.login;
  Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: Container(
        width: deviceSize.width * 0.85,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                _isLogin() ? 'Authenticate' : 'Register',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
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
                validator: (value) => _isLogin() ? null : Validator.validatePassword(value),
              ),
              const SizedBox(height: 20),
              if (_isSignup())
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  onSaved: (value) => _authData['confirmPassword'] = value ?? '',
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () => _submit(provider),
                  child: Text(_isLogin() ? 'Login' : 'Signup'),
                ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => _authModeToggle(),
                child: Text(_isLogin() ? 'Create new account' : 'I already have an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isLogin() => _authMode == _AuthMode.login;

  bool _isSignup() => _authMode == _AuthMode.signup;

  void _authModeToggle() => setState(() => _authMode = _isLogin() ? _AuthMode.signup : _AuthMode.login);

  Future<void> _submit(Auth provider) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();

    if (_isLogin()) {
    } else {
      await provider.signup(_authData['email']!, _authData['password']!);
    }

    setState(() => _isLoading = false);
  }
}

enum _AuthMode { signup, login }
