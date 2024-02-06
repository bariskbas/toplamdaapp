import 'package:xapp/core/dtos/base_dto.dart';
import 'package:xapp/core/dtos/crypto_response_dto.dart';
import 'package:xapp/core/dtos/currency_response_dto.dart';
import 'package:xapp/core/dtos/emtia_response_dto.dart';
import 'package:xapp/core/dtos/gold_response_dto.dart';
import 'package:xapp/core/dtos/stock_response_dto.dart';

class CurrentAssets extends BaseDTO {
  String? assetsTitle;
  String? svgPath;
  List<Currency>? currencies;
  String? searchTerm = "";

  CurrentAssets(
      {this.assetsTitle, this.currencies, this.svgPath, this.searchTerm});

  factory CurrentAssets.fromJson(Map<String, dynamic> json) {
    List<Currency> currencyList = [];
    json.forEach((key, value) {
      currencyList.add(Currency.fromJson(key, value));
    });

    return CurrentAssets(
      assetsTitle: "Current Assets",
      currencies: currencyList,
    );
  }
  static CurrentAssets fromFB(Map<String, dynamic> json) {
    final assets = <Currency>[];

    if (json['assets'] != null) {
      json['assets'].forEach((v) {
        assets.add(Currency.fromJson(v["assetType"], v));
      });
    }

    return CurrentAssets(
      assetsTitle: json['assetsTitle'],
      svgPath: json['assetsSvgPath'],
      currencies: assets,
    );
  }

  static CurrentAssets cloneFrom(CurrentAssets currentAssets) => CurrentAssets(
        assetsTitle: currentAssets.assetsTitle,
        svgPath: currentAssets.svgPath,
        currencies: currentAssets.currencies!
            .map((e) => Currency.cloneFrom(e))
            .toList(),
      );
  @override
  fromJson(Map<String, dynamic> json) {
    return CurrentAssets.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class Currency {
  String? name;
  String? buyingPrice;
  String? sellingPrice;
  String? change;
  String? changeRate;
  String? direction;
  String? date;
  Currency({
    this.name,
    this.buyingPrice,
    this.sellingPrice,
    this.change,
    this.changeRate,
    this.direction,
    this.date,
  });

  factory Currency.fromJson(String name, Map<String, dynamic> json) {
    return Currency(
      name: name,
      buyingPrice: json["alis"],
      sellingPrice: json["satis"],
      change: json["degisim"],
      changeRate: json["d_oran"],
      direction: json["d_yon"],
    );
  }

  static Currency fromGold(GoldDTO goldDTO) => Currency(
        name: goldDTO.name,
        buyingPrice: goldDTO.buying.toString(),
        sellingPrice: goldDTO.selling.toString(),
        date: "${goldDTO.date!} ${goldDTO.datetime!}",
      );

  static Currency fromStock(StockDTO stockDTO) => Currency(
        name: stockDTO.code,
        buyingPrice: stockDTO.lastprice.toString(),
        sellingPrice: stockDTO.lastprice.toString(),
      );

  static Currency fromCrypto(CryptoDTO cryptoDTO) => Currency(
        name: cryptoDTO.code,
        buyingPrice: cryptoDTO.price.toString(),
        sellingPrice: cryptoDTO.price.toString(),
      );

  static Currency fromEmtia(EmtiaDTO emtiaDTO) => Currency(
        name: emtiaDTO.name,
        buyingPrice: emtiaDTO.buyingstr,
        sellingPrice: emtiaDTO.sellingstr,
        date: "${emtiaDTO.date!} ${emtiaDTO.datetime!}",
      );

  static Currency fromCurrency(CurrencyDTO currencyDTO) => Currency(
        name: currencyDTO.code,
        buyingPrice: currencyDTO.buying.toString(),
        sellingPrice: currencyDTO.selling.toString(),
        date: "${currencyDTO.date!} ${currencyDTO.datetime!}",
      );

  static Currency cloneFrom(Currency currency) => Currency(
        name: currency.name,
        buyingPrice: currency.buyingPrice,
        sellingPrice: currency.sellingPrice,
        date: currency.date,
      );
}
