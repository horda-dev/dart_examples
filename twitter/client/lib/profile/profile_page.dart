import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text(bio),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text('$followingCount Following'),
              const SizedBox(width: 16.0),
              Text('$followerCount Followers'),
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
