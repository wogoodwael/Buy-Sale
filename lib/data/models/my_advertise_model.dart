class MyAdvertisementModel {
  bool? status;
  List<Data>? data;

  MyAdvertisementModel({this.status, this.data});

  MyAdvertisementModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? categoryId;
  int? userId;
  String? name;
  String? description;
  int? cityId;
  int? price;
  String? imgPath;
  String? createdAt;
  String? updatedAt;
  String? phone;
  String? address;


  List<Files>? files;
 

  Data(
      {this.id,
      this.categoryId,
      this.userId,
      this.name,
      this.description,
      this.cityId,
      this.price,
      this.imgPath,
      this.createdAt,
      this.updatedAt,
      this.phone,
      this.address,
    
    
      this.files,
     });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    cityId = json['city_id'];
    price = json['price'];
    imgPath = json['img_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    address = json['address'];
  
 
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['city_id'] = this.cityId;
    data['price'] = this.price;
    data['img_path'] = this.imgPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone'] = this.phone;
    data['address'] = this.address;
  
  
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
  
    return data;
  }
}

class Files {
  int? id;
  int? advertisementId;
  String? filePath;
  String? type;

  Files({this.id, this.advertisementId, this.filePath, this.type});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    filePath = json['file_path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_id'] = this.advertisementId;
    data['file_path'] = this.filePath;
    data['type'] = this.type;
    return data;
  }
}