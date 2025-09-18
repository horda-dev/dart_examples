import 'dart:io';
import 'dart:typed_data';

import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

final kGoogleCloud = GoogleCloudService();

class GoogleCloudService {
  Future<void> _init() async {
    final jsonCredentials = File('service-account.json').readAsStringSync();

    final credentials = auth.ServiceAccountCredentials.fromJson(
      jsonCredentials,
    );

    final scopes = [
      ...Storage.SCOPES,
    ];

    final client = await auth.clientViaServiceAccount(credentials, scopes);

    _storage = Storage(client, 'example-twitter');
  }

  Future<String> saveToResizedBucket({
    required String fileName,
    required String contentType,
    required Uint8List imageBytes,
  }) async {
    if (_storage == null) {
      await _init();
    }

    // At this point storage should always be initialized.
    final storage = _storage!;

    final bucket = storage.bucket(_bucketName);
    await bucket.writeBytes(fileName, imageBytes, contentType: contentType);

    final url = _getImageUrl(_bucketName, fileName);
    return url;
  }

  String _getImageUrl(String bucketName, String fileName) {
    final uriEncodedFileName = Uri.encodeComponent(fileName);
    return 'https://firebasestorage.googleapis.com/v0/b/$bucketName/o/$uriEncodedFileName?alt=media';
  }

  Storage? _storage;

  String get _bucketName => 'example-twitter.firebasestorage.app';
}
