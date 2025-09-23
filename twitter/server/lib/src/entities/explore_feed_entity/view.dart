import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [ExploreFeedEntity].
///
/// {@category View Group}
class ExploreFeedViewGroup implements EntityViewGroup {
  ExploreFeedViewGroup()
    : exploreFeedTweetsView = RefListView<TweetEntity>(
        name: 'exploreFeedTweetsView',
      ),
      exploreFeedUpdatedAtView = ValueView<DateTime>(
        name: 'exploreFeedUpdatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      );

  ExploreFeedViewGroup.fromInitEvent(ExploreFeedCreated event)
    : exploreFeedTweetsView = RefListView<TweetEntity>(
        name: 'exploreFeedTweetsView',
      ),
      exploreFeedUpdatedAtView = ValueView<DateTime>(
        name: 'exploreFeedUpdatedAtView',
        value: DateTime.now().toUtc(),
      );

  /// View for the list of tweets in the explore feed
  final RefListView<TweetEntity> exploreFeedTweetsView;

  /// View for the last update date and time
  final ValueView<DateTime> exploreFeedUpdatedAtView;

  void tweetAddedToExploreFeed(TweetAddedToExploreFeed event) {
    exploreFeedTweetsView.addItem(event.tweetId);
    exploreFeedUpdatedAtView.value = DateTime.now().toUtc();
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(exploreFeedTweetsView)
      ..add(exploreFeedUpdatedAtView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<ExploreFeedCreated>(ExploreFeedViewGroup.fromInitEvent)
      ..add<TweetAddedToExploreFeed>(tweetAddedToExploreFeed);
  }
}
