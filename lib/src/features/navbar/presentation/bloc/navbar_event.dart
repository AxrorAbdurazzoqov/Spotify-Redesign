import 'package:equatable/equatable.dart';

abstract class NavbarEvent extends Equatable {}

class OnNavbarIndexChangedEvent extends NavbarEvent {
  final int index;

  OnNavbarIndexChangedEvent({required this.index});
  @override
  List<Object?> get props => [index];
}
