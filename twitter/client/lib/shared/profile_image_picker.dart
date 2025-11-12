import 'dart:io';

import 'package:flutter/material.dart';

/// A reusable widget for picking profile images with clear visual feedback.
///
/// Shows a circular avatar with a camera icon badge overlay to indicate
/// it can be tapped to change the image.
class ProfileImagePicker extends StatefulWidget {
  /// The selected image file, if any.
  final File? selectedImage;

  /// The URL of the existing avatar image (for edit profile scenarios).
  final String? existingAvatarUrl;

  /// Callback when the avatar is tapped.
  final VoidCallback onTap;

  /// The radius of the avatar circle.
  final double radius;

  const ProfileImagePicker({
    super.key,
    required this.onTap,
    this.selectedImage,
    this.existingAvatarUrl,
    this.radius = 60,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Stack(
        children: [
          // Main avatar
          CircleAvatar(
            radius: widget.radius,
            backgroundColor: Colors.grey[200],
            backgroundImage: _getImageProvider(),
            child: _shouldShowCameraIcon()
                ? Icon(
                    Icons.camera_alt,
                    size: widget.radius * 0.67,
                    color: Colors.grey[800],
                  )
                : null,
          ),

          // Tap feedback overlay
          if (_isPressed)
            Container(
              width: widget.radius * 2,
              height: widget.radius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),

          // Edit icon badge (always visible)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(
                Icons.edit,
                size: widget.radius * 0.33,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Determines which image provider to use based on available data.
  ImageProvider? _getImageProvider() {
    if (widget.selectedImage != null) {
      return FileImage(widget.selectedImage!);
    } else if (widget.existingAvatarUrl != null &&
        widget.existingAvatarUrl!.isNotEmpty) {
      return NetworkImage(widget.existingAvatarUrl!);
    }
    return null;
  }

  /// Shows the camera icon in the center only when there's no image.
  bool _shouldShowCameraIcon() {
    return widget.selectedImage == null &&
        (widget.existingAvatarUrl == null || widget.existingAvatarUrl!.isEmpty);
  }
}
