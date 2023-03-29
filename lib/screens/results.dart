import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Results extends StatelessWidget {
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(child: Center(child: Text(box.read('response')['data']['companiesList'].toString()),)),
    );
  }
}