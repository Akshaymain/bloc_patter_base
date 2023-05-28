part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

// class ChangedCounterEvent extends CounterEvent {
//   final int incrementSize;
//   const ChangedCounterEvent({required this.incrementSize});

//   @override
//   List<Object> get props => [incrementSize];
// }
// class IncrementEvent extends CounterEvent {}

// class DecrementEvent extends CounterEvent {}

class ChangedCounterEvent extends CounterEvent {}
