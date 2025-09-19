import 'package:horda_server/horda_server.dart';
import 'package:twitter_server/twitter_server.dart';

import 'messages.dart';

/// View group of [TimelineEntity].
///
/// {@category View Group}
class TimelineViewGroup implements EntityViewGroup {
  TimelineViewGroup()
    : updatedAtView = ValueView<DateTime>(
        name: 'timelineUpdatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      tweetsView = RefListView<TweetEntity>(name: 'timelineTweetsView'),
      ownerUserView = RefView<UserAccountEntity>(
        name: 'ownerUserView',
        value: null,
      );

  TimelineViewGroup.fromInitEvent(TimelineCreated event)
    : updatedAtView = ValueView<DateTime>(
        name: 'timelineUpdatedAtView',
        value: DateTime.now().toUtc(),
      ),
      tweetsView = RefListView<TweetEntity>(name: 'timelineTweetsView'),
      ownerUserView = RefView<UserAccountEntity>(
        name: 'ownerUserView',
        value: event.ownerUserId,
      );

  /// View for the last update date and time
  final ValueView<DateTime> updatedAtView;

  /// View for the list of tweets in the timeline
  final RefListView<TweetEntity> tweetsView;

  /// View that references the owner user profile entity
  final RefView<UserAccountEntity> ownerUserView;

  void tweetAddedToTimeline(TweetAddedToTimeline event) {
    tweetsView.addItem(event.tweetId);
    updatedAtView.value = DateTime.now().toUtc();
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(updatedAtView)
      ..add(tweetsView)
      ..add(ownerUserView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<TimelineCreated>(TimelineViewGroup.fromInitEvent)
      ..add<TweetAddedToTimeline>(tweetAddedToTimeline);
  }
}
