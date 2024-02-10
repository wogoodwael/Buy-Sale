class FilterModel {
  bool? status;
  Data? data;

  FilterModel({this.status, this.data});

  FilterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<CategoriesFilter>? categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CategoriesFilter>[];
      json['categories'].forEach((v) {
        categories!.add(new CategoriesFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesFilter {
  int? id;
  String? nameAr;
  String? nameEn;
  String? imgPath;
  int? haveSubCategories;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? active;
  Null? parent;

  CategoriesFilter(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.imgPath,
      this.haveSubCategories,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.active,
      this.parent});

  CategoriesFilter.fromJson(Map<String, dynamic> json) {
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
    parent = json['parent'];
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
    data['parent'] = this.parent;
    return data;
  }
}