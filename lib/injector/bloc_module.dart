import 'package:flutter_flavors_manual/features/home/bloc/home_bloc.dart';
import 'injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    final injector = Injector.instance;

    injector.registerFactory<HomeBloc>(
      () => HomeBloc(
        flavorRepository: injector(),
      ),
    );
  }
}
