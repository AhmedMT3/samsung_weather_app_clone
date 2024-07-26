import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/app_config.dart';
import 'package:weather_app/model/api_response.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';

class ApiServices {
  Future<Either<ApiResponse, Map<String, dynamic>>> getRequest({
    required String endPoint,
  }) async {
    String fullUrl = AppConfig.baseUrl + endPoint;
    bool isOnline = await AppHelpers.checkInternet();

    try {
      if (isOnline) {
        http.Response response = await http.get(Uri.parse(fullUrl));

        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(jsonDecode(response.body));
        } else if (response.statusCode == 400) {
          return const Left(ApiResponse.wrongLocation);
        } else {
          return const Left(ApiResponse.serverErr);
        }
      } else {
        return const Left(ApiResponse.offline);
      }
    } catch (_) {
      return const Left(ApiResponse.unknownErr);
    }
  }

  //=======================================================
  // postRequest({required String endPoint, data}) async {
  //   String fullUrl = AppConfig.baseUrl + endPoint;

  //   http.Response response =
  //       await http.post(Uri.parse(fullUrl), body: data);

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     return null;
  //   }
  // }
}
