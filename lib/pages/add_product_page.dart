import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  String? _category;

  final _titleController = TextEditingController();
  final _sizeController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _sizeController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      _pickedImage = picked;
      _category = _detectCategory(picked.path);
    });
  }

  String _detectCategory(String imagePath) {
    // Mock AI detection based on a hash of the imagePath.
    final hash = imagePath.hashCode % 3;
    switch (hash) {
      case 0:
        return 'Pantalon';
      case 1:
        return 'Haut';
      default:
        return 'Short';
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_pickedImage == null || _category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image requise pour detecter la categorie')),
      );
      return;
    }

    final product = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      category: _category!,
      size: _sizeController.text.trim(),
      brand: _brandController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      imageUrl: _pickedImage!.path,
    );

    await ProductService.addProduct(product);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produit ajoute')),
    );
    Navigator.of(context).pop(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un vetement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                    image: _pickedImage != null
                        ? DecorationImage(
                            image: FileImage(File(_pickedImage!.path)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _pickedImage == null
                      ? const Center(child: Text('Choisir une image (local)'))
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Titre requis' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Categorie (detectee)',
                  border: const OutlineInputBorder(),
                  hintText: _category == null ? 'Selectionnez une image' : _category,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sizeController,
                decoration: const InputDecoration(
                  labelText: 'Taille',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Taille requise' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Marque',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Marque requise' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Prix',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Prix requis';
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null) return 'Prix invalide';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Valider'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
