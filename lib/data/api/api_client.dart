import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    // taking baseUrl for GetConnect to send requests
    baseUrl = appBaseUrl;

    // how long should a request try if failing
    timeout = Duration(seconds: 30);

    _mainHeaders = {

      // this is telling that response and request interaction will be in json
      'Content-type': 'application/json; charset=UTF-8', // utf-8 is decoding and encoding sec

      // Bearer is type of authentication token for server, in this we will get auth from server
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri,) async {
    try{
      Response response = await get(uri);
      return response;
    }catch(e) {
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}
