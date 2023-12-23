import 'package:get_storage/get_storage.dart';

final storage = GetStorage();
void setLocaldata (String key, dynamic value){
  storage.write(key, value);
}