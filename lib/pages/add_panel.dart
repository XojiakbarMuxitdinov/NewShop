import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:new_shop/pages/shop_page.dart'; 

class AddPanel extends StatefulWidget {
  const AddPanel({super.key});

  @override
  _AddPanelState createState() => _AddPanelState();
}

class _AddPanelState extends State<AddPanel> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Upload image to Firebase Storage and get URL
  Future<String> _uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child('products/$fileName');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  // Add product to Firestore
  Future<void> _addProduct() async {
    if (_nameController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _image != null) {
      String imageUrl = await _uploadImage(_image!);

      await FirebaseFirestore.instance.collection('products').add({
        'name': _nameController.text,
        'category': _categoryController.text,
        'price': double.parse(_priceController.text),
        'image': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maxsulot muvafaqiyatli qo\'shildi')),
      );

      _nameController.clear();
      _categoryController.clear();
      _priceController.clear();
      setState(() {
        _image = null;
      });

      // Navigate to ShopPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ShopPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iltimos, barcha maydonlarni to\'ldiring va rasmni tanlang')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Product',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Maxsulot nomi'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Turi'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Narxi'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            _image == null
                ? const Text('Hech qanday rasm tanlanmagan.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Rasmni tanlang'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Maxsulot qo\'shish'),
            ),
          ],
        ),
      ),
    );
  }
}
