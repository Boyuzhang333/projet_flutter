import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import '../services/user_service.dart';
import 'add_product_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _addressController;
  late final TextEditingController _postalController;
  late final TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    final user = UserService.currentUser.value;
    _loginController = TextEditingController(text: user.login);
    _passwordController = TextEditingController(text: user.password);
    _birthdayController = TextEditingController(text: user.birthday);
    _addressController = TextEditingController(text: user.address);
    _postalController = TextEditingController(text: user.postalCode);
    _cityController = TextEditingController(text: user.city);
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _birthdayController.dispose();
    _addressController.dispose();
    _postalController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final updated = User(
      login: _loginController.text,
      password: _passwordController.text,
      birthday: _birthdayController.text,
      address: _addressController.text,
      postalCode: _postalController.text,
      city: _cityController.text,
    );
    await UserService.saveUser(updated);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis a jour')),
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login',
      (route) => false,
    );
  }

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    final currentText = _birthdayController.text;
    DateTime? initial;
    try {
      initial = DateTime.parse(currentText);
    } catch (_) {
      initial = DateTime(now.year - 20, now.month, now.day);
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: initial!,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      _birthdayController.text = picked.toIso8601String().split('T').first;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: ValueListenableBuilder<User>(
        valueListenable: UserService.currentUser,
        builder: (context, user, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _TextField(
                  controller: _loginController,
                  label: 'Login',
                  readOnly: true,
                ),
                const SizedBox(height: 12),
                _TextField(
                  controller: _passwordController,
                  label: 'Mot de passe',
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                _TextField(
                  controller: _birthdayController,
                  label: 'Date de naissance',
                  readOnly: true,
                  onTap: _pickBirthday,
                ),
                const SizedBox(height: 12),
                _TextField(
                  controller: _addressController,
                  label: 'Adresse',
                ),
                const SizedBox(height: 12),
                _TextField(
                  controller: _postalController,
                  label: 'Code postal',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 12),
                _TextField(
                  controller: _cityController,
                  label: 'Ville',
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _save,
                        child: const Text('Valider'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _logout(context),
                        child: const Text('Se deconnecter'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AddProductPage(),
                            ),
                          );
                        },
                        child: const Text('Ajouter un vêtement'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
  });

  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
