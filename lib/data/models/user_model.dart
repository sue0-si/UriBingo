class UserModel {
  String email;
  String employeeNumber;
  bool manager;
  String name;
  String validationCode;
  String groupName;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.email,
    required this.employeeNumber,
    required this.manager,
    required this.name,
    required this.validationCode,
    required this.groupName,
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
          groupName == other.groupName);

  @override
  int get hashCode =>
      email.hashCode ^
      employeeNumber.hashCode ^
      manager.hashCode ^
      name.hashCode ^
      validationCode.hashCode ^
      groupName.hashCode;

  @override
  String toString() {
    return 'UserModel{ email: $email, employeeNumber: $employeeNumber, manager: $manager, name: $name, validationCode: $validationCode, groupName: $groupName,}';
  }

  UserModel copyWith({
    String? email,
    String? employeeNumber,
    bool? manager,
    String? name,
    String? validationCode,
    String? groupName,
  }) {
    return UserModel(
      email: email ?? this.email,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      manager: manager ?? this.manager,
      name: name ?? this.name,
      validationCode: validationCode ?? this.validationCode,
      groupName: groupName ?? this.groupName,
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
    );
  }

//</editor-fold>
}
