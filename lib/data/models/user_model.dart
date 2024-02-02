class UserModel {
  String email;
  String employeeNumber;
  bool manager;
  String name;
  String validationCode;
  String groupName;
  String userId;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.email,
    required this.employeeNumber,
    required this.manager,
    required this.name,
    required this.validationCode,
    required this.groupName,
    required this.userId,
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
          userId == other.userId);

  @override
  int get hashCode =>
      email.hashCode ^
      employeeNumber.hashCode ^
      manager.hashCode ^
      name.hashCode ^
      validationCode.hashCode ^
      groupName.hashCode ^
      userId.hashCode;

  @override
  String toString() {
    return 'UserModel{ email: $email, employeeNumber: $employeeNumber, manager: $manager, name: $name, validationCode: $validationCode, groupName: $groupName, userId: $userId,}';
  }

  UserModel copyWith({
    String? email,
    String? employeeNumber,
    bool? manager,
    String? name,
    String? validationCode,
    String? groupName,
    String? userId,
  }) {
    return UserModel(
      email: email ?? this.email,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      manager: manager ?? this.manager,
      name: name ?? this.name,
      validationCode: validationCode ?? this.validationCode,
      groupName: groupName ?? this.groupName,
      userId: userId ?? this.userId,
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
    );
  }

//</editor-fold>
}
