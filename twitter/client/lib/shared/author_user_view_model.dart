import 'package:horda_client/horda_client.dart';

import '../queries.dart';

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
