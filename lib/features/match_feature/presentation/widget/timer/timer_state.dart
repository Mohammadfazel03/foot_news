part of 'timer_cubit.dart';

class TimerState {
  int counter;

  TimerState(this.counter);

  TimerState copyWith({int? counter}) => TimerState(counter ?? this.counter);
}
