import 'package:xapp/core/dtos/base_dto.dart';

class GoldResponseDTO extends BaseDTO {
  List<GoldDTO>? result;
  bool? success;

  GoldResponseDTO({this.result, this.success});

  GoldResponseDTO.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <GoldDTO>[];
      json['result'].forEach((v) {
        result!.add(GoldDTO.fromJson(v));
      });
    }
    success = json['success'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return GoldResponseDTO.fromJson(json);
  }
}

class GoldDTO extends BaseDTO {
  String? name;
  double? buying;
  String? buyingstr;
  double? selling;
  String? sellingstr;
  String? time;
  String? date;
  String? datetime;
  double? rate;

  GoldDTO(
      {this.name,
      this.buying,
      this.buyingstr,
      this.selling,
      this.sellingstr,
      this.time,
      this.date,
      this.datetime,
      this.rate});

  GoldDTO.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buying = double.parse(json['buying'].toString());
    buyingstr = json['buyingstr'];
    selling = double.parse(json['selling'].toString());
    sellingstr = json['sellingstr'];
    time = json['time'];
    date = json['date'];
    datetime = json['datetime'];
    rate = double.parse(json['rate'].toString());
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['buying'] = buying;
    data['buyingstr'] = buyingstr;
    data['selling'] = selling;
    data['sellingstr'] = sellingstr;
    data['time'] = time;
    data['date'] = date;
    data['datetime'] = datetime;
    data['rate'] = rate;
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return GoldDTO.fromJson(json);
  }
}
