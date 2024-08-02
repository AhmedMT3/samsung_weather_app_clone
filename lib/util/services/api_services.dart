import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/config/app_config.dart';
import 'package:weather_app/model/enums.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';

class ApiServices {
  Future<Either<ApiResponse, dynamic>> getRequest({
    required String endPoint,
    bool isSearch = false,
  }) async {
    String fullUrl = AppConfig.baseUrl + endPoint;
    if (isSearch) {
      fullUrl = AppConfig.searchUrl + endPoint;
    }
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
}
