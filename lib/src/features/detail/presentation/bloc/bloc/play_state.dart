part of 'play_bloc.dart';

class PlayState extends Equatable {
  final PlayStatus status;
  const PlayState({required this.status});

  @override
  List<Object> get props => [];
}

enum PlayStatus {
  initial,
  loading,
  success,
  failure
}
