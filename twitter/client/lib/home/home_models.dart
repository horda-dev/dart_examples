class UserProfileItem {
  final String displayName;
  final String bio;

  UserProfileItem({required this.displayName, required this.bio});
}

class TweetItem {
  final String id;
  final TweetAuthorItem author;
  final String text;
  final DateTime createdAt;
  final int likeCount;
  final int retweetCount;

  TweetItem({
    required this.id,
    required this.author,
    required this.text,
    required this.createdAt,
    required this.likeCount,
    required this.retweetCount,
  });
}

class TweetAuthorItem {
  final String id;
  final String handle;
  final String displayName;

  TweetAuthorItem({
    required this.id,
    required this.handle,
    required this.displayName,
  });
}

class UserAccountItem {
  final String id;
  final String handle;
  final String email;
  final UserProfileItem profile;
  final int followerCount;
  final int followingCount;
  final DateTime registeredAt;

  UserAccountItem({
    required this.id,
    required this.handle,
    required this.email,
    required this.profile,
    required this.followerCount,
    required this.followingCount,
    required this.registeredAt,
  });
}
