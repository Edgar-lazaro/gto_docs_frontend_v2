import 'package:flutter/foundation.dart';

class DebugDetector {
  static bool isDebugging() {
    if (!kReleaseMode) return false;

    return false;
  }
}