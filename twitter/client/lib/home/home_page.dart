import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:horda_client/horda_client.dart';
import 'package:twitter_client/queries.dart'; // Import client queries
import 'home_view_model.dart'; // Import the new ViewModel
import 'home_models.dart'; // Import the new models

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(context);
  }

  static const String _dummyUserId = 'user-account-123'; // Placeholder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.explore),
            onPressed: () {
              context.go('/explore');
            },
          ),
        ],
      ),
      body: context.entityQuery(
        entityId: _dummyUserId,
        query: UserAccountQuery(),
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load user account')),
        child: _UserAccountLoadedView(viewModel: _viewModel),
      ),
    );
  }
}

class _UserAccountLoadedView extends StatelessWidget {
  final HomeViewModel viewModel;

  const _UserAccountLoadedView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final tweetsLength = viewModel.tweetsLength;

    if (tweetsLength == 0) {
      return const Center(
        child: Text('No tweets yet. Start following someone or post your first tweet!'),
      );
    }

    return ListView.builder(
      itemCount: tweetsLength,
      itemBuilder: (context, index) {
        final tweetItem = viewModel.getTweet(index);
        return TweetCard(tweet: tweetItem);
      },
    );
  }
}

class TweetCard extends StatelessWidget {
  final TweetItem tweet;

  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context) {
    final authorDisplayName = tweet.author.displayName;
    final authorHandle = tweet.author.bio;
    final tweetText = tweet.text;
    final likeCount = tweet.likeCount;
    final retweetCount = tweet.retweetCount;
    final createdAt = tweet.createdAt;

    return GestureDetector(
      onTap: () {
        context.go('/tweet/${tweet.id}');
      },
      child: Card(
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
                    authorDisplayName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' @$authorHandle',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    _formatTimestamp(createdAt),
                    style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(tweetText),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.favorite_border),
                Text('$likeCount'),
                const SizedBox(width: 16.0),
                Icon(Icons.repeat),
                Text('$retweetCount'),
              ],
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