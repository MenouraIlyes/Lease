class UserProfile {
  String username;
  String password;
  String email;
  String phoneNumber;
  String role;

  UserProfile({
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      role: json['role'],
    );
  }

  dynamic operator [](String key) {
    switch (key) {
      case 'username':
        return username;
      case 'password':
        return password;
      case 'email':
        return email;
      case 'phoneNumber':
        return phoneNumber;
      case 'role':
        return role;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['role'] = this.role;
    return data;
  }
}
