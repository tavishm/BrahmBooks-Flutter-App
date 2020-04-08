import 'package:shared_preferences/shared_preferences.dart';



read_user() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'acc_name';
  final pakey = 'passwd';
  final value = prefs.getString(key) ?? '0';
  final pass = prefs.getString(pakey) ?? '0';
  return [value, pakey];
}

save_user(accname, passwd) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'acc_name';
  final pakey = 'passwd';
  prefs.setString(key, accname);
  prefs.setString(pakey, passwd);
}
save_deviceid(deviceuid) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'deviceuid';
  prefs.setString(key, deviceuid);
}

read_uid() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'deviceuid';
  prefs.getString(key) ?? '0';
  }
