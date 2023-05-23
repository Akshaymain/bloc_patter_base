import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementEvent>((event, emit) {
      emit(CounterState(counter: state.counter + 1));
    });

    on<DecrementEvent>(_decrementEvent);
  }

  void _decrementEvent(DecrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(counter: state.counter - 1));
  }
}
