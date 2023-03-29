import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Transform.translate(
        // postion slightly above center
        offset: Offset(0, -Get.height/6),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Email",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width:1, color: Colors.black), borderRadius: BorderRadius.zero),
                      contentPadding:
                          EdgeInsets.fromLTRB(10, 7, 0, 7),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print("Login success");
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                            shadowColor: Colors.transparent,
                            backgroundColor: const Color.fromARGB(255, 71, 71, 71)),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Login"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
