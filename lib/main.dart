import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/material_service.dart';
import 'services/process_service.dart';
import 'services/consumption_log_service.dart';
import 'models/user.dart';
import 'models/material.dart';
import 'models/process.dart';
import 'models/consumption_log.dart';
import 'constants/app_constants.dart';
import 'constants/theme_constants.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/material_list_screen.dart';
import 'screens/process_list_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/consumption_log_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<MaterialService>(create: (_) => MaterialService()),
        Provider<ProcessService>(create: (_) => ProcessService()),
        Provider<ConsumptionLogService>(create: (_) => ConsumptionLogService()),
      ],
      child: MaterialApp(
        title: 'SmartFab Material Tracking',
        theme: ThemeConstants.lightTheme,
        initialRoute: AppConstants.loginRoute,
        routes: {
          AppConstants.loginRoute: (context) => const LoginScreen(),
          AppConstants.homeRoute: (context) => const HomeScreen(),
          AppConstants.materialListRoute: (context) =>
              const MaterialListScreen(),
          AppConstants.processListRoute: (context) => const ProcessListScreen(),
          AppConstants.scanRoute: (context) => const ScanScreen(),
          AppConstants.consumptionLogRoute: (context) =>
              const ConsumptionLogScreen(),
          AppConstants.analyticsRoute: (context) => const AnalyticsScreen(),
          AppConstants.settingsRoute: (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
