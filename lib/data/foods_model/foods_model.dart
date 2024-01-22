class FoodDetail {
  int refrigeId;
  bool freezed;
  int foodId;
  String foodImage;
  int positionId;
  int userId;
  String userName;
  String registerDate;
  int remainPeriod;

//<editor-fold desc="Data Methods">
  FoodDetail({
    required this.refrigeId,
    required this.freezed,
    required this.foodId,
    required this.foodImage,
    required this.positionId,
    required this.userId,
    required this.userName,
    required this.registerDate,
    required this.remainPeriod,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodDetail &&
          runtimeType == other.runtimeType &&
          refrigeId == other.refrigeId &&
          freezed == other.freezed &&
          foodId == other.foodId &&
          foodImage == other.foodImage &&
          positionId == other.positionId &&
          userId == other.userId &&
          userName == other.userName &&
          registerDate == other.registerDate &&
          remainPeriod == other.remainPeriod);

  @override
  int get hashCode =>
      refrigeId.hashCode ^
      freezed.hashCode ^
      foodId.hashCode ^
      foodImage.hashCode ^
      positionId.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      registerDate.hashCode ^
      remainPeriod.hashCode;

  @override
  String toString() {
    return 'FoodDetail{ refrigeId: $refrigeId, freezed: $freezed, foodId: $foodId, foodImage: $foodImage, positionId: $positionId, userId: $userId, userName: $userName, registerDate: $registerDate, remainPeriod: $remainPeriod,}';
  }

  FoodDetail copyWith({
    int? refrigeId,
    bool? freezed,
    int? foodId,
    String? foodImage,
    int? positionId,
    int? userId,
    String? userName,
    String? registerDate,
    int? remainPeriod,
  }) {
    return FoodDetail(
      refrigeId: refrigeId ?? this.refrigeId,
      freezed: freezed ?? this.freezed,
      foodId: foodId ?? this.foodId,
      foodImage: foodImage ?? this.foodImage,
      positionId: positionId ?? this.positionId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      registerDate: registerDate ?? this.registerDate,
      remainPeriod: remainPeriod ?? this.remainPeriod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'refrigeId': refrigeId,
      'freezed': freezed,
      'foodId': foodId,
      'foodImage': foodImage,
      'positionId': positionId,
      'userId': userId,
      'userName': userName,
      'registerDate': registerDate,
      'remainPeriod': remainPeriod,
    };
  }

  factory FoodDetail.fromMap(Map<String, dynamic> map) {
    return FoodDetail(
      refrigeId: map['refrigeId'] as int,
      freezed: map['freezed'] as bool,
      foodId: map['foodId'] as int,
      foodImage: map['foodImage'] as String,
      positionId: map['positionId'] as int,
      userId: map['userId'] as int,
      userName: map['userName'] as String,
      registerDate: map['registerDate'] as String,
      remainPeriod: map['remainPeriod'] as int,
    );
  }

//</editor-fold>
}