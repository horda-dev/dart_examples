import 'package:horda_server/horda_server.dart';

import '../../../twitter_server.dart';

/// View group of [TimelineEntity].
///
/// {@category View Group}
class TimelineViewGroup implements EntityViewGroup {
  TimelineViewGroup()
    : timelineUpdatedAtView = ValueView<DateTime>(
        name: 'timelineUpdatedAtView',
        value: DateTime.fromMicrosecondsSinceEpoch(0),
      ),
      timelineTweetsView = RefListView<TweetEntity>(name: 'timelineTweetsView'),
      ownerUserView = RefView<UserAccountEntity>(
        name: 'ownerUserView',
        value: null,
      );

  TimelineViewGroup.fromInitEvent(TimelineCreated event)
    : timelineUpdatedAtView = ValueView<DateTime>(
        name: 'timelineUpdatedAtView',
        value: DateTime.now().toUtc(),
      ),
      timelineTweetsView = RefListView<TweetEntity>(name: 'timelineTweetsView'),
      ownerUserView = RefView<UserAccountEntity>(
        name: 'ownerUserView',
        value: event.ownerUserId,
      );

  /// View for the last update date and time
  final ValueView<DateTime> timelineUpdatedAtView;

  /// View for the list of tweets in the timeline
  final RefListView<TweetEntity> timelineTweetsView;

  /// View that references the owner user profile entity
  final RefView<UserAccountEntity> ownerUserView;

  void tweetAddedToTimeline(TweetAddedToTimeline event) {
    timelineTweetsView.addItem(event.tweetId);
    timelineUpdatedAtView.value = DateTime.now().toUtc();
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(timelineUpdatedAtView)
      ..add(timelineTweetsView)
      ..add(ownerUserView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<TimelineCreated>(TimelineViewGroup.fromInitEvent)
      ..add<TweetAddedToTimeline>(tweetAddedToTimeline);
  }
}
