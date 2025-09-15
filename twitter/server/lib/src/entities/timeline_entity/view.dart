import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [TimelineEntity].
///
/// {@category View Group}
class TimelineViewGroup implements EntityViewGroup {
  TimelineViewGroup();

  /// View for the last update date and time
  final ValueView<DateTime> updatedAtView = ValueView<DateTime>(
    name: 'updatedAtView',
    value: DateTime.fromMicrosecondsSinceEpoch(0),
  );

  /// View for the list of tweets in the timeline
  final RefListView<TweetEntity> tweetsView = RefListView<TweetEntity>(
    name: 'tweetsView',
  );

  /// View that references the owner user profile entity
  final RefView<UserProfileEntity> ownerUserView = RefView<UserProfileEntity>(
    name: 'ownerUserView',
    value: null,
  );

  @override
  void initViews(ViewGroup views) {}

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {}
}
