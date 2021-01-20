import 'package:http/http.dart';
import 'dart:convert';
import 'package:login_demo/models/user.dart';
import 'dart:io';
import 'package:login_demo/models/api_error.dart';
import 'package:login_demo/models/api_response.dart';
import 'package:login_demo/service/api_service.dart';
import 'package:login_demo/models/post.dart';
import 'dart:typed_data';

final String _baseUrl = "http://localhost:3000/api/v1";

final String _create_post_Url_Part = '/create_post';
final String _all_posts_Url_Part = '/all_posts';
final String _show_post_Url_Part = '/show_post';
final String _delete_post_Url_Part = '/delete_post';

Future<ApiResponse> createPost(String title, String description, Uint8List avatar) async {
  ApiResponse _apiResponse = new ApiResponse();
  final String auth_url = _baseUrl + _create_post_Url_Part;

  var credits = await getCredits();

  String base64Image = base64Encode(avatar);

  Map<String, dynamic> params = new Map();

  final String email = credits['email'];
  final String password = credits['password'];
  params['title'] = title;
  params['description'] = description;
  params['image'] = base64Image;

  final String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$email:$password'));

  try {
    final response = await post(auth_url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
           'authorization': basicAuth
        },
        body: jsonEncode({
          'post': params
        }

        ));

    switch (response.statusCode) {
      case 201:
        _apiResponse.Data = true;
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

Future<ApiResponse> getAllPosts(final int limit, final int offset) async {
  ApiResponse _apiResponse = new ApiResponse();
  final String limitString = limit.toString();
  final String offsetString = offset.toString();

  final String user_id = await getCurrentUserId();

  final String auth_url = _baseUrl + _all_posts_Url_Part + '?limit=' + limitString + '&offset=' + offsetString +'&user_id=' + user_id;


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
        List<Post> list = (json.decode(response.body)['posts'] as List )
        .map((data) => Post.fromJson(data))
        .toList();

        _apiResponse.Data = list;
        print(list);
        break;
      case 401:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      case 500:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      case 204:
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