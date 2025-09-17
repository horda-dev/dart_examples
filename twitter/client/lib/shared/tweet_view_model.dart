import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import 'author_user_view_model.dart';

class TweetViewModel {
  final EntityQueryDependencyBuilder<TweetQuery> tweetQuery;

  TweetViewModel(this.tweetQuery);

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

  int get retweetCount {
    return tweetQuery.counter((q) => q.retweetCount);
  }
}
