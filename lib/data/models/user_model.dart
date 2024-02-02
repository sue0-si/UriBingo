class UserModel {
  String email;
  String employeeNumber;
  bool manager;
  String name;
  String validationCode;
  String groupName;
  String userId;
  String userToken;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.email,
    required this.employeeNumber,
    required this.manager,
    required this.name,
    required this.validationCode,
    required this.groupName,
    required this.userId,
    required this.userToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          employeeNumber == other.employeeNumber &&
          manager == other.manager &&
          name == other.name &&
          validationCode == other.validationCode &&
          groupName == other.groupName &&
          userId == other.userId &&
          userToken == other.userToken);

  @override
  int get hashCode =>
      email.hashCode ^
      employeeNumber.hashCode ^
      manager.hashCode ^
      name.hashCode ^
      validationCode.hashCode ^
      groupName.hashCode ^
      userId.hashCode ^
      userToken.hashCode;

  @override
  String toString() {
    return 'UserModel{ email: $email, employeeNumber: $employeeNumber, manager: $manager, name: $name, validationCode: $validationCode, groupName: $groupName, userId: $userId, userToken: $userToken,}';
  }

  UserModel copyWith({
    String? email,
    String? employeeNumber,
    bool? manager,
    String? name,
    String? validationCode,
    String? groupName,
    String? userId,
    String? userToken,
  }) {
    return UserModel(
      email: email ?? this.email,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      manager: manager ?? this.manager,
      name: name ?? this.name,
      validationCode: validationCode ?? this.validationCode,
      groupName: groupName ?? this.groupName,
      userId: userId ?? this.userId,
      userToken: userToken ?? this.userToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'employeeNumber': employeeNumber,
      'manager': manager,
      'name': name,
      'validationCode': validationCode,
      'groupName': groupName,
      'userId': userId,
      'userToken': userToken,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      employeeNumber: map['employeeNumber'] as String,
      manager: map['manager'] as bool,
      name: map['name'] as String,
      validationCode: map['validationCode'] as String,
      groupName: map['groupName'] as String,
      userId: map['userId'] as String,
      userToken: map['userToken'] as String,
    );
  }

//</editor-fold>
}
