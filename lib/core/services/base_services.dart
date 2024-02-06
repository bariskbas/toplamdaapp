import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:xapp/core/dtos/base_dto.dart';

class BaseService {
  Future<dynamic> getRequest<T extends BaseDTO>(
    String url,
    headers,
    BaseDTO baseDTO,
  ) async {
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    return await _handleResponse(baseDTO, response, url, null);
  }

  Future<dynamic> postRequest<T extends BaseDTO>(
    String url,
    body,
    headers,
    baseDTO,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    return await _handleResponse(baseDTO, response, url, body);
  }

  dynamic _handleResponse<T>(BaseDTO baseDTO, dynamic response, url, body) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        return _jsonBodyParser<T>(baseDTO, response);

      case HttpStatus.noContent:
        return _errorMessage();
      default:
        throw response.body;
    }
  }

  _errorMessage() {
    Get.back();

    Get.showSnackbar(const GetSnackBar(
      message: "İçerik bulunamadı.",
      duration: Duration(seconds: 1),
    ));
    return Future.error("Hatalı işlem yaptınız.");
  }

  dynamic _jsonBodyParser<T>(BaseDTO baseDTO, dynamic response) {
    final data = jsonDecode(response.body);

    if (data is List) {
      if (data.isNotEmpty) {
        if (data.first is String) {
          return data;
        }
        return data.map((e) => baseDTO.fromJson(e)).toList();
      } else {
        return [];
      }
    } else if (data is Map) {
      return baseDTO.fromJson(jsonDecode(response.body));
    } else {
      return response.body;
    }
  }
}
