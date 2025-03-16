import 'package:material_purchase_app/features/dashboard/data/models/products_model.dart';
import 'package:material_purchase_app/features/dashboard/domain/entities/cart_products_entity.dart';

class CartProductsModel extends CartProductsEntity {
  CartProductsModel({super.productId, super.quantity, super.product});

  factory CartProductsModel.fromJson(Map<String, dynamic> json) {
    return CartProductsModel(
      productId: json['product_id'],
      quantity: json['quantity'],
      product: json['product'] is Map<String, dynamic>
          ? ProductsModel.fromJson(json['product'])
          : null,
    );
  }

  CartProductsEntity toEntity() {
    return CartProductsEntity(
      productId: productId,
      quantity: quantity,
      product: product,
    );
  }
}

extension CartResponse on CartProductsEntity {
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'product': product?.toJson(),
    };
  }
}