import 'package:cam_stream/pages/auth/presntation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignupView extends GetView<AuthController> {
  SignupView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: _signupForm(),
    );
  }

  Widget _signupForm() {
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/fire.png",
                width: 150,
              ),
              _emailField(),
              _passwordField(),
              SizedBox(
                height: 20,
              ),
              _signupButton(),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        icon: Icon(Icons.password),
        hintText: 'Input password!',
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Email name!',
      ),
    );
  }

  Widget _signupButton() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: Get.width),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.signUp(
                emailController.value.text,
                passwordController.value.text,
              );
            }
          },
          child: Text(
            'Signup',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
