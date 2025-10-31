# Twitter Client

## Overview

A Flutter application that mimics a Twitter-like social media platform, demonstrating the integration of the Horda Client SDK for real-time data synchronization and interaction with a Horda backend. This client showcases user authentication, tweet creation, timeline display, user profiles, and social interactions like following, liking, and commenting.

You can view the Twitter example in the [Horda Console](https://console.horda.dev/?project=d368c1sgc98s738ue7cg).

## Demo:

<div align="center">
  <video src="https://github.com/user-attachments/assets/bbbe0981-7d2a-4968-8f2c-6c19f381e001" />
</div>

## Features

*   **User Authentication:** Sign up and sign in using email and password, powered by Firebase Authentication.
*   **Home Feed:** View a personalized timeline of tweets from users you follow.
*   **Explore Feed:** Discover trending tweets from across the platform.
*   **Tweet Composition:** Create new tweets with text and optional image attachments.
*   **Tweet Interactions:** Like, retweet, and comment on tweets.
*   **User Profiles:** View and edit user profiles, including display name, bio, and avatar.
*   **Social Graph:** Follow and unfollow other users, and block/unblock users.
*   **Real-time Updates:** All data is synchronized in real-time with the Horda backend.

## Architecture

The application is built using Flutter and leverages the Horda Client SDK for its backend communication.

### Backend Connection

The connection to the Horda backend is established in the `main.dart` file. The process involves these steps:

1.  Firebase is initialized for authentication.
2.  A `kUrl` and `kApiKey` are defined in `config.dart` to identify the backend project.
    To connect to a locally hosted server package, clients must use:
    - `"ws://localhost:8080/client"` for local development.
    - `"ws://10.0.2.2:8080/client"` if running on an Android emulator.
3.  An `authProvider` from `auth.dart` is provided for authentication.
4.  The `HordaClientSystem` is initialized directly with the `kUrl`, `kApiKey`, and `authProvider`.
5.  The `system.start()` method is called to initiate the connection.
6.  The root widget of the application is wrapped in a `HordaSystemProvider`, making the client system available to all descendant widgets.

```dart
// In main.dart

// 1. Configuration
final system = HordaClientSystem(
    url: kUrl,
    apiKey: kApiKey,
    authProvider: kAuthService,
  );

// 2. System Initialization
system.start();

// 3. Provider Setup
runApp(HordaSystemProvider(system: system, child: TwitterClient()));
```

### Data Display and Real-time Updates

The application uses `entityQuery` context extension methods from the Horda Client SDK to run queries and subscribe to live data from the server. This ensures that the UI is always up-to-date with the latest information.

Example of `entityQuery` usage in `HomePage` to load the user's timeline:

```dart
// In home/home_page.dart
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
```

Various custom `EntityQuery` classes (defined in `lib/queries.dart`) are used to specify the data views required by different parts of the application. These classes extend `EntityQuery` and define the specific fields and nested queries needed for a particular data view.

---

### Displaying Tweets in a Timeline

The application displays a personalized timeline of tweets. This involves several queries: `UserTimelineQuery` (which contains `TimelineQuery`) to fetch the list of tweet IDs for the timeline, `TweetQuery` which is used as a subquery to fetch the details of each individual tweet, and `BasicUserInfoQuery` (which itself contains `UserNameAndPictureQuery`) for fetching basic user information like handle, display name, and avatar URL.

**`UserTimelineQuery` and `TimelineQuery` Definitions:**
```dart
// In lib/queries.dart
class UserTimelineQuery extends EntityQuery {
  final timeline = EntityRefView('timelineView', query: TimelineQuery());

  @override
  void initViews(EntityQueryGroup views) {
    views.add(timeline);
  }
}

class TimelineQuery extends EntityQuery {
  final tweets = EntityListView<TweetQuery>(
    'timelineTweetsView',
    query: TweetQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views.add(tweets);
  }
}
```

**`TweetQuery` Definition (used as a subquery):**
```dart
// In lib/queries.dart
class TweetQuery extends EntityQuery {
  final authorUser = EntityRefView(
    'tweetAuthorUserView',
    query: BasicUserInfoQuery(),
  );

  final text = EntityValueView<String>(
    'tweetTextView',
  );

  final createdAt = EntityDateTimeView(
    'tweetCreatedAtView',
    isUtc: true,
  );

  final likeCount = EntityCounterView(
    'tweetLikeCountView',
  );

  final retweetCount = EntityCounterView(
    'retweetCountView',
  );

  final commentCount = EntityCounterView(
    'commentCountView',
  );

  final likedByUsers = EntityListView(
    'tweetLikedByUsersView',
    query: BasicUserInfoQuery(),
  );

  final attachmentUrl = EntityValueView<String>(
    'tweetAttachmentUrlView',
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(authorUser)
      ..add(text)
      ..add(createdAt)
      ..add(likeCount)
      ..add(retweetCount)
      ..add(commentCount)
      ..add(likedByUsers)
      ..add(attachmentUrl);
  }
}
```

**`BasicUserInfoQuery` and `UserNameAndPictureQuery` Definitions (used as subqueries within `TweetQuery`):**
```dart
// In lib/queries.dart
class BasicUserInfoQuery extends EntityQuery {
  final handle = EntityValueView<String>('handleView');
  final profile = EntityRefView(
    'profileView',
    query: UserNameAndPictureQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(handle)
      ..add(profile);
  }
}

class UserNameAndPictureQuery extends EntityQuery {
  final displayName = EntityValueView<String>('displayNameView');
  final avatarUrl = EntityValueView<String>('avatarUrlView');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(displayName)
      ..add(avatarUrl);
  }
}
```

**Usage Example (`HomePage`, `HomeViewModel`, `TweetViewModel`, and `AuthorUserViewModel`):**
The `HomePage` runs the `UserTimelineQuery` to get the current user's timeline. The `HomeViewModel` then accesses the list of tweets from this timeline, and for each tweet, a `TweetViewModel` is created, which internally uses the `TweetQuery` to fetch the tweet's details, including the `BasicUserInfoQuery` for the author and users who liked the tweet. The `AuthorUserViewModel` then consumes this `BasicUserInfoQuery` to provide author-specific details.

```dart
// In home/home_page.dart
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
```

```dart
// In home/home_view_model.dart
class HomeViewModel {
  final BuildContext context;

  HomeViewModel(this.context);

  EntityQueryDependencyBuilder<TimelineQuery> get timelineQuery {
    return context.query<UserTimelineQuery>().ref((q) => q.timeline);
  }

  int get tweetsLength {
    return timelineQuery.listLength((q) => q.tweets);
  }

  TweetViewModel getTweet(int index) {
    final tweetQuery = timelineQuery.listItem((q) => q.tweets, index);

    return TweetViewModel(context, tweetQuery);
  }
}
```

```dart
// In shared/tweet_view_model.dart
class TweetViewModel {
  final BuildContext context;
  final EntityQueryDependencyBuilder<TweetQuery> tweetQuery;

  TweetViewModel(this.context, this.tweetQuery);

  String get id {
    return tweetQuery.id();
  }

  AuthorUserViewModel get author {
    return AuthorUserViewModel(
      tweetQuery.ref((q) => q.authorUser),
    );
  }

  String get text {
    return tweetQuery.value((q) => q.text);
  }

  DateTime get createdAt {
    return tweetQuery.value((q) => q.createdAt);
  }

  int get likeCount {
    return tweetQuery.counter((q) => q.likeCount);
  }

  // ... other getters and methods
}
```

```dart
// In shared/author_user_view_model.dart
class AuthorUserViewModel {
  final EntityQueryDependencyBuilder<BasicUserInfoQuery> authorQuery;

  AuthorUserViewModel(this.authorQuery);

  String get id {
    return authorQuery.id();
  }

  String get handle {
    return authorQuery.value((q) => q.handle);
  }

  String get displayName {
    return authorQuery.ref((q) => q.profile).value((q) => q.displayName);
  }

  String get avatarUrl {
    return authorQuery.ref((q) => q.profile).value((q) => q.avatarUrl);
  }
}
```

**Widget Snippet (`TweetCard`):**
The `TweetCard` widget receives a `TweetViewModel` instance, which provides access to the fully hydrated tweet data fetched by the `TweetQuery` subquery, including author information from `BasicUserInfoQuery`.

```dart
// In home/home_page.dart
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

    // ... other widget code

    return Card(
      // ...
      child: Padding(
        // ...
        child: Column(
          // ...
          children: [
            // ...
            Text(
              authorDisplayName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              ' @$authorHandle',
              style: const TextStyle(color: Colors.grey),
            ),
            // ...
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
            // ...
            Text('$likeCount'),
            // ...
            Text('$retweetCount'),
            // ...
            Text('${tweet.commentCount}'),
          ],
        ),
      ),
    );
  }
  // ...
}
```

**Real-time UI Updates:**
The `HomePage` initiates the `UserTimelineQuery`. When the timeline data changes (e.g., new tweets are added or removed), the `HomeViewModel` is updated. For each tweet in the timeline, a `TweetViewModel` is created, which in turn uses `TweetQuery` to fetch and subscribe to the individual tweet's details. This includes fetching author and liked-by-user information via `BasicUserInfoQuery` and `UserNameAndPictureQuery`. Any changes to the tweet's data (e.g., like count, text) or associated user data will automatically trigger a rebuild of the `TweetCard` widget, ensuring the UI reflects the latest information in real-time.

---

### Fetching User Profile Information

To display a user's profile, the `UserAccountQuery` is used to fetch the main account details, and `UserProfileQuery` is used as a subquery to retrieve profile-specific information like display name, avatar, and bio.

**`UserAccountQuery` and `UserProfileQuery` Definitions:**
```dart
// In lib/queries.dart
class UserAccountQuery extends EntityQuery {
  final handle = EntityValueView<String>(
    'handleView',
  );

  final email = EntityValueView<String>(
    'emailView',
  );

  final profile = EntityRefView(
    'profileView',
    query: UserProfileQuery(),
  );

  final followerCount = EntityCounterView(
    'followerCountView',
  );

  final followingCount = EntityCounterView(
    'followingCountView',
  );

  final blockedCount = EntityCounterView(
    'blockedCountView',
  );

  final registeredAt = EntityDateTimeView(
    'registeredAtView',
    isUtc: true,
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(handle)
      ..add(email)
      ..add(profile)
      ..add(followerCount)
      ..add(followingCount)
      ..add(blockedCount)
      ..add(registeredAt);
  }
}

class UserProfileQuery extends EntityQuery {
  final displayName = EntityValueView<String>('displayNameView');
  final avatarUrl = EntityValueView<String>('avatarUrlView');
  final bio = EntityValueView<String>('bioView');

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(displayName)
      ..add(avatarUrl)
      ..add(bio);
  }
}
```

**Usage Example (`ProfilePage` and `ProfileViewModel`):**
The `ProfilePage` runs the `UserAccountQuery` for a given `userId`. The `ProfileViewModel` then accesses the data from both `UserAccountQuery` and its nested `UserProfileQuery`.

```dart
// In profile/profile_page.dart
body: context.entityQuery(
  entityId: widget.userId,
  query: UserAccountQuery(),
  loading: const Center(child: CircularProgressIndicator()),
  error: const Center(child: Text('Failed to load user profile')),
  child: Builder(
    builder: (context) {
      final viewModel = ProfileViewModel(context);
      return _ProfileLoadedView(viewModel: viewModel);
    },
  ),
),
```

```dart
// In profile/profile_view_model.dart
class ProfileViewModel {
  final BuildContext context;

  ProfileViewModel(this.context);

  EntityQueryDependencyBuilder<UserAccountQuery> get userAccountQuery {
    return context.query<UserAccountQuery>();
  }

  EntityQueryDependencyBuilder<UserProfileQuery> get userProfileQuery {
    return userAccountQuery.ref((q) => q.profile);
  }

  String get handle => userAccountQuery.value((q) => q.handle);

  int get followerCount => userAccountQuery.counter((q) => q.followerCount);

  int get followingCount => userAccountQuery.counter((q) => q.followingCount);

  String get displayName => userProfileQuery.value((q) => q.displayName);

  String get avatarUrl => userProfileQuery.value((q) => q.avatarUrl);

  String get bio => userProfileQuery.value((q) => q.bio);

  // ... other getters and methods
}
```

**Widget Snippet (`_ProfileLoadedView`):**
The `_ProfileLoadedView` widget receives a `ProfileViewModel` instance and uses its getters to display the user's profile information.

```dart
// In profile/profile_page.dart
class _ProfileLoadedView extends StatelessWidget {
  final ProfileViewModel viewModel;

  const _ProfileLoadedView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final displayName = viewModel.displayName;
    final bio = viewModel.bio;
    final userHandle = viewModel.handle;
    final followerCount = viewModel.followerCount;
    final followingCount = viewModel.followingCount;
    final registeredAt = viewModel.registeredAt;
    final blockedUsersCount = viewModel.blockedUsersCount;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(viewModel.avatarUrl),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            displayName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '@$userHandle',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          Text(
            bio.isNotEmpty ? bio : 'No bio available.',
            style: bio.isNotEmpty
                ? null
                : const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
          ),
          // ... other widget code
          Text('$followingCount Following'),
          Text('$followerCount Followers'),
          Text('$blockedUsersCount Blocked Users'),
          Text('Joined: ${_formatTimestamp(registeredAt)}'),
        ],
      ),
    );
  }
  // ...
}
```

**Real-time UI Updates:**
The `ProfilePage` initiates the `UserAccountQuery`. When the user's account or profile data changes on the server, the `ProfileViewModel` is updated. The `_ProfileLoadedView` widget, consuming this `ProfileViewModel`, will automatically rebuild to reflect the latest information, ensuring real-time updates to the user's profile display.

---

### Accessing Current User's Data

The `MeQuery` is a special query used to retrieve various pieces of information about the currently authenticated user, such as their blocked users, who they are following, and their own timeline.

**`MeQuery` Definition:**
```dart
/// App-wide query used all over the application, to hide blocked user tweets, etc.
class MeQuery extends EntityQuery {
  final blockedUsers = EntityListView(
    'blockedUsersView',
    query: EmptyQuery(),
  );

  final following = EntityListView(
    'followingView',
    query: EmptyQuery(),
  );

  final followers = EntityListView(
    'followersView',
    query: MyFollowerQuery(),
  );

  final timeline = EntityRefView(
    'timelineView',
    query: EmptyQuery(),
  );

  @override
  void initViews(EntityQueryGroup views) {
    views
      ..add(blockedUsers)
      ..add(following)
      ..add(followers)
      ..add(timeline);
  }
}

// `EmptyQuery` is used to fetch only the entity IDs without running any sub-queries, optimizing performance when only IDs are needed.
```

**Usage Example:**
```dart
// In shared/me_query_shell.dart
    return context.entityQuery(
      entityId: userId,
      query: MeQuery(),
      loading: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: const Scaffold(
        body: Center(
          child: Text('Failed to load user data'),
        ),
      ),
      child: child,
    );
```

**Relevant ViewModel Snippet (from `TweetViewModel`):**
```dart
// In shared/tweet_view_model.dart (example of MeQuery usage in another ViewModel)
class TweetViewModel {
  // ... other fields and methods

  bool get isAuthorBlocked {
    final blockedUsers = context.query<MeQuery>().listItems(
      (q) => q.blockedUsers,
    );
    return blockedUsers.contains(author.id);
  }

  Future<void> retweet() async {
    final myTimelineId = context.query<MeQuery>().refId((q) => q.timeline);

    final followerCount = context.query<MeQuery>().listLength(
      (q) => q.followers,
    );

    // ... rest of the retweet logic
  }
}
```

**Real-time UI Updates:**
The `MeQuery` provides application-wide access to the current user's data. Widgets and ViewModels can access this data using `context.query<MeQuery>()`. For example, the `TweetCard` widget uses `tweet.isAuthorBlocked` to conditionally hide tweets from blocked users. Similarly, the `_ProfileLoadedView` widget uses `viewModel.isFollowing` and `viewModel.isBlocked` to dynamically display "Follow/Unfollow" and "Block/Unblock" buttons. When the `MeQuery` data changes (e.g., the user blocks someone or gains a new follower), any ViewModel or widget querying these values will automatically update, ensuring the UI reflects the latest state of the current user.

```dart
// In home/home_page.dart (inside TweetCard widget)
if (tweet.isAuthorBlocked) {
  return SizedBox.shrink();
}

// In profile/profile_page.dart (inside _ProfileLoadedView widget)
if (viewModel.isNotCurrentUser) ...[
  Row(
    children: [
      TextButton(
        onPressed: viewModel.toggleFollow,
        child: Text(viewModel.isFollowing ? 'Unfollow' : 'Follow'),
      ),
      const SizedBox(width: 8.0),
      TextButton(
        onPressed: viewModel.toggleBlock,
        child: Text(viewModel.isBlocked ? 'Unblock' : 'Block'),
      ),
    ],
  ),
  const SizedBox(height: 8.0),
]
```

### Requesting Server Business Processes

User interactions, such as composing a tweet, following a user, or liking a tweet, are handled by dispatching client events to the Horda backend using `context.runProcess()`. These events trigger corresponding business processes on the server.

For example, sending a tweet:

```dart
// In compose_tweet/compose_tweet_view_model.dart
final result = await context.runProcess(
  ClientCreateTweetRequested(
    authorUserId: context.hordaAuthUserId!,
    text: text,
    attachmentBase64: attachmentBase64,
    timelineIds: [
      myTimelineId,
      ...followerTimelineIds,
    ],
  ),
);
```

