class AppConstants {
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String materialsCollection = 'materials';
  static const String processesCollection = 'processes';
  static const String consumptionLogsCollection = 'consumption_logs';

  // Hive Box Names
  static const String userBox = 'user_box';
  static const String materialsBox = 'materials_box';
  static const String processesBox = 'processes_box';
  static const String consumptionLogsBox = 'consumption_logs_box';
  static const String settingsBox = 'settings_box';

  // App Settings
  static const String defaultMargin = 'default_margin';
  static const String lowStockThreshold = 'low_stock_threshold';

  // Routes
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String materialListRoute = '/materials';
  static const String processListRoute = '/processes';
  static const String scanRoute = '/scan';
  static const String consumptionLogRoute = '/consumption-log';
  static const String analyticsRoute = '/analytics';
  static const String settingsRoute = '/settings';

  // Error Messages
  static const String networkError =
      'Network error. Please check your connection.';
  static const String authError = 'Authentication error. Please try again.';
  static const String syncError = 'Error syncing data. Please try again.';
  static const String scanError = 'Error scanning barcode. Please try again.';
  static const String insufficientStock = 'Insufficient stock available.';
}
