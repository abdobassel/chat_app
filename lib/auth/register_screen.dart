import 'package:chat_app/assets.dart';
import 'package:chat_app/auth/functions/register.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/components.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

TextEditingController nameController = TextEditingController();
GlobalKey formKey = GlobalKey<FormState>();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Register',
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
                    'Register',
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
                    controller: nameController,
                    labeltext: 'Name',
                    type: TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                DefaultTextForm(
                    controller: emailController,
                    labeltext: 'email',
                    type: TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                DefaultTextForm(
                    controller: passwordController,
                    labeltext: 'password',
                    type: TextInputType.visiblePassword),
                const SizedBox(
                  height: 15,
                ),
                DefaultButton(
                    background: Colors.white,
                    text: "Register",
                    isUperCase: true,
                    function: () async {
                      await register(
                          email: emailController.text,
                          password: passwordController.text);
                    }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' have account..? ',
                      style:
                          TextStyle(color: ColorClass.mainText, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Login',
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
