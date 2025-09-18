import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import '../shared/tweet_view_model.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              final userId = context.hordaAuthUserId;
              if (userId != null) {
                context.go('/profile/$userId');
              }
            },
          ),
        ],
      ),
      body: context.entityQuery(
        entityId: context.hordaAuthUserId!,
        query: UserTimelineQuery(),
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load user account')),
        child: Builder(
          builder: (context) {
            final model = HomeViewModel(context);
            return _LoadedView(model: model);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/compose_tweet');
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final HomeViewModel model;

  const _LoadedView({required this.model});

  @override
  Widget build(BuildContext context) {
    final tweetsLength = model.tweetsLength;

    if (tweetsLength == 0) {
      return const Center(
        child: Text(
          'No tweets yet. Start following someone or post your first tweet!',
        ),
      );
    }

    return ListView.builder(
      itemCount: tweetsLength,
      itemBuilder: (context, index) {
        final tweet = model.getTweet(tweetsLength - index - 1);
        return TweetCard(tweet: tweet);
      },
    );
  }
}

class TweetCard extends StatelessWidget {
  final TweetViewModel tweet;

  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context) {
    final authorDisplayName = tweet.author.displayName;
    final authorHandle = tweet.author.handle;
    final tweetText = tweet.text;
    final likeCount = tweet.likeCount;
    final retweetCount = tweet.retweetCount;
    final createdAt = tweet.createdAt;
    final attachmentUrl = tweet.attachmentUrl;

    if (tweet.isAuthorBlocked) {
      return SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        context.go('./tweet/${tweet.id}');
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
                  context.go('./profile/${tweet.author.id}');
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(tweet.author.avatarUrl),
                    ),
                    const SizedBox(width: 8.0),
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
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(tweetText),
              if (attachmentUrl.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 300.0),
                      child: Image.network(attachmentUrl, fit: BoxFit.cover),
                    ),
                  ),
                ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      tweet.isLikedByCurrentUser
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: tweet.isLikedByCurrentUser ? Colors.red : null,
                    ),
                    onPressed: () => tweet.toggleLikeTweet(),
                  ),
                  Text('$likeCount'),
                  const SizedBox(width: 16.0),
                  IconButton(
                    icon: const Icon(Icons.repeat),
                    onPressed: () => tweet.retweet(),
                  ),
                  Text('$retweetCount'),
                  const SizedBox(width: 16.0),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: null,
                    color: Colors.black,
                    disabledColor: Colors.black,
                  ),
                  Text('${tweet.commentCount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute} - ${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
