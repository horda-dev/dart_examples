import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [ExploreFeedEntity].
///
/// {@category View Group}
class ExploreFeedViewGroup implements EntityViewGroup {
  ExploreFeedViewGroup();

  /// View for the list of tweets in the explore feed
  final RefListView<TweetEntity> tweetsView = RefListView<TweetEntity>(
    name: 'tweetsView',
  );

  @override
  void initViews(ViewGroup views) {}

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {}
}
