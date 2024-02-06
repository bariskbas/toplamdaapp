import 'package:xapp/core/dtos/base_dto.dart';

class AllCurrencyResponseDTO extends BaseDTO {
  bool? success;
  List<CurrencyDTO>? result;

  AllCurrencyResponseDTO({this.success, this.result});

  AllCurrencyResponseDTO.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <CurrencyDTO>[];
      json['result'].forEach((v) {
        result!.add(CurrencyDTO.fromJson(v));
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
    return AllCurrencyResponseDTO.fromJson(json);
  }
}

class CurrencyDTO extends BaseDTO {
  String? name;
  String? code;
  double? buying;
  String? buyingstr;
  double? selling;
  String? sellingstr;
  double? rate;
  String? time;
  String? date;
  String? datetime;
  int? calculated;

  CurrencyDTO(
      {this.name,
      this.code,
      this.buying,
      this.buyingstr,
      this.selling,
      this.sellingstr,
      this.rate,
      this.time,
      this.date,
      this.datetime,
      this.calculated});

  CurrencyDTO.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    buying = double.parse(json['buying'].toString());
    buyingstr = json['buyingstr'];
    selling = double.parse(json['selling'].toString());
    sellingstr = json['sellingstr'];
    time = json['time'];
    date = json['date'];
    datetime = json['datetime'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['buying'] = buying;
    data['buyingstr'] = buyingstr;
    data['selling'] = selling;
    data['sellingstr'] = sellingstr;
    data['rate'] = rate;
    data['time'] = time;
    data['date'] = date;
    data['datetime'] = datetime;
    data['calculated'] = calculated;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return CurrencyDTO.fromJson(json);
  }
}
