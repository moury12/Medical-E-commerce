class ProductModel {
  String? id;
  String? image;
  String? name;
  String? categoryId;
  String? companyId;
  String? price;
  String? discountPrice;
  String? discountPercentage;
  String? isFlashSale;
  String? status;
  String? createdAt;
  String? updatedAt;
  Company? company;

  ProductModel(
      {this.id,
        this.image,
        this.name,
        this.categoryId,
        this.companyId,
        this.price,
        this.discountPrice,
        this.discountPercentage,
        this.isFlashSale,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.company});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString()=='null'?'':json['id'].toString();
    image = json['image'].toString()=='null'?'':json['image'].toString();
    name = json['name'].toString()=='null'?'':json['name'].toString();
    categoryId = json['category_id'].toString()=='null'?'':json['category_id'].toString();
    companyId = json['company_id'].toString()=='null'?'':json['company_id'].toString();
    price = json['price'].toString()=='null'?'':json['price'].toString();
    discountPrice = json['discount_price']
        .toString()=='null'?'':json['discount_price'].toString();
    discountPercentage = json['discount_percentage']
        .toString()=='null'?'':json['discount_percentage'].toString();
    isFlashSale = json['is_flash_sale'].toString()=='null'?'':json['is_flash_sale'].toString();
    status = json['status'].toString()=='null'?'':json['status'].toString();
    createdAt = json['created_at'].toString()=='null'?'':json['created_at'].toString();
    updatedAt = json['updated_at'].toString()=='null'?'':json['updated_at'].toString();
    company =
    json['company'] != null ?  Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['company_id'] = companyId;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    data['discount_percentage'] = discountPercentage;
    data['is_flash_sale'] = isFlashSale;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool? userCheck;

  Company({this.id, this.name, this.status, this.createdAt, this.updatedAt,
    this.userCheck});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString()=='null'?'':json['id'];
    name = json['name'].toString()=='null'?'':json['name'];
    status = json['status'].toString()=='null'?'':json['status'];
    createdAt = json['created_at'].toString()=='null'?'':json['created_at'];
    updatedAt = json['updated_at'].toString()=='null'?'':json['updated_at'];
    userCheck =false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_check'] = userCheck;
    return data;
  }
}
