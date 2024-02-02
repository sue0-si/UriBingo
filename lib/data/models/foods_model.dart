class FoodDetail {
  String refrigeName;
  bool freezed;
  String foodImage;
  int positionId;
  String userId;
  String userName;
  String groupName;
  int registerDate;
  bool isPublic;
  bool isExtended;

//<editor-fold desc="Data Methods">
  FoodDetail({
    required this.refrigeName,
    required this.freezed,
    required this.foodImage,
    required this.positionId,
    required this.userId,
    required this.userName,
    required this.groupName,
    required this.registerDate,
    required this.isPublic,
    required this.isExtended,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodDetail &&
          runtimeType == other.runtimeType &&
          refrigeName == other.refrigeName &&
          freezed == other.freezed &&
          foodImage == other.foodImage &&
          positionId == other.positionId &&
          userId == other.userId &&
          userName == other.userName &&
          groupName == other.groupName &&
          registerDate == other.registerDate &&
          isPublic == other.isPublic &&
          isExtended == other.isExtended);

  @override
  int get hashCode =>
      refrigeName.hashCode ^
      freezed.hashCode ^
      foodImage.hashCode ^
      positionId.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      groupName.hashCode ^
      registerDate.hashCode ^
      isPublic.hashCode ^
      isExtended.hashCode;

  @override
  String toString() {
    return 'FoodDetail{ refrigeName: $refrigeName, freezed: $freezed, foodImage: $foodImage, positionId: $positionId, userId: $userId, userName: $userName, groupName: $groupName, registerDate: $registerDate, isPublic: $isPublic, isExtended: $isExtended,}';
  }

  FoodDetail copyWith({
    String? refrigeName,
    bool? freezed,
    String? foodImage,
    int? positionId,
    String? userId,
    String? userName,
    String? groupName,
    int? registerDate,
    bool? isPublic,
    bool? isExtended,
  }) {
    return FoodDetail(
      refrigeName: refrigeName ?? this.refrigeName,
      freezed: freezed ?? this.freezed,
      foodImage: foodImage ?? this.foodImage,
      positionId: positionId ?? this.positionId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      groupName: groupName ?? this.groupName,
      registerDate: registerDate ?? this.registerDate,
      isPublic: isPublic ?? this.isPublic,
      isExtended: isExtended ?? this.isExtended,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refrigeName': refrigeName,
      'freezed': freezed,
      'foodImage': foodImage,
      'positionId': positionId,
      'userId': userId,
      'userName': userName,
      'groupName': groupName,
      'registerDate': registerDate,
      'isPublic': isPublic,
      'isExtended': isExtended,
    };
  }

  factory FoodDetail.fromJson(Map<String, dynamic> map) {
    return FoodDetail(
      refrigeName: map['refrigeName'] as String,
      freezed: map['freezed'] as bool,
      foodImage: map['foodImage'] as String,
      positionId: map['positionId'] as int,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      groupName: map['groupName'] as String,
      registerDate: map['registerDate'] as int,
      isPublic: map['isPublic'] as bool,
      isExtended: map['isExtended'] as bool,
    );
  }

//</editor-fold>
}
