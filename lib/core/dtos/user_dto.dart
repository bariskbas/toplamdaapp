class UserDTO {
  String? gender;
  String? nameUsername;
  String? birthday;
  String? eMail;
  String? phone;
  String? meslek;

  UserDTO({this.gender, this.nameUsername, this.birthday, this.eMail});

  UserDTO.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    nameUsername = json['name_username'];
    birthday = json['birthday'];
    eMail = json['e_mail'];
    phone = json['phone'];
    meslek = json['Meslek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['name_username'] = nameUsername;
    data['birthday'] = birthday;
    data['e_mail'] = eMail;
    data['phone'] = phone;
    data['Meslek'] = meslek;
    return data;
  }
}
