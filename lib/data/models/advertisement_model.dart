class AdvertismentModel {
  bool? status;
  List<Data>? data;

  AdvertismentModel({this.status, this.data});

  AdvertismentModel.fromJson(Map<String, dynamic> json) {
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
  List<Comments>? comments;

  List<Attributes>? attributes;

  List<Files>? files;
  User? user;

  Data({
    this.id,
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
    this.comments,
    this.attributes,
    this.user,
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

    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }

    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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

    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }

    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }

    return data;
  }
}

class Attributes {
  int? id;
  int? advertisementId;
  int? attributeId;
  String? value;
  Attribute? attribute;

  Attributes(
      {this.id,
      this.advertisementId,
      this.attributeId,
      this.value,
      this.attribute});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    attributeId = json['attribute_id'];
    value = json['value'];
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_id'] = this.advertisementId;
    data['attribute_id'] = this.attributeId;
    data['value'] = this.value;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.toJson();
    }
    return data;
  }
}

class Attribute {
  int? id;
  String? name;

  Attribute({this.id, this.name});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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

class Comments {
  int? id;
  int? advertisementId;
  int? userId;
  String? content;
  String? createdAt;
  String? updatedAt;
  User? user;
  Comments(
      {this.id,
      this.advertisementId,
      this.userId,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    userId = json['user_id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_id'] = this.advertisementId;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;

  User({this.id, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
