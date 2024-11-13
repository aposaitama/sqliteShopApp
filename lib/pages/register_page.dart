import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/user_provider.dart';
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
              // Email textfield
              MyTextField(
                text: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),

              // Password textfield
              MyTextField(
                text: 'Password',
                controller: passwordController,
              ),
              const SizedBox(height: 15),

              // Register button inside Consumer
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return MyGestureDetector(
                    onTap: () async {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isNotEmpty && password.isNotEmpty) {
                        try {
                          // Регистрация пользователя
                          await userProvider.register(email, password);

                          // Переход на домашнюю страницу
                          Navigator.pushNamed(context, '/home_page');
                        } catch (e) {
                          // Обработка ошибки регистрации
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Enter login and password')),
                        );
                      }
                    },
                    text: 'Register',
                  );
                },
              ),
              const SizedBox(height: 10),

              // Link to login page
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login_page');
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
