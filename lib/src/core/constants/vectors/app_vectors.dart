class AppVectors {
  static final AppVectors _instance = AppVectors.init();
  static AppVectors get instance => _instance;
  AppVectors.init();

  final String spotifyLogo = 'assets/icons/spotify_logo.svg';
  final String google = 'assets/icons/google.svg';

  final String sunSelected = 'assets/icons/sun_selected.svg';
  final String moonSelected = 'assets/icons/moon_selected.svg';

  //! background images
  final String backgroundImage1 = 'assets/images/background_image1.png';
  final String backgroundImage2 = 'assets/images/background_image2.png';
  final String pattern = 'assets/icons/pattern.svg';

  //! Navbar icons
  final String home = 'assets/icons/home.svg';
  final String search = 'assets/icons/search.svg';
  final String liked = 'assets/icons/liked.svg';
  final String profile = 'assets/icons/profile.svg';

  //! Icons
  final String play = 'assets/icons/play.svg';
  final String shuffle = 'assets/icons/shuffle.svg';
  final String repeat = 'assets/icons/repeat.svg';
  final String next = 'assets/icons/next.svg';
  final String previous = 'assets/icons/previous.svg';
}
