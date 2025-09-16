import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart'; // For UserAccountQuery
import '../home/home_models.dart'; // For TweetItem, UserProfileItem
import '../home/home_page.dart'; // For TweetCard
import 'profile_view_model.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel(context, widget.userId);
  }

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
        child: _ProfileLoadedView(viewModel: _viewModel),
      ),
    );
  }
}

class _ProfileLoadedView extends StatelessWidget {
  final ProfileViewModel viewModel;

  const _ProfileLoadedView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final userProfile = viewModel.profile;
    final userHandle = viewModel.handle;
    final userEmail = viewModel.email;
    final followerCount = viewModel.followerCount;
    final followingCount = viewModel.followingCount;
    final registeredAt = viewModel.registeredAt;

    return Column(
      children: [
        // Profile Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProfile.displayName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '@$userHandle',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8.0),
              Text(userProfile.bio),
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
        ),
        const Divider(),
        // User's Tweets
        Expanded(
          child: (viewModel.tweetsLength == 0)
              ? const Center(child: Text('No tweets yet.'))
              : ListView.builder(
                  itemCount: viewModel.tweetsLength,
                  itemBuilder: (context, index) {
                    final tweetItem = viewModel.getTweet(index);
                    return TweetCard(tweet: tweetItem);
                  },
                ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
