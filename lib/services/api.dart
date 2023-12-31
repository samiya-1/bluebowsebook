import 'package:http/http.dart' as http;

class Api {
  final String url = "https://e1a9-117-213-7-56.ngrok-free.app";

  authData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    print(data);
    return await http.post(
      Uri.parse(fullUrl),
      body: data,

    );
  }
  postData( apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
    );
  }
  putData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.put(
      Uri.parse(fullUrl),
      body: data,
    );
  }
  getData(apiUrl) async {
    var fullUrl = url + apiUrl;
    // await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      // headers: _setHeaders()
    );
  }
  deleteData(apiUrl)async{
    var fullUrl = url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
    );
  }
}