/// Enum to specifiy api response errors
enum ApiResponse {
  loading,
  ok,
  wrongLocation,
  offline,
  serverErr,
  unknownErr,
}

/// Enum to specifiy location access errors
enum LocationError{
  notEnabled,
  denied,
  offline,
}