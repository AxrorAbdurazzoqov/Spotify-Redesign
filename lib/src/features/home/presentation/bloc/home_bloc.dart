import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/src/features/home/data/model/song_model.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_event.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(status: HomeStatus.initial)) {
    on<GetAllSongs>((event, emit) async {
      try {
        final QuerySnapshot result = await FirebaseFirestore.instance.collection('songs').get();

        final List<SongModel> data = result.docs.map((mp) => SongModel.fromJson(mp.data() as Map<String, dynamic>)).toList();
        emit(HomeState(status: HomeStatus.success, songs: data));
      } catch (e) {
        state.copyWith(status: HomeStatus.failure);
      }
    });
  }
}