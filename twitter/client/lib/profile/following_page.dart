import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import '../shared/author_user_view_model.dart';

class FollowingPage extends StatelessWidget {
  final String userId;

  const FollowingPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: context.entityQuery(
        entityId: userId,
        query: UserFollowingQuery(),
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load following users')),
        child: Builder(
          builder: (context) {
            final followingLength = context
                .query<UserFollowingQuery>()
                .listLength((q) => q.following);

            if (followingLength == 0) {
              return const Center(
                child: Text('Not following anyone yet.'),
              );
            }

            return ListView.builder(
              itemCount: followingLength,
              itemBuilder: (context, index) {
                final followingQuery = context
                    .query<UserFollowingQuery>()
                    .listItem((q) => q.following, index);
                final following = AuthorUserViewModel(followingQuery);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(following.avatarUrl),
                  ),
                  title: Text(following.displayName),
                  subtitle: Text('@${following.handle}'),
                  onTap: () {
                    context.push('/profile/${following.id}');
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
