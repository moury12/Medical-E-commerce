import 'package:medi_source_apitest/models/district_model.dart';
import 'package:mh_core/services/api_service.dart';
import 'package:mh_core/utils/global.dart';
import 'package:mh_core/utils/string_utils.dart';

import '../constant/enums.dart';

class AuthService{
  static Future <Map<AddressType, List<dynamic>>> getAreaData() async{
List<DistrictModel> disList =[];
List<SubDistrict> areaList =[];
final response= await
ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}district',
    httpMethod: HttpMethod.get,noNeedAuthToken: true);
final response2= await
ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}all-area',
    httpMethod: HttpMethod.get,noNeedAuthToken: true);
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
areaList.add(SubDistrict.fromJson(dis));
  });
}else if(response2['status']!=null&& !response2['status']){
  ServiceAPI.showAlert(errorMessageJson('message'));
}return {
  AddressType.district :disList,
  AddressType.subdidtrict:areaList
};
  }
  static Future<bool> registerCall (dynamic body) async{
    final response= await ServiceAPI.genericCall(url: '${ServiceAPI
        .apiUrl}register', httpMethod: HttpMethod.multipartFilePost,
        noNeedAuthToken: true,
    allInfoField: body);
    globalLogger.d(response, 'register');

    if(response['status']!= null&& response['status']){
      showSnackBar(
        msg: errorMessageJson(response['message']),
      );
      return response['status'];
    }else if(response['status']!=null&&!response['status']){
      ServiceAPI.showAlert(errorMessageJson(response['message']));
    }
    return false;
  }
  static Future<dynamic> loginCall(dynamic body) async{
    final response = await ServiceAPI.genericCall(url: '${ServiceAPI.apiUrl}login', httpMethod: HttpMethod.multipartFilePost, allInfoField:
    body,noNeedAuthToken: true, );
    if (response != null && response['status'] != null) {
      if (response['status']) {
        return response['data'];
      } else {
        if (response['message'] != null) {
          ServiceAPI.showAlert(errorMessageJson(response['message']));
        } else {
          ServiceAPI.showAlert("An error occurred.");
        }
      }
    } else {
      ServiceAPI.showAlert("Invalid response from the server.");
    }
    return {};
  }
}