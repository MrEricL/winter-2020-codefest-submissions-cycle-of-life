import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpProvider {
  // String localhost() {
  //   if (Platform.isAndroid)
  //     return 'http://127.0.0.1:5000/';
  //   else // for iOS simulator
  //     return 'http://localhost:3000';
  // }

  Future<Map> getResponse(String imageUrl) async {
    var encodedImageUrl = base64.encode(utf8.encode(imageUrl));
    String url = 'http://127.0.0.1:5000/?img=' + encodedImageUrl;

    http.Response response = await http.get(url);

    var decoded = json.decode(response.body);
    print(decoded);
    return decoded;
  }
}
