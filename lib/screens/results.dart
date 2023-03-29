import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResultsController extends GetxController {
  var companiesFound = ['test', "test2"].obs;
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Companies List",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      "${controller.companiesFound.length} companies Found"),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: controller.searchController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Search Companies",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        contentPadding: EdgeInsets.fromLTRB(20, 7, 0, 7),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 10),
                        itemBuilder: (BuildContext, index) {
                          return ListTile(
                            title: Text("Item"),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.blue),
                                borderRadius: BorderRadius.circular(10)),
                          );
                        },
                        itemCount: controller.companiesFound.length),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
