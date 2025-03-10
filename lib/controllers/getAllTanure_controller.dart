import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetAllTanureController extends GetxController {
  var isLoading = true.obs;
  var tenure = ''.obs;
  var dOjoining = ''.obs;
  var nights = ''.obs;
  var isActive = ''.obs;

  Future<void> fetchMafNumber() async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse('https://fcclub.co.in/api/BookHoliday/GetAllTaner?userId=3528'));

      if (response.statusCode == 200) {
        // Decode the JSON response body
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['Status'] == 1) {
          tenure.value = responseData['Tenure'].toString();
          dOjoining.value = responseData['DOjoining'];
          nights.value = responseData['Nights'].toString();
          isActive.value = responseData['Isactive'].toString();
          print("Fetched Data: $responseData");
        } else {
          print("Failed to fetch data: ${responseData['Message']}");
        }
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
