import 'package:http/http.dart' as http;

class ApiService {

  Future<dynamic> getAllMatch(String date) async {
    var uri = Uri(path: "www.fotmob.com/api/matches?timezone=Asia/Tehran&countryCode=FI&ccode3=FIN8&sortOnClient=true",queryParameters: {"date":date});
    var response = http.get(uri);
    return response;
  }

}