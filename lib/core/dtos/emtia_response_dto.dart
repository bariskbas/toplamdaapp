import 'package:xapp/core/dtos/base_dto.dart';

class EmtiaResponseDTO extends BaseDTO {
  bool? success;
  List<EmtiaDTO>? result;

  EmtiaResponseDTO({this.success, this.result});

  EmtiaResponseDTO.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <EmtiaDTO>[];
      json['result'].forEach((v) {
        result!.add(EmtiaDTO.fromJson(v));
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
    return EmtiaResponseDTO.fromJson(json);
  }
}

class EmtiaDTO extends BaseDTO {
  String? name;
  String? text;
  double? buying;
  String? buyingstr;
  double? selling;
  String? sellingstr;
  String? time;
  String? date;
  String? datetime;
  double? rate;

  EmtiaDTO(
      {this.name,
      this.text,
      this.buying,
      this.buyingstr,
      this.selling,
      this.sellingstr,
      this.time,
      this.date,
      this.datetime,
      this.rate});

  EmtiaDTO.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
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
    data['text'] = text;
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
    return EmtiaDTO.fromJson(json);
  }
}
