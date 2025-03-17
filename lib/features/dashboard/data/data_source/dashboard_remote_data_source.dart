import 'dart:convert';

import 'package:material_purchase_app/core/api/api_client.dart';
import 'package:material_purchase_app/core/error/exception.dart';
import 'package:material_purchase_app/core/api/api_endpoints.dart';
import 'package:material_purchase_app/features/dashboard/data/models/material_purchase_model.dart';

abstract class DashboardRemoteDataSource {
  Future<MaterialPurchaseModel> getPurchaseData(int page);

  Future<String> purchaseRequest(Map<String, dynamic> data);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient client;

  DashboardRemoteDataSourceImpl({required this.client});

  @override
  Future<MaterialPurchaseModel> getPurchaseData(int page) async {
    final response = await client.getData(ApiEndpoints.getPurchaseData(page));
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return MaterialPurchaseModel.fromJson(data);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> purchaseRequest(Map<String, dynamic> data) async {
    final response = await client.postData(ApiEndpoints.purchaseRequest(), data);
    if (response.statusCode == 201) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return data['status_message'];
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }
}
