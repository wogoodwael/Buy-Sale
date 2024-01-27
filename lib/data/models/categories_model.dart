class CategoriesModel {
  bool? status;
  Data? data;

  CategoriesModel({this.status, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories>? categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
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

class Categories {
  int? id;
  String? nameAr;
  String? nameEn;
  String? imgPath;
  int? haveSubCategories;

  String? createdAt;
  String? updatedAt;

  int? active;


  Categories(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.imgPath,
      this.haveSubCategories,
   
      this.createdAt,
      this.updatedAt,
    
      this.active,
      });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    imgPath = json['img_path'];
    haveSubCategories = json['have_sub_categories'];
   
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
   
    active = json['active'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['img_path'] = this.imgPath;
    data['have_sub_categories'] = this.haveSubCategories;
  
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    data['active'] = this.active;
  
    return data;
  }
}
