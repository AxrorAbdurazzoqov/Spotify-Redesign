import 'package:equatable/equatable.dart';
import 'package:spotify/src/features/home/data/model/song_model.dart';

class HomeState extends Equatable {
  final HomeStatus status;
  final List<SongModel> songs;

  const HomeState({this.songs = const [], required this.status});

  HomeState copyWith({HomeStatus? status, List<SongModel>? songs}) => HomeState(status: status ?? this.status, songs: songs ?? this.songs);

  @override
  List<Object?> get props => [
        songs,
        status,
        HomeStatus.initial,
        HomeStatus.laoding,
        HomeStatus.success,
        HomeStatus.failure,
      ];
}

enum HomeStatus {
  initial,
  laoding,
  success,
  failure
}