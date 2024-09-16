import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {}

class OnNextEvent extends OnboardingEvent {
  final int index;

  OnNextEvent({required this.index});

  @override
  List<Object?> get props => [
        index
      ];
}
