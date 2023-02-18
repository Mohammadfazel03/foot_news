import 'package:bloc/bloc.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerState(0));

  addSecond() {
    emit(state.copyWith(counter: state.counter + 1));
  }

  setSeconds(int counter) {
    emit(state.copyWith(counter: counter));
  }
}
