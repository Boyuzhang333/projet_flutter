class User {
  const User({
    required this.login,
    required this.password,
    required this.birthday,
    required this.address,
    required this.postalCode,
    required this.city,
  });

  final String login;
  final String password;
  final String birthday;
  final String address;
  final String postalCode;
  final String city;

  User copyWith({
    String? password,
    String? birthday,
    String? address,
    String? postalCode,
    String? city,
  }) {
    return User(
      login: login,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
    );
  }
}
