import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResultsController extends GetxController {
  var companiesFound = ['test'].obs;
  final TextEditingController searchController = TextEditingController();
}

class Results extends StatelessWidget {
  var box = GetStorage();
  ResultsController controller = Get.put(ResultsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Companies List",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Text("${controller.companiesFound.length} companies Found"),
                TextFormField(
                  controller: controller.searchController,
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Search Companies",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.zero),
                    contentPadding: EdgeInsets.fromLTRB(10, 7, 0, 7),
                  ),
                ),
                // ListView.builder(
                //     itemBuilder: (BuildContext, index) {
                //       return ListTile(
                //         title: Text("helo"),
                //       );
                //     },
                //     itemCount: controller.companiesFound.length)
              ],
            ),
          )),
    );
  }
}
