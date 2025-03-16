import 'package:material_purchase_app/core/theme/style.dart';
import 'package:material_purchase_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerWidget extends StatelessWidget {
  const ProductShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(color: context.color.border),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 12, width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 12, width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 12, width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 12, width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Icon(Icons.shopping_cart),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
