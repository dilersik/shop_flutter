import 'package:flutter/material.dart';
import 'package:shop_flutter/widgets/auth_form.dart';

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
                colors: [Color.fromARGB(255, 255, 128, 0), Color.fromARGB(255, 255, 0, 0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'MyShop',
                  style: TextStyle(fontSize: 45, fontFamily: 'Anton', color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                AuthForm()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
