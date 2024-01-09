import 'package:get_storage/get_storage.dart';

final storage = GetStorage();
void setLocaldata (String key, dynamic value){
  storage.write(key, value);
}dynamic getLocaldata (String key){
  storage.read(key);
}
const String activeUserLocalKey='login_credential_key';