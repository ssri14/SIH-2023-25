import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/features/main/controller/user_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = TextEditingController();
    final password = TextEditingController();
    final user = Get.put(UserController());
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTextField(userName, false),
            SizedBox(height: 20,),
            buildTextField(password, true),
            MaterialButton(
              color: Colors.red,
              onPressed: () {
                if(userName.value.text.isEmpty || password.value.text.isEmpty) return;
                user.loginUser(userName.value.text, password.value.text);
              },
              child: const Text(
                "Log In",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      )),
    );
  }

  TextField buildTextField(TextEditingController userName, bool hidden) {
    return TextField(
      obscureText: hidden,
      decoration: const InputDecoration(
          labelText: "username",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(05)))),
      controller: userName,
    );
  }


}
