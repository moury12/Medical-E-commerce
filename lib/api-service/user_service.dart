import 'package:medi_source_apitest/models/user_model.dart';
import 'package:mh_core/services/api_service.dart';
import 'package:mh_core/utils/global.dart';

class UserService {
  static Future<UserModel> getProfileData() async {
    UserModel userModel = UserModel();
    final response = await ServiceAPI.genericCall(
        url: '${ServiceAPI.apiUrl}my-profile', httpMethod: HttpMethod.get);
    globalLogger.d(response, "User Profile Route");
    if (response['status'] != null && response['status']) {
      userModel = UserModel.fromJson(response['data']);
    } else {
      showSnackBar(msg: response['message']);
    }
    return userModel;
  }

  static Future<bool> updateProfileCall(dynamic body) async {
    final response = await ServiceAPI.genericCall(
        url: '${ServiceAPI.apiUrl}update-profile',
        httpMethod: HttpMethod.multipartFilePost,
        allInfoField: body);
    globalLogger.d(response, 'Update profile call');
    if (response['status'] != null && response['status']) {
      return response['status'];
    } else {
      showSnackBar(msg: response['message']);
    }
    return false;
  }

  static Future<bool> changePassword(dynamic body) async {
    final response = await ServiceAPI.genericCall(
        url: '${ServiceAPI.apiUrl}new-password-create',
        httpMethod: HttpMethod.multipartFilePost,
        allInfoField: body);
    if (response['status'] != null && response['status']) {
      return response['status'];
    } else {
      showSnackBar(msg: response['data']['error']);
    }
    return false;
  }
}
