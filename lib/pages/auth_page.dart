import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 128, 0),
                  Color.fromARGB(255, 255, 0, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Container(
                height: 300,
                width: 300,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Authenticate'),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: const InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {


                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}