import 'package:flutter/foundation.dart';
import 'package:flutter_flavors_manual/configs/app_config.dart';
import 'package:rest_client/rest_client.dart';
import 'package:dio/dio.dart';
import 'injector.dart';

class RestClientModule {
  RestClientModule._();

  static void init() {
    final injector = Injector.instance;
    const String dioInstance = 'dioInstance';

    /// Dio
    injector.registerLazySingleton<Dio>(
      () {
        final Dio dio = Dio(
          BaseOptions(
            baseUrl:
                AppConfig.baseUrl,
          ),
        );
        if (!kReleaseMode) {
          dio.interceptors.add(
            LogInterceptor(
              requestHeader: true,
              requestBody: true,
              responseHeader: true,
              responseBody: true,
              request: false,
            ),
          );
        }
        return dio;
      },
      instanceName: dioInstance,
    );

    injector.registerFactory<FlavorApiClient>(
      () => FlavorApiClient(
        injector(instanceName: dioInstance),
      ),
    );
  }
}
