import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper(this.city);

  final String city;

  Future call_api() async {
    String url = 'https://weatherapi-com.p.rapidapi.com/current.json?q=${city}';
    // String url = 'https://weatherapi-com.p.rapidapi.com/current.json?q=jaipur';

    Map<String, String> headers = {
      "X-RapidAPI-Key": "bd4d12606emshf830045c37e1a4ep10e15bjsne2565192f4b5",
      "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
    };
    var res = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      return {'error': true};
    }
  }
}
