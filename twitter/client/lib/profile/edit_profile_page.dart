import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_client/queries.dart';

import 'edit_profile_view_model.dart';

class EditProfilePage extends StatelessWidget {
  final String userId;

  const EditProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return context.entityQuery(
      entityId: userId,
      query: UserAccountQuery(),
      loading: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: const Scaffold(
        body: Center(
          child: Text('Failed to load user data'),
        ),
      ),
      child: Builder(
        builder: (context) {
          return _EditProfileLoadedView(userId: userId);
        },
      ),
    );
  }
}

class _EditProfileLoadedView extends StatefulWidget {
  final String userId;

  const _EditProfileLoadedView({required this.userId});

  @override
  State<_EditProfileLoadedView> createState() => _EditProfileLoadedViewState();
}

class _EditProfileLoadedViewState extends State<_EditProfileLoadedView> {
  late final EditProfileViewModel _viewModel;
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _selectedImage;
  String? _avatarBase64;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _viewModel = EditProfileViewModel(context);
    _displayNameController.text = _viewModel.displayName;
    _bioController.text = _viewModel.bio;
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = File(pickedFile.path);
        _avatarBase64 = base64Encode(bytes);
      });
    }
  }

  Future<void> _onSavePressed() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _viewModel.updateProfile(
        displayName: _displayNameController.text,
        bio: _bioController.text,
        avatarBase64: _avatarBase64,
      );
      if (mounted) {
        context.pop(); // Go back to the profile page
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: _isLoading
                ? const CircularProgressIndicator(color: Colors.black)
                : const Icon(Icons.save, color: Colors.black),
            onPressed: _isLoading ? null : _onSavePressed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : NetworkImage(_viewModel.avatarUrl) as ImageProvider,
                child: _selectedImage == null && _viewModel.avatarUrl.isEmpty
                    ? Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.grey[800],
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _displayNameController,
              decoration: const InputDecoration(labelText: 'Display Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _bioController,
              maxLines: null,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
