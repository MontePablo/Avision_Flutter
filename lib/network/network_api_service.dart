import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class NetworkApiService extends BaseApiServices{
  @override
  Future getApi(String url) async {
    dynamic responseJson;
    // dynamic response;
    try{
      final resp= await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson=convertToJson(resp);
      // response=resp.body;
      kDebugMode?print("TAG ${resp.statusCode} ${resp.body}"):"";
    }on SocketException{
      throw FetchDataException("No internet connection");
    }
    return responseJson;
    // return response;
  }

  @override
    Future postApi(String url,dynamic data) async {
      dynamic responseJson;
      try{
        final response= await http.post(
            // Uri.parse(url),body: data
            Uri.parse(url),body: jsonEncode(data)
        ).timeout(Duration(seconds: 10));
        kDebugMode?print("TAG ${response.statusCode} ${response.body}"):"";
        responseJson=convertToJson(response);
      }on SocketException{
        throw FetchDataException("No internet connection");
      }
      return responseJson;
    }

  @override
  Future postMultiPartApi(String url, dynamic data) async {
    dynamic responseJson;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      dataToRequest(request,data).then((value) => request=value);

      var streamedResponse = await request.send();
      print("Request: " +request.toString());
      final response = await http.Response.fromStream(streamedResponse);
      kDebugMode?print("TAG ${response.statusCode} ${response.body}"):"";
      responseJson=convertToJson(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }

    return responseJson;
  }
}


  Future<http.MultipartRequest> dataToRequest(http.MultipartRequest request, Map<dynamic, dynamic> data) async {
    data.forEach((key, value) {
      if (value is String) {
        request.fields[key] = value;
      }
    });

    if (data.containsKey('image')) {
      var imageFile = File(data['image']);
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: imageFile.path.split('/').last,
      );

      request.files.add(multipartFile);
    }
    return request;
  }

  dynamic convertToJson(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson= jsonDecode(response.body);
        return responseJson;
      // case 400:
      //   throw BadRequestException(response.body.toString());

      default:
        throw FetchDataException("Error occurred while  communicating with server"+"with status code"+response.statusCode.toString());
    }
  }



abstract class BaseApiServices{
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(String url,dynamic data);
  Future<dynamic> postMultiPartApi(String url,Map<dynamic,dynamic> data);

}