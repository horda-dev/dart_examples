import 'package:flutter/material.dart';
import 'package:horda_client/horda_client.dart';

import '../queries.dart';

class MeQueryShell extends StatelessWidget {
  const MeQueryShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final userId = context.hordaAuthUserId!;

    return context.entityQuery(
      entityId: userId,
      query: MeQuery(),
      loading: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: const Scaffold(
        body: Center(
          child: Text('Failed to load user data'),
        ),
      ),
      child: child,
    );
  }
}
