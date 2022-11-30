import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_manual/data/repositories/flavor_repository/flavor_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required FlavorRepository flavorRepository,
  }) : super(const HomeState()) {
    _flavorRepository = flavorRepository;
    on<HomeLoaded>(_onLoaded);
  }

  late final FlavorRepository _flavorRepository;

  FutureOr<void> _onLoaded(
    HomeLoaded event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: UIStatus.loading,
      ));

      final String flavor = await _flavorRepository.getFlavor();

      emit(state.copyWith(
        status: UIStatus.loadSuccess,
        successMessage: flavor,
      ));
    } catch (e, s) {
      emit(state.copyWith(
        status: UIStatus.loadFailed,
        errorMessage: e.toString(),
      ));
    }
  }
}
