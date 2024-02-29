class UserCurrency {
  String? assetsTitle;
  String? assetsSvgPath;
  String? currencyType;
  List<Assets>? assets;

  UserCurrency({this.assetsTitle, this.assetsSvgPath, this.assets});

  UserCurrency.fromJson(Map<String, dynamic> json) {
    assetsTitle = json['assetsTitle'];
    currencyType = json['currencyType'];
    assetsSvgPath = json['assetsSvgPath'];
    if (json['assets'] != null) {
      assets = <Assets>[];
      json['assets'].forEach((v) {
        assets!.add(Assets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assetsTitle'] = assetsTitle;
    data['currencyType'] = currencyType;

    data['assetsSvgPath'] = assetsSvgPath;
    if (assets != null) {
      data['assets'] = assets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assets {
  String? assetType;
  int? amount;
  String? price;
  String? sumAmount;
  int? deleteIconActive;

  Assets({this.assetType, this.amount, this.price, this.sumAmount,this.deleteIconActive});

  Assets.fromJson(Map<String, dynamic> json) {
    assetType = json['assetType'];
    amount = json['amount'];
    price = json['price'];
    sumAmount = json['sumAmount'];
    deleteIconActive = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assetType'] = assetType;
    data['amount'] = amount;
    data['price'] = price;
    data['sumAmount'] = sumAmount;
    data['deleteIconActive'] = deleteIconActive;
    return data;
  }
}
