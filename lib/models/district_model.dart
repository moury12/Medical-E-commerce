class DistrictModel {
  String id;
  String name;
  String status;
  String createdAt;
  String updatedAt;

  DistrictModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'].toString() =='null'?'':json['id'].toString(),
      name: json['name'].toString() =='null'?'':json['name'].toString(),
      status: json['status'].toString() =='null'?'':json['status'].toString(),
      createdAt: json['created_at'].toString() =='null'?'':json['created_at'].toString(),
      updatedAt:json['updated_at'].toString() =='null'?'':json['updated_at'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
class SliderModel {
  String? id;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  SliderModel({this.id, this.image, this.status, this.createdAt, this.updatedAt});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString() == 'null' ? "" : json['id'].toString();
    image = json['image'].toString() == 'null' ? "" : json['image'].toString();
    status = json['status'].toString() == 'null' ? "" : json['status'].toString();
    createdAt = json['created_at'].toString() == 'null' ? "" : json['created_at'].toString();
    updatedAt = json['updated_at'].toString() == 'null' ? "" : json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SubDistrict {
  String id;
  String districtId;
  String name;
  String status;
  String createdAt;
  String updatedAt;

  SubDistrict({
    required this.id,
    required this.districtId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubDistrict.fromJson(Map<String, dynamic> json) {
    return SubDistrict(
      id: json['id'].toString()??'',
      districtId: json['district_id'].toString()=='null'?'':json['district_id'].toString(),
      name: json['name'].toString()=='null'?'':json['name'].toString(),
      status: json['status'].toString()=='null'?'':json['status'].toString(),
      createdAt: json['created_at'].toString()=='null'?'':json['created_at'].toString(),
      updatedAt: json['updated_at'].toString()=='null'?'':json['updated_at'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'district_id': districtId,
      'name': name,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

