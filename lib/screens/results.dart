import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

List<String> searchCompanies(String query) {
  var box = GetStorage();
  var cachedResponse = box.read('response');
  List<String> searchResults = [];

  // Search for a companies in local storage
  for (var result in cachedResponse['data']['companiesList']) {
    if (result['name'].toString().isCaseInsensitiveContains(query)) {
      searchResults.add(result['name']);
    }
  }

  return searchResults;
}

class ResultsController extends GetxController {
  var companiesFound = [].obs;
  final TextEditingController searchController = TextEditingController();
}

class Results extends StatelessWidget {
  Results({super.key});
  final box = GetStorage();
  final ResultsController controller = Get.put(ResultsController());

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
                      // Resultant List length is number of companies
                      "${controller.companiesFound.length} companies Found"),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: controller.searchController,
                      onChanged: (value) {
                        List<String> searchResults = searchCompanies(value);
                        controller.companiesFound.value = searchResults;
                      },
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
                    child: Material(
                      // Display matching companies
                      child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.companiesFound[index]),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10)),
                            );
                          },
                          itemCount: controller.companiesFound.length),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
