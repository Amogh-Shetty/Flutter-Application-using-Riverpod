import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StateProvider<ConnectivityResult>((ref) {
  return ConnectivityResult.none; // Initial connectivity state
});

final uploadedImageUrlProvider = StateProvider<String>((ref) {
  String uploadedImageUrl;
  return 'uploadedImageUrl'; // Initial uploaded image URL
});