import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';
import 'package:twitter_server/twitter_server.dart';

import '../home/home_page.dart';
import '../queries.dart';
import 'explore_view_model.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: context.entityQuery(
        entityId: kExploreFeedEntityId,
        query: ExploreFeedQuery(),
        loading: const Center(
          child: CircularProgressIndicator(),
        ),
        error: const Center(
          child: Text('Failed to load explore feed'),
        ),
        child: Builder(
          builder: (context) {
            return _LoadedView(
              model: ExploreViewModel(context),
            );
          },
        ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final ExploreViewModel model;

  const _LoadedView({required this.model});

  @override
  Widget build(BuildContext context) {
    final tweetsLength = model.tweetsLength;

    if (tweetsLength == 0) {
      return const Center(
        child: Text('No trending tweets right now.'),
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
