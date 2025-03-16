import 'dart:convert';

import 'package:material_purchase_app/core/cached/preferences.dart';
import 'package:material_purchase_app/core/cached/preferences_key.dart';
import 'package:material_purchase_app/features/dashboard/data/models/cart_products_model.dart';

abstract class DashboardLocalDataSource {
  Future<List<CartProductsModel>> addToCart(Map<String, dynamic> product);
  Future<List<CartProductsModel>> removeFromCart(int productId);
  Future<List<CartProductsModel>> loadCart();
  Future<void> clearCart();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final Preferences prefs;
  late List<CartProductsModel> cart;

  DashboardLocalDataSourceImpl({required this.prefs}) {
    _getCart();
  }

  void _getCart() async {
    final cartJson = prefs.getStringValue(keyName: PreferencesKey.kCartProducts);
    if (cartJson.isEmpty) {
      cart = <CartProductsModel>[];
      return;
    }

    final List<dynamic> jsonList = jsonDecode(cartJson);
    cart = jsonList.map((json) => CartProductsModel.fromJson(json)).toList();
  }

  @override
  Future<List<CartProductsModel>> addToCart(Map<String, dynamic> product) async {
    final cartProductsModel = CartProductsModel.fromJson(product);

    final productIndex = cart.indexWhere((item) => item.productId == cartProductsModel.productId);
    if (productIndex != -1) {
      cart[productIndex].quantity = cartProductsModel.quantity;
    } else {
      cart.add(cartProductsModel);
    }
    _saveCart(cart);
    return cart;
  }

  Future<void> _saveCart(List<CartProductsModel> cart) async {
    final cartJson = jsonEncode(cart.map((e) => e.toJson()).toList());
    await prefs.setStringValue(keyName: PreferencesKey.kCartProducts, value: cartJson);
  }

  @override
  Future<void> clearCart() async {
    await prefs.clearOne(keyName: PreferencesKey.kCartProducts);
  }

  @override
  Future<List<CartProductsModel>> loadCart() async => cart;

  @override
  Future<List<CartProductsModel>> removeFromCart(int productId) async {
    cart.removeWhere((item) => item.productId == productId);
    await _saveCart(cart);
    return cart;
  }
}
