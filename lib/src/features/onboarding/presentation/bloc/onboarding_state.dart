import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int index;
  final List titles = [
    {
      'title': 'Enjoy Listening Music',
      'subtitle': 'Your personalized music journey begins here. Dive into a world of endless possibilities where every track is tailored just for you.'
    },
    {
      'title': 'Discover and Connect',
      'subtitle': 'Follow your favorite artists, stay updated with their latest releases, and connect with the sounds that resonate with you. The world of music is at your fingertips.'
    },
    {
      'title': 'Listen Anytime, Anywhere',
      'subtitle': '"With Stotify, your music is always with you. Download your favorite tracks for offline listening, enjoy high-quality sound, and experience an ad-free environment.'
    },
  ];

  OnboardingState({required this.index});

  @override
  List<Object?> get props => [
        index
      ];
}