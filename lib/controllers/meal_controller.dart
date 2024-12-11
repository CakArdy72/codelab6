import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/meal_model.dart';

class MealController extends GetxController {
  var meals = <Meal>[].obs;
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    fetchMeals();
  }

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;

    Connectivity().onConnectivityChanged.listen((result) {
      isConnected.value = result != ConnectivityResult.none;
    });
  }

  void fetchMeals() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s='),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        meals.value = (data['meals'] as List)
            .map((meal) => Meal.fromJson(meal))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to fetch data from API");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
