import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/presentation/widgets/custom_snackbar.dart';

class Imagepicker extends StatefulWidget {
  final String? initialImage;
  final Function(String?)? onImageChanged;
  const Imagepicker({super.key, this.initialImage, this.onImageChanged});

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  final ImagePicker _picker = ImagePicker();
  String? file;

  @override
  void initState() {
    super.initState();
    // Initialize with the prop from parent
    file = widget.initialImage;
  }

  @override
  void didUpdateWidget(Imagepicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update local state when parent prop changes
    if (widget.initialImage != oldWidget.initialImage) {
      setState(() {
        file = widget.initialImage;
      });
    }
  }

  void _updateImage(String? newFile) {
    setState(() {
      file = newFile;
    });
    if (widget.onImageChanged != null) {
      widget.onImageChanged!(newFile);
    }
  }

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        _updateImage(pickedFile.path);
      }
    } catch (e) {
      CustomSnackbar.show(context, 'Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (file != null) ...[
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(File(file!), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              setState(() {
                file = null;
              });
            },
            icon: const Icon(Icons.delete, color: Colors.red),
            label: const Text(
              'Remove Image',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
        ElevatedButton.icon(
          onPressed: _showImageSourceDialog,
          icon: const Icon(Icons.add_a_photo),
          label: const Text('Pick Image'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
