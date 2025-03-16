import 'dart:convert';

import 'package:material_purchase_app/core/api/api_checker.dart';
import 'package:material_purchase_app/core/extra/log.dart';
import 'package:material_purchase_app/core/extra/network_info.dart';
import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/extra/token_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ApiClient {
  final Preferences prefs;
  final TokenService tokenService;
  final Log log;
  final NetworkInfo networkInfo;
  static final String noInternetMessage = 'No internet connection!';
  final int timeoutInSeconds = 60;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({
    required this.prefs,
    required this.tokenService,
    required this.log, required this.networkInfo,
  }) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      token = await tokenService.getToken();

      updateHeader(token, 'en', null, null);
    } catch (e) {
      log.exception(title: 'Api Client : Initialization Error', msg: e);
    }
  }

  Map<String, String> updateHeader(String? token, String? languageCode, String? latitude, String? longitude, {bool setHeader = true}) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': token != null && token.isNotEmpty ? 'Bearer $token' : '',
    };

    if (setHeader){
      _mainHeaders = header;
    }
    return header;
  }

  Future<http.Response> getData(Uri uri, {Map<String, dynamic>? query, Map<String, String>? headers, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');

      http.Response response = await http.get(
        uri, headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : getData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }

  Future<http.Response> postData(Uri uri, dynamic body, {Map<String, String>? headers, int? timeout, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');
      log.debug(title: '====> API Body', msg: body);
      http.Response response = await http.post(
        uri, body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : postData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }

  Future<http.Response> postMultipartData(
      Uri uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');
      log.debug(title: '====> API Body', msg: '$body with ${multipartBody.length} files');

      http.MultipartRequest request = await _prepareMultipartRequest('POST', uri, body, multipartBody, headers: headers);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : postMultipartData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }

  Future<http.Response> putMultipartData(
      Uri uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');
      log.debug(title: '====> API Body', msg: '$body with ${multipartBody.length} files');
      http.MultipartRequest request = await _prepareMultipartRequest('PUT', uri, body, multipartBody, headers: headers);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : putMultipartData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }

  Future<http.Response> patchMultipartData(
      Uri uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');
      log.debug(title: '====> API Body', msg: '$body with ${multipartBody.length} files');
      http.MultipartRequest request = await _prepareMultipartRequest('PATCH', uri, body, multipartBody, headers: headers);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : patchMultipartData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }


  Future<http.Response> putData(Uri uri, dynamic body, {Map<String, String>? headers, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');
      log.debug(title: '====> API Body', msg: body);
      http.Response response = await http.put(
        uri, body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : putData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }

  Future<http.Response> patchData(Uri uri, dynamic body, {Map<String, String>? headers, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');
      log.debug(title: '====> API Body', msg: body);
      http.Response response = await http.patch(
        uri, body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : patchData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }

  Future<http.Response> deleteData(Uri uri, {Map<String, String>? headers, bool handleError = true}) async {
    try {
      await initialize();
      log.debug(title: '====> API Call: $uri', msg: 'Header: ${headers ?? _mainHeaders}');
      http.Response response = await http.delete(
        uri, headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      log.exception(title: 'Api Client : deleteData', msg: e);
      return http.Response(noInternetMessage, 504);
    }
  }

  http.Response handleResponse(http.Response response, Uri uri, bool handleError) {
    http.Response response0 = http.Response(
      response.body, response.statusCode,
      request: http.Request(response.request!.method, response.request!.url),
      headers: response.headers,
    );

    if ((response0.statusCode == 400 || response.statusCode == 403 || response.statusCode == 404) && response0.body.isNotEmpty) {
      String? error;
      if(response0.body.startsWith('{"message":')){
        error = jsonDecode(response0.body)['message'];
      }else if(response0.body.startsWith('{"detail":')){
        error = jsonDecode(response0.body)['detail'];
      }
      ErrorResponse errorResponse = ErrorResponse(error: error, code: response0.statusCode);
      response0 = http.Response(
        errorResponse.error ?? '', response0.statusCode,
        reasonPhrase: errorResponse.error,
      );
    } else if (response0.statusCode != 200 && response0.body.isEmpty) {
      response0 = http.Response(noInternetMessage, 504);
    }

    if (handleError) {
      if (response0.statusCode == 200 || response0.statusCode == 201) {
        return response0;
      } else {
        ApiChecker.checkApi(response0);
        return http.Response(response0.body, response0.statusCode);
      }
    } else {
      return response0;
    }
  }

  Future<http.MultipartRequest> _prepareMultipartRequest(
      String method, Uri uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    http.MultipartRequest request = http.MultipartRequest(method, uri);
    request.headers.addAll(headers ?? _mainHeaders!);

    for (MultipartBody multipart in multipartBody) {
      if (multipart.file != null) {
        Uint8List fileData = await multipart.file!.readAsBytes();
        String fileExtension = extension(multipart.file!.path);
        String mimeType = _getMimeType(fileExtension);
        String fileName = '${DateTime.now().toIso8601String()}$fileExtension';

        log.debug(title: '====> API Uploading file: ', msg: '$fileName of type $mimeType');

        request.files.add(http.MultipartFile(
          multipart.key,
          multipart.file!.readAsBytes().asStream(),
          fileData.length,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        ));
      }
    }
    request.fields.addAll(body);
    return request;
  }

  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.bmp':
        return 'image/bmp';
      case '.mp4':
      case '.m4v':
        return 'video/mp4';
      case '.mov':
        return 'video/quicktime';
      case '.pdf':
        return 'application/pdf';
      case '.doc':
        return 'application/msword';
      case '.docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case '.xls':
        return 'application/vnd.ms-excel';
      case '.xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case '.ppt':
        return 'application/vnd.ms-powerpoint';
      case '.pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case '.txt':
        return 'text/plain';
      case '.csv':
        return 'text/csv';
      case '.zip':
        return 'application/zip';
      case '.rar':
        return 'application/x-rar-compressed';
      case '.7z':
        return 'application/x-7z-compressed';
      default:
        return 'application/octet-stream';
    }
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}

class ErrorResponse {
  String? error;
  int? code;

  ErrorResponse({this.error, this.code});

  ErrorResponse.fromJson(dynamic json) {
    error = json["error"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "code": code,
  };
}

