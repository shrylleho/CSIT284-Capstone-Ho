import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/item_model.dart';
import '../providers/item_provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();

  String _selectedStatus = 'Lost';
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final newItem = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      status: _selectedStatus,
      location: _locationController.text.trim(),
      contactInfo: _contactController.text.trim(),
      imagePath: _selectedImagePath,
      datePosted: DateTime.now(),
    );

    context.read<ItemProvider>().addItem(newItem);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Lost or Found Item'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Lost vs Found Toggle
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'Lost',
                  label: Text('I Lost Something'),
                  icon: Icon(Icons.search),
                ),
                ButtonSegment(
                  value: 'Found',
                  label: Text('I Found Something'),
                  icon: Icon(Icons.check_circle_outline),
                ),
              ],
              selected: {_selectedStatus},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedStatus = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 16),

            // Image Picker Box
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                child: _selectedImagePath != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            File(_selectedImagePath!),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: FilledButton.tonalIcon(
                              onPressed: _pickImage,
                              icon: const Icon(Icons.edit, size: 16),
                              label: const Text('Change'),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 40,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to attach a photo (Optional)',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Item Name
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Item Name *',
                hintText: 'e.g., Black Hydro Flask, Student ID',
                border: OutlineInputBorder(),
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Please enter the item name'
                  : null,
            ),
            const SizedBox(height: 16),

            // Location
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location *',
                hintText: 'e.g., CCS Lab 3, Main Canteen',
                border: OutlineInputBorder(),
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Please specify where it was lost or found'
                  : null,
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description *',
                hintText: 'Color, brand, distinguishing marks...',
                border: OutlineInputBorder(),
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Please provide a brief description'
                  : null,
            ),
            const SizedBox(height: 16),

            // Contact Info
            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: 'Contact Info *',
                hintText: 'Phone number, FB name, or School Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Contact info is required so others can reach you'
                  : null,
            ),
            const SizedBox(height: 24),

            // Submit Button
            FilledButton(
              onPressed: _submitForm,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Post to Board'),
            ),
          ],
        ),
      ),
    );
  }
}