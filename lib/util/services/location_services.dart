import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:weather_app/model/enums.dart';
import 'package:weather_app/util/helpers/app_helpers.dart';

class LocationServices {
  /// Get device location function
  Future<Either<LocationError, LocationData>> getLocation() async {
    bool isOnline = await AppHelpers.checkInternet();

    if (isOnline) {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      // Checking location services
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return const Left(LocationError.notEnabled);
        }
      }
      // Checking for permission
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return const Left(LocationError.denied);
        }
      }
      locationData = await location.getLocation();
      return Right(locationData);
    } else {
      return const Left(LocationError.offline);
    }
  }
}
