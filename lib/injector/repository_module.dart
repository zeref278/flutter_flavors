
import 'package:flutter_flavors_manual/data/repositories/flavor_repository/flavor_repository.dart';
import 'package:flutter_flavors_manual/data/repositories/flavor_repository/flavor_repository_impl.dart';

import 'injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    final injector = Injector.instance;

    injector.registerFactory<FlavorRepository>(
      () => FlavorRepositoryImpl(
        flavorApiClient: injector(),
      ),
    );
  }
}
