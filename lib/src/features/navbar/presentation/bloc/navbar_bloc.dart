import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/src/features/navbar/presentation/bloc/navbar_event.dart';
import 'package:spotify/src/features/navbar/presentation/bloc/navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarState()) {
    on<OnNavbarIndexChangedEvent>(
      (event, emit) {
        emit(NavbarState(currentIndex: event.index));
      },
    );
  }
}
