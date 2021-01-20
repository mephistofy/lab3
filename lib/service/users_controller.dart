import 'package:http/http.dart';
import 'dart:convert';
import 'package:login_demo/models/user.dart';
import 'dart:io';
import 'package:login_demo/models/api_error.dart';
import 'package:login_demo/models/api_response.dart';
import 'package:login_demo/service/api_service.dart';

final String _baseUrl = "http://localhost:3000/api/v1";

final String _find_user_Url_Part = '/find_user';

Future<ApiResponse> getUser(String id) async {
  ApiResponse _apiResponse = new ApiResponse();

  final String auth_url = _baseUrl + _find_user_Url_Part + '?user_id=' + id;

  var credits = await getCredits();
  final String email = credits['email'];
  final String password = credits['password'];
  final String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$email:$password'));

  try {
    final response = await get(auth_url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': basicAuth
        },
    );

    switch (response.statusCode) {
      case 200:
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        _apiResponse.ApiError = ApiError(error: "Unauthorized");
        break;
      case 404:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      case 400:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      case 500:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}