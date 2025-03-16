
import 'package:material_purchase_app/features/dashboard/domain/entities/material_purchase_entity.dart';

class MaterialPurchaseModel extends MaterialPurchaseEntity{
  MaterialPurchaseModel({
    super.statusCode,
    super.statusMessage,
    super.materialPurchaseList,
  });

  factory MaterialPurchaseModel.fromJson(Map<String, dynamic> json) => MaterialPurchaseModel(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    materialPurchaseList: json["material_purchase_list"] == null ? null : MaterialPurchaseListModel.fromJson(json["material_purchase_list"]),
  );

  @override
  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "material_purchase_list": materialPurchaseList?.toJson(),
  };
}

class MaterialPurchaseListModel extends MaterialPurchaseListEntity {
  MaterialPurchaseListModel({
    super.currentPage,
    super.data,
    super.firstPageUrl,
    super.from,
    super.lastPage,
    super.lastPageUrl,
    super.links,
    super.nextPageUrl,
    super.path,
    super.perPage,
    super.prevPageUrl,
    super.to,
    super.total,
  });

  factory MaterialPurchaseListModel.fromJson(Map<String, dynamic> json) => MaterialPurchaseListModel(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<DataModel>.from(json["data"]!.map((x) => DataModel.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<LinkModel>.from(json["links"]!.map((x) => LinkModel.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class DataModel extends DataEntity {
  DataModel({
    super.id,
    super.lineItemName,
    super.store,
    super.runnersName,
    super.amount,
    super.cardNumber,
    super.transactionDate,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    id: json["id"],
    lineItemName: json["line_item_name"],
    store: json["store"],
    runnersName: json["runners_name"],
    amount: json["amount"]?.toDouble(),
    cardNumber: json["card_number"],
    transactionDate: json["transaction_date"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "line_item_name": lineItemName,
    "store": store,
    "runners_name": runnersName,
    "amount": amount,
    "card_number": cardNumber,
    "transaction_date": transactionDate,
  };
}

class LinkModel extends LinkEntity {
  LinkModel({
    super.url,
    super.label,
    super.active,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
