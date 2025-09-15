class UserProfileItem {
  final String displayName;
  final String bio;
  final int followerCount;
  final int followingCount;

  UserProfileItem({
    required this.displayName,
    required this.bio,
    required this.followerCount,
    required this.followingCount,
  });
}

class TweetItem {
  final String id; // Assuming tweet has an ID
  final UserProfileItem author;
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

class UserAccountItem {
  final String handle;
  final String email;
  final UserProfileItem profile;
  final int followerCount;
  final int followingCount;
  final DateTime registeredAt;
  // No direct list of followers/following or timeline here, as they are accessed via methods

  UserAccountItem({
    required this.handle,
    required this.email,
    required this.profile,
    required this.followerCount,
    required this.followingCount,
    required this.registeredAt,
  });
}
