import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    debugPrint('DASTURDAN TASHQARIDA ${message.notification!.title}');
  }
}

class NotificationService {
  static NotificationService? _instance;

  NotificationService._internal() {
    _instance = this;
  }

  factory NotificationService() => _instance ?? NotificationService._internal();

  late AndroidNotificationChannel _channel;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // ! Android
  final AndroidInitializationSettings _androidSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  // ! IOS
  final DarwinInitializationSettings _iOSSettings =
      const DarwinInitializationSettings(
    defaultPresentAlert: true,
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    defaultPresentSound: true,
    defaultPresentBadge: true,
  );

  Future init() async {
    await _requestPermission();

    await _loadFCM();

    await _listenFCM();

    await _getToken();
  }

  Future _loadFCM() async {
    if (!kIsWeb) {
      _channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        enableLights: true,
        sound: RawResourceAndroidNotificationSound('sound'),
      );

      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      await _flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
          android: _androidSettings,
          iOS: _iOSSettings,
        ),
      );

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: false,
        sound: true,
      );

      // await FirebaseMessaging.instance
    }
  }

  Future _listenFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen(_handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    messaging.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

    await messaging.subscribeToTopic('topic');
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = notification?.android;
    AppleNotification? apple = notification?.apple;

    if (notification != null && android != null && !kIsWeb) {
      _showNotification(notification);
    } else if (notification != null && apple != null && !kIsWeb) {
      _showNotification(notification);
    }
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    return _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        iOS: const DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          icon: 'launch_background',
          autoCancel: false,
          playSound: true,
          color: Colors.blue
        ),
      ),
    );
  }

  Future _requestPermission() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
      } else {}
    } catch (err) {
      debugPrint('notification_service error $err');
    }
  }

  static Future _getToken() async {
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint('================== token =================');
      debugPrint('token $value');
    });
  }
}
