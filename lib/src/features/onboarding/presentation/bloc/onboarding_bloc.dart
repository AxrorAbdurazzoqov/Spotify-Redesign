import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:spotify/src/features/onboarding/presentation/bloc/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState(index: 0)) {
    on<OnNextEvent>(
      (event, emit) {
        if (event.index < 3) {
          emit(OnboardingState(index: event.index));
        }
      },
    );
  }
}
