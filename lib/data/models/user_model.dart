class UserModel {
  String email;
  String employeeNumber;
  bool manager;
  String name;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.email,
    required this.employeeNumber,
    required this.manager,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          employeeNumber == other.employeeNumber &&
          manager == other.manager &&
          name == other.name);

  @override
  int get hashCode =>
      email.hashCode ^
      employeeNumber.hashCode ^
      manager.hashCode ^
      name.hashCode;

  @override
  String toString() {
    return 'UserModel{ email: $email, employeeNumber: $employeeNumber, manager: $manager, name: $name,}';
  }

  UserModel copyWith({
    String? email,
    String? employeeNumber,
    bool? manager,
    String? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      employeeNumber: employeeNumber ?? this.employeeNumber,
      manager: manager ?? this.manager,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'employeeNumber': this.employeeNumber,
      'manager': this.manager,
      'name': this.name,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      employeeNumber: map['employeeNumber'] as String,
      manager: map['manager'] as bool,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}
