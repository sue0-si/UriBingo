
import '../models/refrige_model.dart';

class RegisterdRefrigeRepository {
  final List<RefrigeDetail> refriges = [
    RefrigeDetail(

      refrigeName: '1번냉장고',
      refrigeCompCount: 4,
      freezerCompCount: 2,
      period: 10,
      extentionPeriod: 3,
    ),
    RefrigeDetail(

      refrigeName: '2번냉장고',
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
