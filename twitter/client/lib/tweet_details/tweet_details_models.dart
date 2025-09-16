import '../home/home_models.dart'; // For UserProfileItem

class CommentItem {
  final String id;
  final UserProfileItem author;
  final String text;
  final DateTime createdAt;
  final int likeCount;
  final List<CommentItem> replies; // Nested replies

  CommentItem({
    required this.id,
    required this.author,
    required this.text,
    required this.createdAt,
    required this.likeCount,
    required this.replies,
  });
}
