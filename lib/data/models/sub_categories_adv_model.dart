class SubCategoriesAdvModel {
  bool? status;
  List<Data>? data;
  Null? message;

  SubCategoriesAdvModel({this.status, this.data, this.message});

  SubCategoriesAdvModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? nameAr;
  Null? nameEn;
  String? imgPath;
  int? haveSubCategories;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? active;

  Data(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.imgPath,
      this.haveSubCategories,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imgPath = json['img_path'];
    haveSubCategories = json['have_sub_categories'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['img_path'] = this.imgPath;
    data['have_sub_categories'] = this.haveSubCategories;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['active'] = this.active;
    return data;
  }
}