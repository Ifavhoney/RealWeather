import 'dart:convert';
import 'package:http/http.dart' as http;

//Generic data
final String defaultCity = "Toronto";
final String appKey = "ecefa6507e5c187871a92f4545b65f98";
final String bodyKey = "72ee81d849e4eb5a326978a3c232aad9";
//final String appKey = "94a3cc5f37a96a37469cbf6f607f7c59";

class WeatherAPIs {
  //Delivers Today's Forecast
  static Future<Map<String, dynamic>> callTodayAPI(
      String apiKey, String city) async {
    //https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=YOUR_API_KEY

    String endpoint =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey";

    //comes http package - http.response gets the entire package so we are able to call get
    http.Response response = await http.get(endpoint);
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> callForecastAPI(
      String apiKey, String city) async {
    String endpoint =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric";

    //comes http package - http.response gets the entire package so we are able to call get
    http.Response response = await http.get(endpoint);
    return jsonDecode(response.body);
  }

  void testForecastAPI() async {
    Map<String, dynamic> test = await callForecastAPI(appKey, defaultCity);
    print(test);
  }

  void testApi() async {
    Map<String, dynamic> test =
        await WeatherAPIs.callTodayAPI(appKey, defaultCity);
    print(test);
  }
}
