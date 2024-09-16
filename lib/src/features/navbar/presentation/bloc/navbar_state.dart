import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spotify/src/features/home/presentation/page/home_screen.dart';
import 'package:spotify/src/features/profile/presentation/page/profile_screen.dart';

class NavbarState extends Equatable {
  final int currentIndex;
  final List<Widget> screens = [
    const HomeScreen(),
    Container(color: Colors.blueAccent),
    Container(color: Colors.orangeAccent),
    const ProfileScreen(),
  ];

  NavbarState({this.currentIndex = 0});

  @override
  List<Object?> get props => [
        currentIndex
      ];
}
