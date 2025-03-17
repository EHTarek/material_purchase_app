
class PurchaseRequestParam {
  List<MaterialPurchase>? materialPurchase;

  PurchaseRequestParam({
    this.materialPurchase,
  });

  Map<String, dynamic> toJson() => {
    "material_purchase": materialPurchase == null ? []
        : List<dynamic>.from(materialPurchase!.map((x) => x.toJson())),
  };
}

class MaterialPurchase {
  String? lineItemName;
  String? store;
  String? runnersName;
  double? amount;
  int? cardNumber;
  String? transactionDate;

  MaterialPurchase({
    this.lineItemName,
    this.store,
    this.runnersName,
    this.amount,
    this.cardNumber,
    this.transactionDate,
  });


  Map<String, dynamic> toJson() => {
    "line_item_name": lineItemName,
    "store": store,
    "runners_name": runnersName,
    "amount": amount,
    "card_number": cardNumber,
    "transaction_date": transactionDate,
  };
}
