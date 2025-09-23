import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../auth.dart';
import '../queries.dart';
import 'profile_view_model.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await kAuthService.logout();

              if (!context.mounted) {
                return;
              }

              await context.logout();

              if (!context.mounted) {
                return;
              }

              context.go('/signin');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
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
    );
  }
}

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
          const SizedBox(height: 8.0),
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
          ] else ...[
            // Only show if it's the current user's profile
            TextButton(
              onPressed: () {
                context.push('./edit');
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 8.0),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  context.push('./following');
                },
                child: Text('$followingCount Following'),
              ),
              TextButton(
                onPressed: () {
                  context.push('./followers');
                },
                child: Text('$followerCount Followers'),
              ),
              if (!viewModel
                  .isNotCurrentUser) // Only show if it's the current user's profile
                TextButton(
                  onPressed: () {
                    context.push('./blocked_users');
                  },
                  child: Text('$blockedUsersCount Blocked Users'),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text('Joined: ${_formatTimestamp(registeredAt)}'),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
