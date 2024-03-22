import 'district_model.dart';

class OrderModel {
  String? id;
  String? orderId;
  String? userId;
  String? userName;
  String? userPhone;
  String? areaId;
  String? address;
  String? subtotal;
  String? discount;
  String? total;
  String? deliveryDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<OrderDetails>? orderDetails;
  SubDistrict? area;

  OrderModel(
      {this.id,
        this.orderId,
        this.userId,
        this.userName,
        this.userPhone,
        this.areaId,
        this.address,
        this.subtotal,
        this.discount,
        this.total,
        this.deliveryDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.orderDetails,
        this.area});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString()=='null'?'':json['id'].toString();
    orderId = json['order_id'].toString()=='null'?'':json['order_id'].toString();
    userId = json['user_id'].toString()=='null'?'':json['user_id'].toString();
    userName = json['user_name'].toString()=='null'?'':json['user_name'].toString();
    userPhone = json['user_phone'].toString()=='null'?'':json['user_phone'].toString();
    areaId = json['area_id'].toString()=='null'?'':json['area_id'].toString();
    address = json['address'].toString()=='null'?'':json['address'].toString();
    subtotal = json['subtotal'].toString()=='null'?'':json['subtotal'].toString();
    discount = json['discount'].toString()=='null'?'':json['discount'].toString();
    total = json['total'].toString()=='null'?'':json['total'].toString();
    deliveryDate = json['delivery_date'].toString()=='null'?'':json['delivery_date'].toString();
    status = json['status'].toString()=='null'?'':json['status'].toString();
    createdAt = json['created_at'].toString()=='null'?'':json['created_at'].toString();
    updatedAt = json['updated_at'].toString()=='null'?'':json['updated_at'].toString();
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
    area = json['area'] != null ? SubDistrict.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_phone'] = userPhone;
    data['area_id'] = areaId;
    data['address'] = address;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['total'] = total;
    data['delivery_date'] = deliveryDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (orderDetails != null) {
      data['order_details'] =
          orderDetails!.map((v) => v.toJson()).toList();
    }
    if (area != null) {
      data['area'] = area!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  String? id;
  String? orderId;
  String? productId;
  String? name;
  String? qty;
  String? rate;
  String? discountPercentage;
  String? discountAmount;
  String? netAmount;
  String? status;
  String? createdAt;
  String? updatedAt;

  OrderDetails(
      {this.id,
        this.orderId,
        this.productId,
        this.name,
        this.qty,
        this.rate,
        this.discountPercentage,
        this.discountAmount,
        this.netAmount,
        this.status,
        this.createdAt,
        this.updatedAt});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString()=='null'?'':json['id'].toString();
    orderId = json['order_id'].toString()=='null'?'':json['order_id'].toString();
    productId = json['product_id'].toString()=='null'?'':json['product_id'].toString();
    name = json['name'].toString()=='null'?'':json['name'].toString();
    qty = json['qty'].toString()=='null'?'':json['qty'].toString();
    rate = json['rate'].toString()=='null'?'':json['rate'].toString();
    discountPercentage = json['discount_percentage'].toString()=='null'?'':json['discount_percentage'].toString();
    discountAmount = json['discount_amount'].toString()=='null'?'':json['discount_amount'].toString();
    netAmount = json['net_amount'].toString()=='null'?'':json['net_amount'].toString();
    status = json['status'].toString()=='null'?'':json['status'].toString();
    createdAt = json['created_at'].toString()=='null'?'':json['created_at'].toString();
    updatedAt = json['updated_at'].toString()=='null'?'':json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['name'] = name;
    data['qty'] = qty;
    data['rate'] = rate;
    data['discount_percentage'] = discountPercentage;
    data['discount_amount'] = discountAmount;
    data['net_amount'] = netAmount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


