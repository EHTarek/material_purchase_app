
class MaterialPurchaseEntity {
  String? statusCode;
  String? statusMessage;
  MaterialPurchaseListEntity? materialPurchaseList;

  MaterialPurchaseEntity({
    this.statusCode,
    this.statusMessage,
    this.materialPurchaseList,
  });

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "material_purchase_list": materialPurchaseList?.toJson(),
  };
}

class MaterialPurchaseListEntity {
  int? currentPage;
  List<DataEntity>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<LinkEntity>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  MaterialPurchaseListEntity({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

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

class DataEntity {
  int? id;
  String? lineItemName;
  String? store;
  String? runnersName;
  double? amount;
  String? cardNumber;
  String? transactionDate;

  DataEntity({
    this.id,
    this.lineItemName,
    this.store,
    this.runnersName,
    this.amount,
    this.cardNumber,
    this.transactionDate,
  });

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

class LinkEntity {
  String? url;
  String? label;
  bool? active;

  LinkEntity({
    this.url,
    this.label,
    this.active,
  });

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
