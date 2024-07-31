import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/core/themes/app_styles.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/view/widgets/search/search_result_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search location"),
      ),
      body: GetBuilder<WeatherController>(
        builder: (controller) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchBar(
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 15),
                    ),
                    elevation: const WidgetStatePropertyAll(1),
                    hintText: "Search location..",
                    trailing: const [Icon(Icons.search)],
                    onChanged: (value) => controller.searchLocation(value),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    if (controller.searchStatus.value == ApiResponse.ok) {
                      return SearchResultWidget(
                        controller: controller,
                        searchedLocations: controller.searchedLocations,
                      );
                    } else if (controller.searchStatus.value ==
                        ApiResponse.offline) {
                      return Lottie.asset('assets/lottie/offline.json');
                    } else if (controller.searchStatus.value ==
                        ApiResponse.loading) {
                      return Lottie.asset('assets/lottie/loading.json');
                    } else {
                      return Lottie.asset('assets/lottie/search.json');
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
