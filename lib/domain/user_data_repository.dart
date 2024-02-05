import 'package:leute/data/models/user_model.dart';

abstract interface class UserDataRepository {
  Future<List<UserModel>> getFirebaseUserData();
}
