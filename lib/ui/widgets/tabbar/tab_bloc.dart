import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:foot_news/ui/theme/theme_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart' as intl;

part 'tab_event.dart';

part 'tab_state.dart';

part 'tab_bloc.freezed.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState.init()) {
    on<TabEvent>((event, emit) {
      emit(state.addItem(event.addToEnd, event.currentPosition));
    });
  }
}
