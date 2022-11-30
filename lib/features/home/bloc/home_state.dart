part of 'home_bloc.dart';

@Freezed()
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(UIStatus.initial) UIStatus status,
    String? errorMessage,
    String? successMessage,
  }) = _HomeState;
}

enum UIStatus {
  initial,
  loading,
  loadSuccess,
  loadFailed,
}

extension UIStatusExtension on UIStatus {
  Widget when({
    Widget Function()? onInitial,
    required Widget Function() onLoading,
    required Widget Function() onLoadFailed,
    required Widget Function() onLoadSuccess,
  }) {
    switch (this) {
      case UIStatus.initial:
        return onInitial?.call() ?? onLoading();
      case UIStatus.loading:
        return onLoading();
      case UIStatus.loadFailed:
        return onLoadFailed();
      case UIStatus.loadSuccess:
        return onLoadSuccess();

      default:
        return onLoading();
    }
  }
}
