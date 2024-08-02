class AppConfig {
  static const String apiKey = "YOUR_API_KEY";
  static const String baseUrl =
      "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=8&aqi=no&alerts=no";
  static const String searchUrl =
      "https://api.weatherapi.com/v1/search.json?key=$apiKey";
}
