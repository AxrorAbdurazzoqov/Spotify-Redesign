import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/firebase_options.dart';
import 'package:spotify/src/core/constants/theme/app_theme.dart';
import 'package:spotify/src/core/utils/firebase_notification_service.dart';
import 'package:spotify/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:spotify/src/features/navbar/presentation/bloc/navbar_bloc.dart';
import 'package:spotify/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:spotify/src/features/splash/presentation/page/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingBloc()),
        BlocProvider(create: (context) => NavbarBloc()),
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: const Spotify(),
    ),
  );
}

class Spotify extends StatelessWidget {
  const Spotify({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initial: AdaptiveThemeMode.dark,
      builder: (ligthTheme, darkTheme) {
        return MaterialApp(
          title: 'Spotify',
          theme: ligthTheme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
