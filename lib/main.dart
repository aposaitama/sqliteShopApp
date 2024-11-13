import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/login_page.dart';
import 'package:shop/pages/register_page.dart';
import 'package:shop/provider/product_provider.dart';
import 'package:shop/provider/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            '/home_page': (context) => const HomePage(),
            '/login_page': (context) => const LoginPage(),
            '/register_page': (context) => const RegisterPage()
          },
          home: const LoginPage(),
        ));
  }
}
