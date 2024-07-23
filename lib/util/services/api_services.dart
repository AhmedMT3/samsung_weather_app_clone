import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/app_config.dart';

class ApiServices {
  // Map<String, String> myheaders = {
  //   'authorization': "Basic ${base64Encode(utf8.encode('ahmed:amt123'))}"
  // };

  getRequest({required String endPoint}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;

    http.Response response =
        await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  //=======================================================
  postRequest({required String endPoint, data}) async {
    String fullUrl = AppConfig.baseUrl + endPoint;

    http.Response response =
        await http.post(Uri.parse(fullUrl), body: data);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

}
