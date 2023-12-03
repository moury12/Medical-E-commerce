import 'package:medi_source_apitest/models/district_model.dart';
import 'package:mh_core/services/api_service.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/utils/string_utils.dart';

import '../constant/enums.dart';

class AuthService{
  static Future <Map<AddressType, List<dynamic>>> getAreaData() async{
List<DistrictModel> disList =[];
List<SubDistrict> areaList =[];
final response= await ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}district', httpMethod: HttpMethod.get,noNeedAuthToken: true);
final response2= await ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}all-area', httpMethod: HttpMethod.get,noNeedAuthToken: true);
globalLogger.d(response, "Get District Route");
globalLogger.d(response2, "Get Area Route");
if(response['status']!=null&& response['status']){
  response['data'].forEach((dis){
disList.add(DistrictModel.fromJson(dis));
  });
}else if(response['status']!=null&& !response['status']){
  ServiceAPI.showAlert(errorMessageJson('message'));
}if(response2['status']!=null&& response2['status']){
  response2['data'].forEach((dis){
disList.add(DistrictModel.fromJson(dis));
  });
}else if(response2['status']!=null&& !response2['status']){
  ServiceAPI.showAlert(errorMessageJson('message'));
}return {
  AddressType.district :disList,
  AddressType.subdidtrict:areaList
};
  }
}