
import '../refrige_model/refrige_model.dart';

class RegisterdRefrigeRepository {
  final List<RefrigeDetail> refriges = [
    RefrigeDetail(
      refrigeId: 1,
      refrigeName: '1번 냉장고',
      refrigeCompCount: 4,
      freezerCompCount: 2,
      period: 10,
      extentionPeriod: 3,
    ),
    RefrigeDetail(
      refrigeId: 2,
      refrigeName: '2번 냉장고',
      refrigeCompCount: 3,
      freezerCompCount: 1,
      period: 10,
      extentionPeriod: 3,
    ),
  ];

  List<RefrigeDetail> getRefrigeDetail() {
    return refriges;
  }
}
