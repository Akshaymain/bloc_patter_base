import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_pattern_base/blocs/color/color_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(CounterState.initial()) {
//     on<ChangedCounterEvent>(
//       (event, emit) {
//         emit(state.copyWith(counter: state.counter + event.incrementSize));
//       },
//     );
//   }
// }
  ///-- Bloc to bloc using stream subscription --///
// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   int incrementSize = 1;
//   final ColorBloc colorBloc;
//   late final StreamSubscription colorSubscription;
//   CounterBloc({required this.colorBloc}) : super(CounterState.initial()) {
//     colorSubscription = colorBloc.stream.listen((ColorState colorState) {
//       if (colorState.color == Colors.red) {
//         incrementSize = 1;
//       } else if (colorState.color == Colors.green) {
//         incrementSize = 10;
//       } else if (colorState.color == Colors.blue) {
//         incrementSize = 100;
//       } else if (colorState.color == Colors.black) {
//         add(ChangedCounterEvent());
//         incrementSize = -100;
//       }
//     });
//     on<ChangedCounterEvent>(
//       (event, emit) {
//         emit(state.copyWith(counter: state.counter + incrementSize));
//       },
//     );
//   }

//   @override
//   Future<void> close() {
//     colorSubscription.cancel();
//     return super.close();
//   }
// }
  // CounterBloc() : super(CounterState.initial()) {
  //   on<IncrementEvent>((event, emit) {
  //     emit(CounterState(counter: state.counter + 1));
  //   });

  //   on<DecrementEvent>(_decrementEvent);
  // }

  // void _decrementEvent(DecrementEvent event, Emitter<CounterState> emit) {
  //   emit(CounterState(counter: state.counter - 1));
  // }

  CounterBloc() : super(CounterState.initial()) {
    // on<IncrementEvent>(_handleIncrementCounterEvent, transformer: sequential());
    // on<DecrementEvent>(_handleDecrementCounterEvent, transformer: sequential());

    on<CounterEvent>((event, emit) async {
      if (event is IncrementEvent) {
        await _handleIncrementCounterEvent(event, emit);
      } else if (event is DecrementEvent) {
        await _handleDecrementCounterEvent(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _handleIncrementCounterEvent(
      IncrementEvent event, Emitter<CounterState> emit) async {
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _handleDecrementCounterEvent(
      DecrementEvent event, Emitter<CounterState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(counter: state.counter - 1));
  }
}
