import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Helper class for compressing images picked from the device.
class ImageCompressionHelper {
  /// Compresses image bytes to reduce size while maintaining quality.
  ///
  /// Uses medium quality (75%) compression for a balance between file size
  /// and image quality.
  ///
  /// Returns the compressed image bytes.
  static Future<Uint8List> compressImage(Uint8List imageBytes) async {
    try {
      // Compress the image with medium quality (75%)
      final compressedBytes = await FlutterImageCompress.compressWithList(
        imageBytes,
        quality: 75,
      );

      // Return compressed bytes if compression succeeded, otherwise throw
      if (compressedBytes.isNotEmpty) {
        return Uint8List.fromList(compressedBytes);
      }

      throw Exception('Image compression failed: compressed bytes are empty');
    } catch (e) {
      // Re-throw the exception to let the caller handle it
      rethrow;
    }
  }
}
