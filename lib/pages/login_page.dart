import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/user_provider.dart';
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
              Consumer<UserProvider>(builder: (context, userProvider, child) {
                return MyGestureDetector(
                    onTap: () async {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isNotEmpty && password.isNotEmpty) {
                        try {
                          final isLoginCorrect =
                              await userProvider.login(email, password);

                          if (isLoginCorrect == true) {
                            Navigator.pushNamed(context, '/home_page');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Enter correct login and password')),
                            );
                          }
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
                    text: 'Login');
              }),

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
