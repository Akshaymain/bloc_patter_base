part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangedThemeEvent extends ThemeEvent {
  final int randInt;
  const ChangedThemeEvent({required this.randInt});

  @override
  List<Object> get props => [randInt];

  @override
  String toString() => 'ChangedThemeEvent(randInt: $randInt)';
}
