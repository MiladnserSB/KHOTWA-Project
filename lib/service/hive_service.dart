// services/hive_service.dart

import 'package:hive/hive.dart';

class HiveService {
  final Box _userBox;

   HiveService(this._userBox);


  // Future<void> saveUser(User user) async {
  //   await _userBox.put('user', user.toJson());
  // }

  // User? getUser() {
  //   final userJson = _userBox.get('user');
  //   if (userJson != null) {
  //     return User.fromJson(userJson);
  //   }
  //   return null;
  // }

  // Future<void> clearUser() async {
  //   await _userBox.delete('user');
  // }
}
