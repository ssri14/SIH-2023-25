import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/features/main/controller/user_controller.dart';
import 'package:untitled/widgets/form_container_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = TextEditingController();
    final password = TextEditingController();
    final user = Get.put(UserController());
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xffD8EEFF),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/logo.png'),
              SizedBox(
                height: Get.width * 0.22,
              ),
              // buildTextField(userName, false),
              FormContainerWidget(
                prefixIcon: CupertinoIcons.profile_circled,
                controller: userName,
                hintText: 'Username',
              ),
              SizedBox(
                height: Get.width * 0.05,
              ),
              FormContainerWidget(
                prefixIcon: Icons.lock,
                controller: password,
                hintText: 'Password',
                isPasswordField: true,
              ),
              SizedBox(
                height: Get.width * 0.08,
              ),
              Center(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.blue,
                  onPressed: () {
                    if (userName.value.text.isEmpty ||
                        password.value.text.isEmpty) {
                      return;
                    }
                    user.loginUser(userName.value.text, password.value.text);
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

// TextField buildTextField(TextEditingController userName, bool hidden) {
//   return TextField(
//     obscureText: hidden,
//     decoration: const InputDecoration(
//         labelText: "username",
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(05)))),
//     controller: userName,
//   );
// }
}
