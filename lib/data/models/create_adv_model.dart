class CreateAdvModel {
  String? name;
  List<int>? cityId;
  String? description;
  String? categoryId;
  List<Files>? files;
  String? price;
  String? phone;
  String? address;
  List<Attributes>? attributes;

  CreateAdvModel(
      {this.name,
      this.cityId,
      this.description,
      this.categoryId,
      this.files,
      this.price,
      this.phone,
      this.address,
      this.attributes});

  CreateAdvModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cityId = json['city_id'].cast<int>();
    description = json['description'];
    categoryId = json['category_id'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    price = json['price'];
    phone = json['phone'];
    address = json['address'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['city_id'] = this.cityId;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['phone'] = this.phone;
    data['address'] = this.address;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? type;
  FilePath? filePath;

  Files({this.type, this.filePath});

  Files.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    filePath = json['file_path'] != null
        ? new FilePath.fromJson(json['file_path'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.filePath != null) {
      data['file_path'] = this.filePath!.toJson();
    }
    return data;
  }
}

class FilePath {
  FilePath.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Attributes {
  String? id;
  String? value;

  Attributes({this.id, this.value});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}
