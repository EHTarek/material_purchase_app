import 'package:material_purchase_app/features/dashboard/domain/entities/products_entity.dart';

class CartProductsEntity {
  int? productId;
  int? quantity;
  set setQuantity(int? qty) => quantity = qty;
  ProductsEntity? product;

  CartProductsEntity({
    this.productId,
    this.quantity,
    this.product,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'product': product?.toJson(),
    };
  }
}