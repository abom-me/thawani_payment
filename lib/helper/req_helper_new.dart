import 'dart:convert';
import 'package:http/http.dart' as http;

class Request {
  static Future get({
    required String url,
    required Map<String, String> headers,
  }) async {
    var url2 = Uri.parse(url);
    http.Response response = await http.get(
      url2,
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodeData = jsonDecode(data);
        return decodeData;
      } else {
        String data = response.body;
        var decodeData = jsonDecode(data);
        return decodeData;
      }
    } catch (e) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      return decodeData;
    }
  }

  static Future post({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  }) async {
    var url2 = Uri.parse(url);
    headers.addAll({'Content-Type': 'application/json'});
    http.Response response =
        await http.post(url2, headers: headers, body: jsonEncode(data));

    String data2 = response.body;
    var decodeData = jsonDecode(data2);
    return {'status': response.statusCode, 'data': decodeData};
  }

  static Future delete({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  }) async {
    var url2 = Uri.parse(url);

    http.Response response =
        await http.delete(url2, headers: headers, body: jsonEncode(data));

    String data2 = response.body;
    var decodeData = jsonDecode(data2);
    return {'status': response.statusCode, 'data': decodeData};
  }

  static Future put({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  }) async {
    var url2 = Uri.parse(url);
    Map<String, String> headerData = headers
      ..addAll({'content-type': 'application/json'});
    http.Response response =
        await http.put(url2, headers: headerData, body: jsonEncode(data));
    String data2 = response.body;
    var decodeData = jsonDecode(data2);
    return {'status': response.statusCode, 'data': decodeData};
  }

  static Future patch({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  }) async {
    var url2 = Uri.parse(url);
    Map<String, String> headerData = headers
      ..addAll({'content-type': 'application/json'});
    http.Response response =
        await http.patch(url2, headers: headerData, body: jsonEncode(data));
    String data2 = response.body;
    var decodeData = jsonDecode(data2);
    return {'status': response.statusCode, 'data': decodeData};
  }
}
