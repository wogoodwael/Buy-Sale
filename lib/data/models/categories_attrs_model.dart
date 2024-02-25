class GetCateAttrsModel {
  bool? status;
  List<Data>? data;

  GetCateAttrsModel({this.status, this.data});

  GetCateAttrsModel.fromJson(Map<String, dynamic> json) {
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
  int? attributeId;
  Attribute? attribute;

  Data({this.id, this.categoryId, this.attributeId, this.attribute});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    attributeId = json['attribute_id'];
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['attribute_id'] = this.attributeId;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.toJson();
    }
    return data;
  }
}

class Attribute {
  int? id;
  String? nameAr;
  String? nameEn;
  String? createdAt;
  String? updatedAt;

  String? type;
  List<Values>? values;

  Attribute(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.values});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    type = json['type'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    data['type'] = this.type;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int? id;
  int? attributeId;
  int? relatedAttributeId;
  String? value;
  Null? deletedAt;

  Values(
      {this.id,
      this.attributeId,
      this.relatedAttributeId,
      this.value,
      this.deletedAt});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeId = json['attribute_id'];
    relatedAttributeId = json['related_attribute_id'];
    value = json['value'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_id'] = this.attributeId;
    data['related_attribute_id'] = this.relatedAttributeId;
    data['value'] = this.value;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
