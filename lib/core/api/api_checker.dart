import 'package:http/http.dart' as http;

class ApiChecker {
  static void checkApi(http.Response response) {
    if(response.statusCode == 401) {
      // Get.find<AuthController>().logout();
    }else if(response.statusCode == 400 || response.statusCode == 403 || response.statusCode == 404) {
      // showCustomSnackBar(response.body);
    }else {
      // showCustomSnackBar(response.reasonPhrase);
    }
  }
}