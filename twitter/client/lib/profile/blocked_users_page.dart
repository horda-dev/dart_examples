import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';
import '../shared/author_user_view_model.dart';

class BlockedUsersPage extends StatelessWidget {
  final String userId;

  const BlockedUsersPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Users'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: context.entityQuery(
        entityId: userId,
        query: BlockedUsersQuery(),
        loading: const Center(child: CircularProgressIndicator()),
        error: const Center(child: Text('Failed to load blocked users')),
        child: Builder(
          builder: (context) {
            final blockedUsersLength = context
                .query<BlockedUsersQuery>()
                .listLength((q) => q.blockedUsers);

            if (blockedUsersLength == 0) {
              return const Center(
                child: Text('No blocked users.'),
              );
            }

            return ListView.builder(
              itemCount: blockedUsersLength,
              itemBuilder: (context, index) {
                final blockedUserQuery = context
                    .query<BlockedUsersQuery>()
                    .listItemQuery(
                      (q) => q.blockedUsers,
                      blockedUsersLength - index - 1,
                    );
                final blockedUser = AuthorUserViewModel(blockedUserQuery);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(blockedUser.avatarUrl),
                  ),
                  title: Text(blockedUser.displayName),
                  subtitle: Text('@${blockedUser.handle}'),
                  onTap: () {
                    context.go('/profile/${blockedUser.id}');
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
