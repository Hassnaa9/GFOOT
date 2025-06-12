import 'package:flutter/material.dart';
import 'package:graduation_project/Data/local/local_cubit.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc



class SettingViewBody extends StatefulWidget {
  const SettingViewBody({super.key});

  @override
  State<SettingViewBody> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _notificationsEnabled = true;
  bool _darkThemeEnabled = false;
  bool _useMetricUnits = true;

  final String _baseUrl = 'https://yourapi.com/api/settings';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _loadSettings();

    _controller.forward();
  }

  Future<void> _loadSettings() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/get'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _notificationsEnabled = data['notificationsEnabled'] ?? true;
          _darkThemeEnabled = data['darkThemeEnabled'] ?? false;
          _useMetricUnits = data['useMetricUnits'] ?? true;
        });
      } else {
        throw Exception('Failed to load settings');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading settings: $e")), // Kept for error clarity
      );
    }
  }

  Future<void> _saveSettings(String key, bool value) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/update'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({key: value}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to save settings');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving settings: $e")), // Kept for error clarity
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.navSettings, // Localized
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.kPrimaryColor,
            )),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            _buildAnimatedSection(l10n.notificationsSection), // Localized
            _buildAnimatedSwitchTile(
              title: l10n.enablePushNotifications, // Localized
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
                _saveSettings('notificationsEnabled', value);
              },
              icon: Icons.notifications,
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection(l10n.appearanceSection), // Localized
            _buildAnimatedSwitchTile(
              title: l10n.darkTheme, // Localized
              value: _darkThemeEnabled,
              onChanged: (value) {
                setState(() => _darkThemeEnabled = value);
                _saveSettings('darkThemeEnabled', value);
              },
              icon: Icons.brightness_6,
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection(l10n.unitsSection), // Localized
            _buildAnimatedSwitchTile(
              title: l10n.useMetricUnits, // Localized
              subtitle: l10n.useMetricUnitsSubtitle, // Localized
              value: _useMetricUnits,
              onChanged: (value) {
                setState(() => _useMetricUnits = value);
                _saveSettings('useMetricUnits', value);
              },
              icon: Icons.straighten,
            ),
            const SizedBox(height: 20),

            // NEW: Language Toggle Section
            _buildAnimatedSection(l10n.languageSection), // Localized
            _buildAnimatedListTile(
              title: l10n.toggleLanguage, // Localized
              icon: Icons.language,
              onTap: () {
                // Toggle the locale using the LocaleCubit
                context.read<LocaleCubit>().toggleLocale();
              },
            ),
            const SizedBox(height: 20),


            _buildAnimatedSection(l10n.accountSection), // Localized
            _buildAnimatedListTile(
              title: l10n.editProfile, // Localized
              icon: Icons.person,
              onTap: () => Navigator.pushNamed(context, '/Profile'),
            ),
            _buildAnimatedListTile(
              title: l10n.logoutButton, // Localized
              icon: Icons.logout,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/SignIn',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(String title) => FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

  Widget _buildAnimatedSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) => FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            child: ListTile(
              leading: Icon(icon, color: Colors.green),
              title: Text(title, style: const TextStyle(fontSize: 16)),
              subtitle: subtitle != null
                  ? Text(subtitle,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey))
                  : null,
              trailing: Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
            ),
          ),
        ),
      );

  Widget _buildAnimatedListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) => FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: ListTile(
              leading: Icon(icon, color: Colors.green),
              title:
                  Text(title, style: const TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
              onTap: onTap,
            ),
          ),
        ),
      );
}
