import 'package:flutter/material.dart';
import 'package:shop/widgets/gesture_detector.dart';
import 'package:shop/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //email textfield
              MyTextField(
                text: 'Email',
                controller: emailController,
              ),

              const SizedBox(
                height: 15,
              ),
              //password textfield
              MyTextField(
                text: 'Password',
                controller: passwordController,
              ),

              const SizedBox(
                height: 15,
              ),
              //login button
              MyGestureDetector(onTap: () {}, text: 'Login'),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register_page');
                },
                child: const Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              )

              //register button
            ],
          ),
        ),
      ),
    );
  }
}
