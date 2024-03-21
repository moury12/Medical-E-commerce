import 'package:medi_source_apitest/models/district_model.dart';

class UserModel {
  String? id;
  String? role;
  String? name;
  String? phone;
  String? districtId;
  String? areaId;
  String? address;
  String? email;
  String? emailVerifiedAt;
  String? otp;
  String? status;
  String? createdAt;
  String? updatedAt;
  DistrictModel? district;
  SubDistrict? area;

  UserModel(
      {this.id,
      this.role,
      this.name,
      this.phone,
      this.districtId,
      this.areaId,
      this.address,
      this.email,
      this.emailVerifiedAt,
      this.otp,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.district,
      this.area});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString() == 'null' ? '' : json['id'].toString();
    role = json['role'].toString() == 'null' ? '' : json['role'].toString();
    name = json['name'].toString() == 'null' ? '' : json['name'].toString();
    phone = json['phone'].toString() == 'null' ? '' : json['phone'].toString();
    districtId = json['district_id'].toString() == 'null'
        ? ''
        : json['district_id'].toString();
    areaId =
        json['area_id'].toString() == 'null' ? '' : json['area_id'].toString();
    address =
        json['address'].toString() == 'null' ? '' : json['address'].toString();
    email = json['email'].toString() == 'null' ? '' : json['email'].toString();
    emailVerifiedAt = json['email_verified_at'].toString() == 'null'
        ? ''
        : json['email_verified_at'].toString();
    otp = json['otp'].toString() == 'null' ? '' : json['otp'].toString();
    status =
        json['status'].toString() == 'null' ? '' : json['status'].toString();
    createdAt = json['created_at'].toString() == 'null'
        ? ''
        : json['created_at'].toString();
    updatedAt = json['updated_at'].toString() == 'null'
        ? ''
        : json['updated_at'].toString();
    district = json['district'] != null
        ? DistrictModel.fromJson(json['district'])
        : null;
    area = json['area'] != null ? SubDistrict.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['name'] = name;
    data['phone'] = phone;
    data['district_id'] = districtId;
    data['area_id'] = areaId;
    data['address'] = address;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['otp'] = otp;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (area != null) {
      data['area'] = area!.toJson();
    }
    return data;
  }
}
