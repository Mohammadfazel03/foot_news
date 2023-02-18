part of 'game_details_bloc.dart';

class GameDetailsState {
  late bool isLoading;
  MatchDetailsCollection? response;
  late Queue<String> errors;

  GameDetailsState({
    required this.isLoading,
    required this.response,
    required this.errors,
  });

  factory GameDetailsState.init() {
    return GameDetailsState(isLoading: true, response: null, errors: Queue());
  }

  GameDetailsState copyWith({
    bool? isLoading,
    MatchDetailsCollection? response,
    Queue<String>? errors,
  }) {
    return GameDetailsState(
        isLoading: isLoading ?? this.isLoading,
        response: response ?? this.response,
        errors: errors ?? this.errors);
  }

  Queue<String> errorShown() {
    Queue<String> queue = Queue<String>();
    queue.addAll(errors);
    queue.removeFirst();
    return queue;
  }

  Queue<String> addError(String error) {
    Queue<String> queue = Queue<String>();
    queue.addAll(errors);
    queue.add(error);
    return queue;
  }
}
