import 'package:chat_app/colors.dart';
import 'package:chat_app/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
GlobalKey formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.backgroundColor,
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.app_registration,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Login',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              DefaultTextForm(
                  controller: emailController,
                  labeltext: 'email',
                  type: TextInputType.emailAddress),
              DefaultTextForm(
                  controller: passwordController,
                  labeltext: 'password',
                  type: TextInputType.visiblePassword),
            ],
          ),
        ),
      ),
    );
  }
}
