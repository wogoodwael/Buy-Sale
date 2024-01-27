class LoginModel {
  bool? status;
  Data? data;

  LoginModel({this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? role;
  int? active;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  String? gender;

  String? token;
  int? type;

  Data(
      {this.id,
      this.role,
      this.active,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.gender,
      this.token,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    active = json['active'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];

    gender = json['gender'];

    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['active'] = this.active;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;

    data['gender'] = this.gender;

    data['token'] = this.token;
    data['type'] = this.type;
    return data;
  }
}
