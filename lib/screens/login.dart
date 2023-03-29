import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:logindemoapp/screens/results.dart';

// returns response received from API request
Future<bool> getAndStoreResults(String email) async {
  var box = GetStorage();
  final dio = Dio();
  // Error handling can be improved if response format is fixed
  try {
    var response = await dio.post(
        'https://notaryapp-staging.herokuapp.com/customer/login',
        data: {'email': email});
    print(response.data['status']);
    if (response.data['status'] == 2) {
      box.write('response', response.data);
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }

  return true;
}

class LoginController extends GetxController {
  var isLoading = false.obs;
  var msg = "".obs;
  final TextEditingController emailController = TextEditingController();
}

class Login extends StatelessWidget {
  Login({super.key});
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Transform.translate(
        // postion slightly above center
        offset: Offset(0, -Get.height / 6),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Email",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.zero),
                      contentPadding: EdgeInsets.fromLTRB(10, 7, 0, 7),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.isLoading.value = true;
                      bool isFetchSuccessfull = await getAndStoreResults(controller.emailController.value.text);
                      controller.isLoading.value = false;
                      // If data fetch successfull navigate to next screen else display error message.
                      if (isFetchSuccessfull) {
                        Get.to(Results());
                      } else {
                        controller.msg.value = "Error occured";
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        shadowColor: Colors.transparent,
                        backgroundColor: const Color.fromARGB(255, 71, 71, 71)),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Login"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  // If loading, display progress indicator else display message.
                  child: Obx(() => controller.isLoading.value
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Center(child: Text(controller.msg.value))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
