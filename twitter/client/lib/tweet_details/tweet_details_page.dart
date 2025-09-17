import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import 'tweet_details_view_model.dart';

class TweetDetailsPage extends StatelessWidget {
  final String tweetId;

  const TweetDetailsPage({super.key, required this.tweetId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: context.entityQuery(
        entityId: tweetId,
        query: TweetQuery(),
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load tweet details')),
        child: Builder(
          builder: (context) {
            return _LoadedView(
              model: TweetDetailsViewModel(context),
            );
          },
        ),
      ),
    );
  }
}

class _LoadedView extends StatefulWidget {
  const _LoadedView({required this.model});

  final TweetDetailsViewModel model;

  @override
  State<_LoadedView> createState() => _LoadedViewState();
}

class _LoadedViewState extends State<_LoadedView> {
  TweetDetailsViewModel get model => widget.model;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.go('./profile/${model.author.id}');
                  },
                  child: Row(
                    children: [
                      Text(
                        model.author.displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' @${model.author.handle}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        model.createdAt,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(model.text, style: const TextStyle(fontSize: 16.0)),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () => model.toggleLikeTweet(),
                    ),
                    Text('${model.likeCount}'),
                    const SizedBox(width: 16.0),
                    IconButton(
                      icon: const Icon(Icons.repeat),
                      onPressed: () => model.retweet(),
                    ),
                    Text('${model.retweetCount}'),
                    const SizedBox(width: 16.0),
                    const Icon(Icons.comment),
                    Text('${model.commentsLength}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              _isCommenting
                  ? const CircularProgressIndicator()
                  : IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _onAddComment,
                    ),
            ],
          ),
        ),
        if (_commentError != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              _commentError!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: model.commentsLength,
            itemBuilder: (context, index) {
              final commentModel = model.getComment(index);
              return CommentCard(
                model: commentModel,
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _onAddComment() async {
    if (_commentController.text.isEmpty) return;

    setState(() {
      _isCommenting = true;
      _commentError = null;
    });

    try {
      await model.addComment(
        _commentController.text,
      );

      _commentController.clear();
    } catch (e) {
      if (mounted) {
        setState(() {
          _commentError = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCommenting = false;
        });
      }
    }
  }

  final TextEditingController _commentController = TextEditingController();

  bool _isCommenting = false;

  String? _commentError;
}

class CommentCard extends StatelessWidget {
  final CommentViewModel model;

  const CommentCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                context.go('./profile/${model.author.id}');
              },
              child: Row(
                children: [
                  Text(
                    model.author.displayName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' @${model.author.handle}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    model.createdAt,
                    style: const TextStyle(color: Colors.grey, fontSize: 10.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Text(model.text),
            const SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, size: 18),
                  onPressed: () => model.toggleLikeComment(),
                ),
                Text('${model.likeCount}'),
                const SizedBox(width: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
