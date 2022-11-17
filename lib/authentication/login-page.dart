import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kursova_bd/authentication/registration-page.dart';

import '../mainui/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  //ключ який юзається для ідентифікації стану форми
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF273746),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70, left: 40, bottom: 40),
            child: Text(
              'Log In',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),

          //inputs
          Container(
            margin: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                    hintText: 'Email',
                    validator: (val) {
                      final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!emailRegExp.hasMatch(val!)) return 'Enter valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    hintText: 'Password',
                    validator: (val) {
                      final passwordRegExp = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                      if (!passwordRegExp.hasMatch(val!)) return 'Enter valid password';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          top: 20, bottom: 20, left: 90, right: 90)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF3498DB)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const MainPage(),
                        ));
                      }
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have account?',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()));
                },
                child: const Text('Register',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3498DB),
                        fontWeight: FontWeight.w700)),
              )
            ],
          )
        ],
      ),
    );
  }
}
