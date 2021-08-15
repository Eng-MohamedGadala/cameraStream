import 'package:cam_stream/pages/auth/presntation/controllers/auth_controller.dart';
import 'package:cam_stream/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginView extends GetView<AuthController> {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(),
    );
  }

  Widget _loginForm() {
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
              _userNameField(),
              _passwordField(),
              SizedBox(
                height: 20,
              ),
              _loginButton(),
              SizedBox(
                height: 20,
              ),
              Text(
                "OR",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _signinWithGoogle(controller),
              SizedBox(
                height: 20,
              ),
              _signupWithEmail()
            ],
          )),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          icon: Icon(Icons.password), hintText: 'Input password!'),
      controller: passwordController,
    );
  }

  Widget _signupWithEmail() {
    return TextButton(
      onPressed: () => Get.toNamed(Routes.SIGNUP),
      child: Text(
        "Sign up with Email",
        style: TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }

  Widget _userNameField() {
    return TextFormField(
      controller: emailController,
      decoration:
          InputDecoration(icon: Icon(Icons.person), hintText: 'User name!'),
    );
  }

  Widget _loginButton() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: Get.width),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.loginByEmail(
                  emailController.value.text, passwordController.value.text);
            }
          },
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _signinWithGoogle(controller) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: Get.width),
        child: ElevatedButton(
          child: Text(
            "Sign In with Google",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          onPressed: () {
            controller.login();
          },
        ),
      ),
    );
  }
}
