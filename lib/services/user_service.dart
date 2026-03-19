import 'package:flutter/foundation.dart';

import '../models/user.dart';

/// Temporary in-memory user store.
/// Replace with real persistence (e.g., Firebase) later.
class UserService {
  UserService._();

  static final ValueNotifier<User> currentUser =
      ValueNotifier<User>(_mockUser);

  static Future<void> saveUser(User updated) async {
    // Simulate async persistence.
    await Future<void>.delayed(const Duration(milliseconds: 150));
    currentUser.value = updated;
    debugPrint('User saved: ${updated.login}');
  }

  static const User _mockUser = User(
    login: 'jdoe@example.com',
    password: 'secret123',
    birthday: '1995-06-01',
    address: '123 Rue de Paris',
    postalCode: '75001',
    city: 'Paris',
  );
}
