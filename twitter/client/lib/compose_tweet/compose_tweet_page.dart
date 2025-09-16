import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _onSendTweetPressed() async {
    if (_tweetTextController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Tweet cannot be empty.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _viewModel.sendTweet(text: _tweetTextController.text);
      if (mounted) {
        _tweetTextController.clear();
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
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _onSendTweetPressed,
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Tweet', style: TextStyle(color: Colors.white)),
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
