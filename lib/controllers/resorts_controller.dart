import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/Resorts.dart';

class PlacesController extends GetxController {
  var places = <Resorts>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPlaces();
    super.onInit();
  }

  void fetchPlaces() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(
          'https://hci.ndinfotech.com/api/AssociateResort/GetAssociateResort'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        places.value = data.map((json) => Resorts.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load places');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
