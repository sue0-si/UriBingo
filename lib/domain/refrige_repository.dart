import '../data/models/refrige_model.dart';

abstract interface class RegisterdRefrigeRepository {
  Future<List<RefrigeDetail>> getFirebaseRefrigesData();
}
