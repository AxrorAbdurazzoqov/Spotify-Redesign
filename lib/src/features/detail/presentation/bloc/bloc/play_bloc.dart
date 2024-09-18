import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(const PlayState(status: PlayStatus.initial)) {
    on<PlayEvent>((event, emit) {});
  }
}
