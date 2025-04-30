import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../constants/app_constants.dart';
import '../constants/theme_constants.dart';
import '../models/user.dart' as app_user;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  app_user.User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = await authService.getCurrentUser();
    if (mounted) {
      setState(() => _currentUser = user);
    }
  }

  Future<void> _signOut() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartFab Material Tracking'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _signOut),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          if (_currentUser!.role == app_user.UserRole.admin) ...[
            _buildMenuCard(
              icon: Icons.inventory,
              title: 'Materials',
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    AppConstants.materialListRoute,
                  ),
            ),
            _buildMenuCard(
              icon: Icons.build,
              title: 'Processes',
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    AppConstants.processListRoute,
                  ),
            ),
            _buildMenuCard(
              icon: Icons.analytics,
              title: 'Analytics',
              onTap:
                  () =>
                      Navigator.pushNamed(context, AppConstants.analyticsRoute),
            ),
            _buildMenuCard(
              icon: Icons.settings,
              title: 'Settings',
              onTap:
                  () =>
                      Navigator.pushNamed(context, AppConstants.settingsRoute),
            ),
          ],
          if (_currentUser!.role == app_user.UserRole.operator) ...[
            _buildMenuCard(
              icon: Icons.qr_code_scanner,
              title: 'Scan Material',
              onTap: () => Navigator.pushNamed(context, AppConstants.scanRoute),
            ),
            _buildMenuCard(
              icon: Icons.history,
              title: 'Consumption Logs',
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    AppConstants.consumptionLogRoute,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: ThemeConstants.primaryColor),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
