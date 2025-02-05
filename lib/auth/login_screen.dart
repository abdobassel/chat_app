import 'package:chat_app/assets.dart';
import 'package:chat_app/auth/functions/login.dart';
import 'package:chat_app/auth/register_screen.dart';
import 'package:chat_app/chat_screens/chat_screen.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();
late final FirebaseAuth auth;
bool isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.backgroundColor,
      appBar: AppBar(
        title: Text(
          'L O G I N ',
          style: TextStyle(color: ColorClass.mainText, fontSize: 25),
        ),
        backgroundColor: ColorClass.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  AssetClass.logo,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 250,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                DefaultTextForm(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email can\t be empty';
                      }
                      return null;
                    },
                    controller: emailController,
                    labeltext: 'email',
                    type: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                DefaultTextForm(
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password can\t be empty';
                      } else if (value.length <= 3) {
                        return 'Can\t less than 4 characters';
                      }
                      return null;
                    },
                    controller: passwordController,
                    labeltext: 'password',
                    type: TextInputType.visiblePassword),
                const SizedBox(
                  height: 20,
                ),
                Conditional.single(
                  conditionBuilder: (context) => isLoading == false,
                  context: context,
                  fallbackBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  widgetBuilder: (context) => DefaultButton(
                      background: Colors.white,
                      text: "LOGIN",
                      isUperCase: true,
                      radius: 15,
                      function: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await login(
                            context,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have account..? ',
                      style:
                          TextStyle(color: ColorClass.mainText, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      },
                      child: Text(
                        '  Register',
                        style: TextStyle(color: ColorClass.link, fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
