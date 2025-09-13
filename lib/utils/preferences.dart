import 'package:get_storage/get_storage.dart';
import 'package:kiero/utils/appconstant.dart';

class Preferences {
  final storage = GetStorage();

  Future<void> setDarkMode(bool value) async {
    await storage.write("darkMode", value);
  }

  Future<bool> getDarkMode() async {
    return await storage.read("darkMode") ?? defaultDarkMode;
  }
}
