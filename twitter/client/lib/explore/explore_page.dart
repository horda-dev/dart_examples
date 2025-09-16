import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart'; // For ExploreFeedQuery
import '../home/home_page.dart'; // For TweetCard
import 'explore_view_model.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late final ExploreViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ExploreViewModel(context);
  }

  // For now, let's assume a fixed Explore Feed ID.
  // In a real app, this might be a singleton or a well-known ID.
  static const String _dummyExploreFeedId = 'explore-feed-123'; // Placeholder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: context.entityQuery(
        entityId: _dummyExploreFeedId, // Query the ExploreFeedEntity
        query: ExploreFeedQuery(), // Use ExploreFeedQuery
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load explore feed')),
        child: _ExploreLoadedView(viewModel: _viewModel),
      ),
    );
  }
}

class _ExploreLoadedView extends StatelessWidget {
  final ExploreViewModel viewModel;

  const _ExploreLoadedView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final tweetsLength = viewModel.tweetsLength;

    if (tweetsLength == 0) {
      return const Center(
        child: Text('No trending tweets right now.'),
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
