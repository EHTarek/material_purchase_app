
class PurchaseRequestParam {
  List<MaterialPurchase>? materialPurchase;

  PurchaseRequestParam({
    this.materialPurchase,
  });

  factory PurchaseRequestParam.fromJson(Map<String, dynamic> json) => PurchaseRequestParam(
    materialPurchase: json["material_purchase"] == null ? []
        : List<MaterialPurchase>.from(json["material_purchase"]!.map((x) => MaterialPurchase.fromJson(x))),
  );

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

  factory MaterialPurchase.fromJson(Map<String, dynamic> json) => MaterialPurchase(
    lineItemName: json["line_item_name"],
    store: json["store"],
    runnersName: json["runners_name"],
    amount: json["amount"],
    cardNumber: json["card_number"],
    transactionDate: json["transaction_date"],
  );

  Map<String, dynamic> toJson() => {
    "line_item_name": lineItemName,
    "store": store,
    "runners_name": runnersName,
    "amount": amount,
    "card_number": cardNumber,
    "transaction_date": transactionDate,
  };
}
