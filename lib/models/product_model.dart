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
    id = json['id']=='null'?'':json['id'];
    image = json['image']=='null'?'':json['image'];
    name = json['name']=='null'?'':json['name'];
    categoryId = json['category_id']=='null'?'':json['category_id'];
    companyId = json['company_id']=='null'?'':json['company_id'];
    price = json['price']=='null'?'':json['price'];
    discountPrice = json['discount_price']=='null'?'':json['discount_price'];
    discountPercentage = json['discount_percentage']=='null'?'':json['discount_percentage'];
    isFlashSale = json['is_flash_sale']=='null'?'':json['is_flash_sale'];
    status = json['status']=='null'?'':json['status'];
    createdAt = json['created_at']=='null'?'':json['created_at'];
    updatedAt = json['updated_at']=='null'?'':json['updated_at'];
    company =
    json['company'] != null ?  Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['company_id'] = this.companyId;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['discount_percentage'] = this.discountPercentage;
    data['is_flash_sale'] = this.isFlashSale;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
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
  String? userCheck;

  Company({this.id, this.name, this.status, this.createdAt, this.updatedAt,
    this.userCheck});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString()=='null'?'':json['id'];
    name = json['name'].toString()=='null'?'':json['name'];
    status = json['status'].toString()=='null'?'':json['status'];
    createdAt = json['created_at'].toString()=='null'?'':json['created_at'];
    updatedAt = json['updated_at'].toString()=='null'?'':json['updated_at'];
    userCheck = json['user_check'].toString() == 'null' ? '0' : json['user_check'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_check'] = this.userCheck;
    return data;
  }
}
