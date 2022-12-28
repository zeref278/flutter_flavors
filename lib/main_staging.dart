import 'dart:async';

import 'package:flutter/material.dart';

import 'configs/app_config.dart';
import 'injector/injector.dart';
import 'my_app.dart';

Future<void> main() async {
  await runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      AppConfig.configTest();
      Injector.init();
      runApp(const MyApp());
    },
        (error, stack) {},
  );
}
