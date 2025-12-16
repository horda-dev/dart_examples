import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../home/home_page.dart';
import '../queries.dart';
import '../shared/infinite_scroll_list.dart';
import '../shared/tweet_view_model.dart';

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
      body: InfiniteScrollListView(
        entityId: kSingletonId,
        createQuery: (endBefore, pageSize) => ExploreFeedQuery(
          endBefore: endBefore,
          pageSize: pageSize,
        ),
        listSelector: (q) => q.tweets,
        itemBuilder: (context, pageIndex) {
          return ExploreFeedListPage();
        },
        emptyWidget: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Text(
              'No trending tweets right now.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreFeedListPage extends StatelessWidget {
  const ExploreFeedListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tweetsLength = context.query<ExploreFeedQuery>().listLength(
      (q) => q.tweets,
    );
    
    return Column(
      children: [
        for (var i = tweetsLength - 1; i >= 0; i--)
          TweetCard(
            tweet: TweetViewModel(
              context,
              context.query<ExploreFeedQuery>().listItemQuery(
                (q) => q.tweets,
                i,
              ),
            ),
          ),
      ],
    );
  }
}
