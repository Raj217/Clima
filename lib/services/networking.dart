import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHandler {
  NetworkHandler(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      // TODO: Change print with alert
      print(response.statusCode);
    }
  }
}
