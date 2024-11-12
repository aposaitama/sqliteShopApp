import 'package:flutter/material.dart';
import 'package:shop/widgets/gesture_detector.dart';
import 'package:shop/widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              MyGestureDetector(onTap: () {}, text: 'Register'),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login_page');
                },
                child: const Text(
                  'Already have an account? Login',
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
