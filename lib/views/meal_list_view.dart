import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/meal_controller.dart';

class MealListView extends StatelessWidget {
  final MealController controller = Get.put(MealController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal List'),
      ),
      body: Obx(() {
        if (!controller.isConnected.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,  // Ikon Wi-Fi tercoret
                  size: 50,
                  color: Colors.red,  // Warna merah untuk menandakan kesalahan
                ),
                SizedBox(height: 10),
                Text(
                  'No Internet Connection',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.meals.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: controller.meals.length,
          itemBuilder: (context, index) {
            final meal = controller.meals[index];
            return ListTile(
              title: Text(meal.strMeal ?? ''),
              subtitle: Text(meal.strCategory ?? ''),
            );
          },
        );
      }),
    );
  }
}
