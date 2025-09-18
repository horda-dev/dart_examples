import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'compose_tweet_view_model.dart';

class ComposeTweetPage extends StatefulWidget {
  const ComposeTweetPage({super.key});

  @override
  State<ComposeTweetPage> createState() => _ComposeTweetPageState();
}

class _ComposeTweetPageState extends State<ComposeTweetPage> {
  final TextEditingController _tweetTextController = TextEditingController();
  late final ComposeTweetViewModel _viewModel;
  bool _isLoading = false;
  String? _errorMessage;

  File? _selectedImage;
  String? _attachmentBase64;

  @override
  void initState() {
    super.initState();
    _viewModel = ComposeTweetViewModel(context);
  }

  @override
  void dispose() {
    _tweetTextController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = File(pickedFile.path);
        _attachmentBase64 = base64Encode(bytes);
      });
    }
  }

  Future<void> _onSendTweetPressed() async {
    if (_tweetTextController.text.isEmpty && _selectedImage == null) {
      setState(() {
        _errorMessage = 'Tweet cannot be empty without an attachment.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _viewModel.sendTweet(
        text: _tweetTextController.text,
        attachmentBase64: _attachmentBase64,
      );
      if (mounted) {
        _tweetTextController.clear();
        _selectedImage = null;
        _attachmentBase64 = null;
        context.pop(); // Go back to the previous page (e.g., home)
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
        title: const Text('Compose Tweet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
          ),
          IconButton(
            icon: _isLoading
                ? const CircularProgressIndicator(color: Colors.black)
                : const Icon(Icons.send, color: Colors.black),
            onPressed: _isLoading ? null : _onSendTweetPressed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tweetTextController,
              maxLines: null, // Allows multiple lines
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'What\'s happening?',
                border: InputBorder.none, // No border
              ),
            ),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
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
