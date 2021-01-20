import 'package:http/http.dart';
import 'dart:convert';
import 'package:login_demo/models/user.dart';
import 'dart:io';
import 'package:login_demo/models/api_error.dart';
import 'package:login_demo/models/api_response.dart';
import 'dart:typed_data';

final String _baseUrl = "http://localhost:3000/api/v1";

final String _log_in_Url_Part = '/log_in';
final String _sign_up_Url_Part = '/sign_up';

//auth user if not logged in
Future<ApiResponse> authenticateUser(String email_username, String password) async {
  ApiResponse _apiResponse = new ApiResponse();

  final String auth_url = _baseUrl + _log_in_Url_Part;

  Map<String, dynamic> params = new Map();
  params['email'] = email_username;
  params['password'] = password;
  try {
    final response = await post(auth_url,
        headers: {
                    'content-type': 'application/json',
                    'accept': 'application/json',
                 },
        body: jsonEncode({
                            "user": params
                         }

        ));

    switch (response.statusCode) {
      case 201:
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
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}


Future<ApiResponse> registerUser(String email_username, String password, Uint8List avatar) async {
  ApiResponse _apiResponse = new ApiResponse();

  final String auth_url = _baseUrl + _sign_up_Url_Part;

  Map<String, dynamic> params = new Map();
  params['email'] = email_username;
  params['password'] = password;
  params['password_confirmation'] = password;

  if (avatar != null){
    String base64Image;
    base64Image = base64Encode(avatar);
    params['avatar'] = base64Image;
  }

  try {
    final response = await post(auth_url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode({
          "user": params
        }

        ));

    switch (response.statusCode) {
      case 201:
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError(error: "Unauthorized");
        break;
      case 500:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

