class UserModel {
  final String id;
  final String name;
  final String email;
  final String userType; // 'parent' or 'child'
  final String? phoneNumber;
  final List<String>? linkedAccounts; // For parent: child IDs, For child: parent IDs
  final Map<String, dynamic>? settings;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    this.phoneNumber,
    this.linkedAccounts,
    this.settings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userType: json['userType'],
      phoneNumber: json['phoneNumber'],
      linkedAccounts: List<String>.from(json['linkedAccounts'] ?? []),
      settings: json['settings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userType': userType,
      'phoneNumber': phoneNumber,
      'linkedAccounts': linkedAccounts,
      'settings': settings,
    };
  }
}
