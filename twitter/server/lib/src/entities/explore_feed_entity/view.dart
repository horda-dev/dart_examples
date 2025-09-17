import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [ExploreFeedEntity].
///
/// {@category View Group}
class ExploreFeedViewGroup implements EntityViewGroup {
  ExploreFeedViewGroup()
      : tweetsView = RefListView<TweetEntity>(name: 'tweetsView'),
        updatedAtView = ValueView<DateTime>(
          name: 'updatedAtView',
          value: DateTime.fromMicrosecondsSinceEpoch(0),
        );

  ExploreFeedViewGroup.fromInitEvent(ExploreFeedCreated event)
      : tweetsView = RefListView<TweetEntity>(name: 'tweetsView'),
        updatedAtView = ValueView<DateTime>(
          name: 'updatedAtView',
          value: DateTime.now().toUtc(),
        );

  /// View for the list of tweets in the explore feed
  final RefListView<TweetEntity> tweetsView;

  /// View for the last update date and time
  final ValueView<DateTime> updatedAtView;

  void tweetAddedToExploreFeed(TweetAddedToExploreFeed event) {
    tweetsView.addItem(event.tweetId);
    updatedAtView.value = DateTime.now().toUtc();
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(tweetsView)
      ..add(updatedAtView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<ExploreFeedCreated>(ExploreFeedViewGroup.fromInitEvent)
      ..add<TweetAddedToExploreFeed>(tweetAddedToExploreFeed);
  }
}
