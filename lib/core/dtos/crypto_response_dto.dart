import 'package:xapp/core/dtos/base_dto.dart';

class CryptoResponseDTO extends BaseDTO {
  bool? success;
  List<CryptoDTO>? result;

  CryptoResponseDTO({this.success, this.result});

  CryptoResponseDTO.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <CryptoDTO>[];
      json['result'].forEach((v) {
        result!.add(CryptoDTO.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return CryptoResponseDTO.fromJson(json);
  }
}

class CryptoDTO extends BaseDTO {
  double? changeHour;
  String? changeHourstr;
  double? changeDay;
  String? changeDaystr;
  double? changeWeek;
  String? changeWeekstr;
  String? volumestr;
  double? volume;
  String? currency;
  String? pricestr;
  double? price;
  String? marketCapstr;
  double? marketCap;
  String? circulatingSupply;
  String? code;
  String? name;

  CryptoDTO(
      {this.changeHour,
      this.changeHourstr,
      this.changeDay,
      this.changeDaystr,
      this.changeWeek,
      this.changeWeekstr,
      this.volumestr,
      this.volume,
      this.currency,
      this.pricestr,
      this.price,
      this.marketCapstr,
      this.marketCap,
      this.circulatingSupply,
      this.code,
      this.name});

  CryptoDTO.fromJson(Map<String, dynamic> json) {
    changeHourstr = json['changeHourstr'];
    changeDaystr = json['changeDaystr'];
    changeWeekstr = json['changeWeekstr'];
    volumestr = json['volumestr'];
    currency = json['currency'];
    pricestr = json['pricestr'];
    price = json['price'];
    marketCapstr = json['marketCapstr'];
    circulatingSupply = json['circulatingSupply'];
    code = json['code'];
    name = json['name'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['changeHour'] = changeHour;
    data['changeHourstr'] = changeHourstr;
    data['changeDay'] = changeDay;
    data['changeDaystr'] = changeDaystr;
    data['changeWeek'] = changeWeek;
    data['changeWeekstr'] = changeWeekstr;
    data['volumestr'] = volumestr;
    data['volume'] = volume;
    data['currency'] = currency;
    data['pricestr'] = pricestr;
    data['price'] = price;
    data['marketCapstr'] = marketCapstr;
    data['marketCap'] = marketCap;
    data['circulatingSupply'] = circulatingSupply;
    data['code'] = code;
    data['name'] = name;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return CryptoDTO.fromJson(json);
  }
}
