import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> with HydratedMixin {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ToggleThemeEvent>(
      (event, emit) {
        emit(state.copyWith(
            appTheme: state.appTheme == AppTheme.light
                ? AppTheme.dark
                : AppTheme.light));
      },
    );
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    print('ThemeState from stroage: $json');
    final themeState = ThemeState.fromJson(json);
    print('themeState: $themeState');
    return themeState;
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    print('ThemeState to storage: $state');
    final themeJson = state.toJson();
    print('themeJson: $themeJson');
    return themeJson;
  }
  // ThemeBloc() : super(ThemeState.initial()) {
  //   on<ChangedThemeEvent>((event, emit) {
  //     if (event.randInt % 2 == 0) {
  //       emit(state.copyWith(appTheme: AppTheme.light));
  //     } else {
  //       emit(state.copyWith(appTheme: AppTheme.dark));
  //     }
  //   });
  // }
}
