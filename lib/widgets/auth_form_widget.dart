import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../utils/validator.dart';

const double _defaultHeight = 360;
const double _expandedHeight = 420;

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {'email': '', 'password': ''};
  _AuthMode _authMode = _AuthMode.login;
  bool _isLoading = false;
  AnimationController? _animationController;

  // Animation<Size>? _heightAnimation;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: AnimatedContainer(
        width: deviceSize.width * 0.85,
        // height: _heightAnimation?.value.height ?? (_isLogin() ? _defaultHeight : _expandedHeight)
        height: _isLogin() ? _defaultHeight : _expandedHeight,
        padding: const EdgeInsets.all(16),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
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
              // if (_isSignup())
              AnimatedContainer(
                constraints: BoxConstraints(minHeight: _isLogin() ? 0 : 60, maxHeight: _isLogin() ? 0 : 120),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
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
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(onPressed: () => _submit(provider), child: Text(_isLogin() ? 'Login' : 'Signup')),
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

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    // _heightAnimation = Tween<Size>(
    //   begin: const Size(double.infinity, _defaultHeight),
    //   end: const Size(double.infinity, _expandedHeight),
    // ).animate(CurvedAnimation(parent: _animationController!, curve: Curves.easeIn));
    //
    // _heightAnimation?.addListener(() { setState(() {}); });

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController!, curve: Curves.linear));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _animationController!, curve: Curves.linear));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isLogin() => _authMode == _AuthMode.login;

  bool _isSignup() => _authMode == _AuthMode.signup;

  void _authModeToggle() => setState(() {
    if (_isLogin()) {
      _authMode = _AuthMode.signup;
      _animationController?.forward();
    } else {
      _authMode = _AuthMode.login;
      _animationController?.reverse();
    }
  });

  Future<void> _submit(Auth provider) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();

    try {
      if (_isLogin()) {
        await provider.login(_authData['email']!, _authData['password']!);
      } else {
        await provider.signup(_authData['email']!, _authData['password']!);
      }
    } catch (error) {
      _showErrorDialog(error.toString());
    }

    setState(() => _isLoading = false);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('An error occurred!'),
            content: Text(message),
            actions: <Widget>[TextButton(child: const Text('Okay'), onPressed: () => Navigator.of(ctx).pop())],
          ),
    );
  }
}

enum _AuthMode { signup, login }
