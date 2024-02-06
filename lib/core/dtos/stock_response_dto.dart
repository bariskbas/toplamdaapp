import 'package:xapp/core/dtos/base_dto.dart';

class StockResponseDTO extends BaseDTO {
  bool? success;
  List<StockDTO>? result;

  StockResponseDTO({this.success, this.result});

  StockResponseDTO.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <StockDTO>[];
      json['result'].forEach((v) {
        result!.add(StockDTO.fromJson(v));
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
    return StockResponseDTO.fromJson(json);
  }
}

class StockDTO extends BaseDTO {
  double? rate;
  double? lastprice;
  String? lastpricestr;
  double? hacim;
  String? hacimstr;
  double? min;
  String? minstr;
  double? max;
  String? maxstr;
  String? time;
  String? text;
  String? code;

  StockDTO(
      {this.rate,
      this.lastprice,
      this.lastpricestr,
      this.hacim,
      this.hacimstr,
      this.min,
      this.minstr,
      this.max,
      this.maxstr,
      this.time,
      this.text,
      this.code});

  StockDTO.fromJson(Map<String, dynamic> json) {
    rate = double.parse(json['rate'].toString());
    lastprice = double.parse(json['lastprice'].toString());
    lastpricestr = json['lastpricestr'];
    hacimstr = json['hacimstr'];
    minstr = json['minstr'];
    maxstr = json['maxstr'];
    time = json['time'];
    text = json['text'];
    code = json['code'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['lastprice'] = lastprice;
    data['lastpricestr'] = lastpricestr;
    data['hacim'] = hacim;
    data['hacimstr'] = hacimstr;
    data['min'] = min;
    data['minstr'] = minstr;
    data['max'] = max;
    data['maxstr'] = maxstr;
    data['time'] = time;
    data['text'] = text;
    data['code'] = code;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return StockResponseDTO.fromJson(json);
  }
}
