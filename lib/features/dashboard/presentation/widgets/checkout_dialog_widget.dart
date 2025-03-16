import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:material_purchase_app/common/widgets/custom_button_widget.dart';
import 'package:material_purchase_app/common/widgets/custom_textfield_widget.dart';
import 'package:material_purchase_app/core/extentions/size_extension.dart';
import 'package:material_purchase_app/core/theme/style.dart';
import 'package:material_purchase_app/core/theme/theme.dart';
import 'package:material_purchase_app/features/dashboard/presentation/business_logic/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutDialogWidget extends StatefulWidget {
  const CheckoutDialogWidget({super.key});

  @override
  State<CheckoutDialogWidget> createState() => _CheckoutDialogWidgetState();
}

class _CheckoutDialogWidgetState extends State<CheckoutDialogWidget> {
  TextEditingController _itemController = TextEditingController();
  TextEditingController _storeController = TextEditingController();
  TextEditingController _runnerNameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _cardNoController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is CartUpdated,
      builder: (context, cartState) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ),
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeSmall,
                ),
                decoration: BoxDecoration(
                  color: context.color.primary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSmall)),
                ),
                child: Text('Material Purchase', style: fontMedium.copyWith(
                  fontSize: 13,
                  color: Colors.white, fontWeight: FontWeight.bold,
                ), textAlign: TextAlign.center),
              ),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: context.height * 0.8,
                  minHeight: context.height * 0.3,
                  minWidth: context.width,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Row(children: [
                       Expanded(child: Text('Items *', style: fontMedium.copyWith(
                         fontSize: 9, fontWeight: FontWeight.bold,
                       ))),
                        Expanded(child: CustomTextField(
                          hintText: 'Item name',
                          controller: _itemController,
                          radius: Dimensions.radiusSmall,
                          style: fontRegular.copyWith(fontSize: 9),
                          hintStyle: fontRegular.copyWith(fontSize: 9),
                        )),
                      ]),

                      Row(children: [
                        Expanded(child: Text('Store *', style: fontMedium.copyWith(
                          fontSize: 9, fontWeight: FontWeight.bold,
                        ))),
                        Expanded(child: CustomTextField(
                          hintText: 'Store name',
                          controller: _storeController,
                          radius: Dimensions.radiusSmall,
                          style: fontRegular.copyWith(fontSize: 9),
                          hintStyle: fontRegular.copyWith(fontSize: 9),
                        )),
                      ]),

                      Row(children: [
                        Expanded(child: Text("Runner's Name *", style: fontMedium.copyWith(
                          fontSize: 9, fontWeight: FontWeight.bold,
                        ))),
                        Expanded(child: CustomTextField(
                          hintText: 'Runner name',
                          controller: _runnerNameController,
                          radius: Dimensions.radiusSmall,
                          style: fontRegular.copyWith(fontSize: 9),
                          hintStyle: fontRegular.copyWith(fontSize: 9),
                        )),
                      ]),

                      Row(children: [
                        Expanded(child: Text('Amount *', style: fontMedium.copyWith(
                          fontSize: 9, fontWeight: FontWeight.bold,
                        ))),
                        Expanded(child: CustomTextField(
                          hintText: 'Amount',
                          controller: _amountController,
                          radius: Dimensions.radiusSmall,
                          isNumber: true,
                          inputType: TextInputType.number,
                          style: fontRegular.copyWith(fontSize: 9),
                          hintStyle: fontRegular.copyWith(fontSize: 9),
                        )),
                      ]),

                      Row(children: [
                        Expanded(child: Text('Card No *', style: fontMedium.copyWith(
                          fontSize: 9, fontWeight: FontWeight.bold,
                        ))),
                        Expanded(child: CustomTextField(
                          controller: _cardNoController,
                          radius: Dimensions.radiusSmall,
                          isNumber: true,
                          inputType: TextInputType.number,
                          style: fontRegular.copyWith(fontSize: 9),
                          hintStyle: fontRegular.copyWith(fontSize: 9),
                        )),
                      ]),

                      Row(children: [
                        Expanded(child: Text('Date *', style: fontMedium.copyWith(
                          fontSize: 9, fontWeight: FontWeight.bold,
                        ))),
                        Expanded(child: CustomTextField(
                          controller: _dateController,
                          hintText: '08-28-2024',
                          suffixChild: IconButton(
                            onPressed: () => _showCupertinoDatePicker(context),
                            icon: Icon(Icons.calendar_month_outlined),
                          ),
                          radius: Dimensions.radiusSmall,
                          style: fontRegular.copyWith(fontSize: 9),
                          hintStyle: fontRegular.copyWith(fontSize: 9),
                        )),
                      ]),

                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        CustomButton(
                          width: 70, height: 30,
                          fontSize: 10, radius: 5,
                          onPressed: () {
                            // context.read<CartCubit>().cartCheckout(carts: cartState.cart);
                            // context.pop();
                          },
                          buttonText: 'Save',
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          );
      },
    );
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext builder) {
        DateTime selectedDate = DateTime.now();

        return Container(
          height: 350,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime(2000),
                  maximumDate: DateTime(2100),
                  onDateTimeChanged: (DateTime newDate) {
                    selectedDate = newDate;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _dateController.text =
                  "${selectedDate.month}-${selectedDate.day}-${selectedDate.year}";
                  context.pop();
                },
                child: const Text("Done"),
              ),
            ],
          ),
        );
      },
    );
  }
}
