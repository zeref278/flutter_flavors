import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'crashlytics_service.dart';

class FirebaseCrashlyticsService implements CrashlyticsService {
  @override
  Future<void> init() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      Zone.current.handleUncaughtError(
        errorDetails.exception,
        errorDetails.stack!,
      );
    };
  }

  @override
  Future<void> recordException(exception, StackTrace? stack) async {
    await FirebaseCrashlytics.instance.recordError(
      exception,
      stack,
      printDetails: false,
    );
  }
}
