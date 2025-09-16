import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart'; // For TweetQuery
import '../home/home_models.dart'; // For TweetItem
import 'tweet_details_models.dart'; // For CommentItem
import 'tweet_details_view_model.dart';

class TweetDetailsPage extends StatefulWidget {
  final String tweetId;

  const TweetDetailsPage({super.key, required this.tweetId});

  @override
  State<TweetDetailsPage> createState() => _TweetDetailsPageState();
}

class _TweetDetailsPageState extends State<TweetDetailsPage> {
  late final TweetDetailsViewModel _viewModel;
  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;
  String? _commentError;

  @override
  void initState() {
    super.initState();
    _viewModel = TweetDetailsViewModel(context, widget.tweetId);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _onAddComment() async {
    if (_commentController.text.isEmpty) return;

    setState(() {
      _isCommenting = true;
      _commentError = null;
    });

    try {
      await _viewModel.addComment(widget.tweetId, _commentController.text);
      if (mounted) {
        _commentController.clear();
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet'),
      ),
      body: context.entityQuery(
        entityId: widget.tweetId,
        query: TweetQuery(),
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load tweet details')),
        child: _TweetDetailsLoadedView(viewModel: _viewModel),
      ),
    );
  }
}

class _TweetDetailsLoadedView extends StatelessWidget {
  final TweetDetailsViewModel viewModel;

  const _TweetDetailsLoadedView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final tweet = viewModel.tweet;

    return Column(
      children: [
        // Main Tweet Card
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.go('/profile/${tweet.author.id}');
                  },
                  child: Row(
                    children: [
                      Text(
                        tweet.author.displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' @${tweet.author.bio}', // Using bio as handle
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        _formatTimestamp(tweet.createdAt),
                        style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(tweet.text, style: const TextStyle(fontSize: 16.0)),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () => viewModel.toggleLikeTweet(tweet.id),
                    ),
                    Text('${tweet.likeCount}'),
                    const SizedBox(width: 16.0),
                    IconButton(
                      icon: const Icon(Icons.repeat),
                      onPressed: () => viewModel.retweet(tweet.id),
                    ),
                    Text('${tweet.retweetCount}'),
                    const SizedBox(width: 16.0),
                    const Icon(Icons.comment),
                    Text('${viewModel.commentsLength}'), // Total comments
                  ],
                ),
              ],
            ),
          ),
        ),
        // Comment Input
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: (context.findAncestorStateOfType<_TweetDetailsPageState>()!._commentController),
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              (context.findAncestorStateOfType<_TweetDetailsPageState>()!._isCommenting)
                  ? const CircularProgressIndicator()
                  : IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: (context.findAncestorStateOfType<_TweetDetailsPageState>()!._onAddComment),
                    ),
            ],
          ),
        ),
        if ((context.findAncestorStateOfType<_TweetDetailsPageState>()!._commentError) != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              (context.findAncestorStateOfType<_TweetDetailsPageState>()!._commentError)!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        const Divider(),
        // Comments List
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.commentsLength,
            itemBuilder: (context, index) {
              final comment = viewModel.getComment(index);
              return CommentCard(comment: comment, viewModel: viewModel);
            },
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute} - ${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}

class CommentCard extends StatelessWidget {
  final CommentItem comment;
  final TweetDetailsViewModel viewModel;

  const CommentCard({super.key, required this.comment, required this.viewModel});

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
                context.go('/profile/${comment.author.id}');
              },
              child: Row(
                children: [
                  Text(
                    comment.author.displayName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' @${comment.author.bio}', // Using bio as handle
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    _formatTimestamp(comment.createdAt),
                    style: const TextStyle(color: Colors.grey, fontSize: 10.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Text(comment.text),
            const SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, size: 18),
                  onPressed: () => viewModel.toggleLikeComment(comment.id),
                ),
                Text('${comment.likeCount}'),
                const SizedBox(width: 16.0),
                // Add reply button if needed
              ],
            ),
            // Nested replies
            if (comment.replies.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Column(
                  children: comment.replies.map((reply) => CommentCard(comment: reply, viewModel: viewModel)).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute} - ${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
