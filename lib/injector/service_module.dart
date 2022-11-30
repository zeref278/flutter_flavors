import 'package:flutter_flavors_manual/services/crashlytics_service/crashlytics_service.dart';
import 'package:flutter_flavors_manual/services/crashlytics_service/firebase_crashlytics_service.dart';

import 'injector.dart';

class ServiceModule {
  ServiceModule._();

  static void init() {
    final injector = Injector.instance;

    injector.registerSingletonAsync<CrashlyticsService>(() async {
      final CrashlyticsService service = FirebaseCrashlyticsService();
      await service.init();
      return service;
    }, signalsReady: true);
  }
}
