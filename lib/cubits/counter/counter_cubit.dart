import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.inital());
  void incrementCounter() {
    emit(CounterState(counter: state.counter + 1));
  }

  ///-- Bloc to bloc communication using stream subscription and bloc listener --///

  // void changeCounter({required int incrementSize}) {
  //   emit(CounterState(counter: state.counter + incrementSize));
  // }

  /// --- Cubit to cubit communication using stream subscription -- ///
  // int incrementSize = 1;
  // final ColorCubit colorCubit;
  // late final StreamSubscription colorSubscription;

  // CounterCubit({required this.colorCubit}) : super(CounterState.inital()) {
  //   colorSubscription = colorCubit.stream.listen((ColorState colorState) {
  //     if (colorState.color == Colors.red) {
  //       incrementSize = 1;
  //     } else if (colorState.color == Colors.green) {
  //       incrementSize = 10;
  //     } else if (colorState.color == Colors.blue) {
  //       incrementSize = 100;
  //     } else if (colorState.color == Colors.black) {
  //       emit(state.copyWith(counter: state.counter - 100));
  //       incrementSize = -100;
  //     }
  //   });
  // }

  // void changeCounter() {
  //   emit(state.copyWith(counter: state.counter + incrementSize));
  // }

  // @override
  // Future<void> close() {
  //   colorSubscription.cancel();
  //   return super.close();
  // }

  // -- Increment Decrement counter -- //
  // void increment() {
  //   emit(state.copyWith(counter: state.counter + 1));
  // }

  // void decrement() {
  //   emit(state.copyWith(counter: state.counter - 1));
  // }
}
