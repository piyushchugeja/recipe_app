import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({Key? key}) : super(key: key);
  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _cuisineController;
  late TextEditingController _caloriesController;
  late TextEditingController _cookTimeController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cuisineController = TextEditingController();
    _caloriesController = TextEditingController();
    _cookTimeController = TextEditingController();
    _ingredientsController = TextEditingController();
    _instructionsController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cuisineController.dispose();
    _caloriesController.dispose();
    _cookTimeController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedImage;
    });
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      // show a toast with all recipe details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Name: ${_nameController.text}\n'
            'Cuisine: ${_cuisineController.text}\n'
            'Calories: ${_caloriesController.text}\n'
            'Cook Time: ${_cookTimeController.text}\n'
            'Ingredients: ${_ingredientsController.text}\n'
            'Instructions: ${_instructionsController.text}\n',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cuisineController,
                decoration: const InputDecoration(
                  labelText: 'Cuisine',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a cuisine';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Calories',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter calories';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cookTimeController,
                decoration: const InputDecoration(
                  labelText: 'Cook Time',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cook time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(
                  labelText: 'Ingredients',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ingredients';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Instructions',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter instructions';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Add Image'),
              ),
              const SizedBox(height: 16),
              if (_imageFile != null)
                Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                  height: 200,
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: const Text('Save Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
