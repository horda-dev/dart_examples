# Twitter Example Backend

## Overview

A Horda server application that powers a Twitter-like social media platform. This project demonstrates the use of Horda Server SDK concepts including Entities, Processes, and Services to manage user accounts, tweets, social interactions, and media content in a stateful, serverless backend environment.

You can view the Twitter example in the [Horda Console](https://console.horda.dev/?project=d368c1sgc98s738ue7cg).

## Local Development

This server package has a development dependency on the `horda_local_host` package. This allows you to run the build runner to generate a `main.dart` file and run the server package locally.

To connect to the locally hosted server package, clients must use:
- `"ws://localhost:8080/client"` for local development.
- `"ws://10.0.2.2:8080/client"` if running on an Android emulator.

## Key Concepts

### Processes

Processes define the business logic and orchestrate interactions between different entities and services based on client requests. They are located in `lib/src/client/processes/`.

**Process Request Events:**
*   `ClientRegisterUserRequested`: Handles user registration, including profile picture upload and account creation.
*   `ClientCreateTweetRequested`: Manages tweet creation, content moderation, attachment upload, and distribution to timelines.
*   `ClientCreateCommentRequested`: Handles comment creation, content moderation, and linking to parent tweets/comments.
*   `ClientToggleTweetLikeRequested`: Toggles the like status of a tweet.
*   `ClientRetweetRequested`: Handles retweeting a tweet and distributing it to relevant timelines.
*   `ClientToggleUserFollowRequested`: Toggles the follow status between users.
*   `ClientToggleUserBlockRequested`: Toggles the block status between users.
*   `ClientUpdateUserProfileRequested`: Updates user profile information, including display name, bio, and avatar.
*   `ClientToggleCommentLikeRequested`: Toggles the like status of a comment.


### Entities

Entities represent the core data models of the application, managing their own state and reacting to commands and events. They are located in `lib/src/entities/`.

*   **UserAccountEntity** (`lib/src/entities/user_account_entity/`)
    *   Manages user handles, emails, and references to their profile and timeline.
    *   **Commands:** `CreateUserAccount`, `ToggleFollower`, `ToggleFollowing`, `ToggleUserBlock`.
    *   **Views:** `handleView`, `emailView`, `profileView`, `timelineView`, `followingView`, `followersView`, `blockedUsersView`, `followerCountView`, `followingCountView`, `blockedCountView`, `registeredAtView`.

*   **UserProfileEntity** (`lib/src/entities/user_profile_entity/`)
    *   Stores detailed user profile information like display name, avatar URL, and bio.
    *   **Commands:** `CreateUserProfile`, `UpdateProfilePictureUrl`, `UpdateUserProfile`.
    *   **Views:** `accountView`, `displayNameView`, `avatarUrlView`, `bioView`, `userProfileUpdatedAtView`.

*   **TweetEntity** (`lib/src/entities/tweet_entity/`)
    *   Represents a single tweet, its content, and associated interactions.
    *   **Commands:** `CreateTweet`, `ToggleTweetLike`, `RetweetTweet`, `AddTweetComment`.
    *   **Views:** `tweetAuthorUserView`, `tweetTextView`, `tweetAttachmentUrlView`, `tweetLikeCountView`, `retweetCountView`, `commentCountView`, `tweetCreatedAtView`, `tweetLikedByUsersView`, `retweetedByUsersView`, `commentsView`.

*   **CommentEntity** (`lib/src/entities/comment_entity/`)
    *   Represents a comment on a tweet or another comment.
    *   **Commands:** `CreateComment`, `ToggleCommentLike`, `AddCommentReply`.
    *   **Views:** `commentAuthorUserView`, `commentTextView`, `commentLikeCountView`, `commentCreatedAtView`, `commentLikedByUsersView`, `repliesView`, `parentTweetView`, `parentCommentView`.

*   **TimelineEntity** (`lib/src/entities/timeline_entity/`)
    *   Manages a chronological list of tweets for a specific user.
    *   **Commands:** `CreateTimeline`, `AddTweetToTimeline`.
    *   **Views:** `timelineTweetsView`, `ownerUserView`, `timelineUpdatedAtView`.

*   **ExploreFeedEntity** (`lib/src/entities/explore_feed_entity/`)
    *   A global entity that holds a list of tweets for the explore feed.
    *   **Commands:** `CreateExploreFeed`, `AddTweetToExploreFeed`.
    *   **Views:** `exploreFeedTweetsView`, `exploreFeedUpdatedAtView`.

### Services

Services handle external integrations or cross-cutting concerns that are not directly tied to a single entity's state. They are located in `lib/src/services/`.

*   **ContentModerationService** (`lib/src/services/content_moderation_service/`)
    *   Validates text content for inappropriate material.
    *   **Commands:** `ModerateText`.

*   **NotificationService** (`lib/src/services/notification_service/`)
    *   Handles sending various notifications to users.
    *   **Commands:** `SendPushNotification`, `SendUserRegistrationEmail`.

*   **MediaStoreService** (`lib/src/services/user_profile_picture_service/`)
    *   Manages the upload and removal of media files (profile pictures, tweet attachments) to Google Cloud Storage.
    *   **Commands:** `UploadProfilePicture`, `RemoveProfilePicture`, `UploadTweetAttachment`.

