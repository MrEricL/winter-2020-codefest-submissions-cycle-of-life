import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpProvider {
  Future<bool> getResponse(String imageUrl) async {
    // set up POST request arguments
    var encodedImageUrl = base64.encode(utf8.encode(imageUrl));
    String url = 'http://127.0.0.1:5000/?img=' + encodedImageUrl;
    // Map<String, String> headers = {"Content-type": "application/json"};

    http.Response response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    Iterable l = json.decode(response.body);
    print(l);
    if (response.body != null) {
      return true;
    } else {
      return false;
    }
  }
}
