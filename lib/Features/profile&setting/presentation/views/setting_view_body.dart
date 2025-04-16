import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        SnackBar(content: Text("Error loading settings: $e")),
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
        SnackBar(content: Text("Error saving settings: $e")),
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            _buildAnimatedSection("Notifications"),
            _buildAnimatedSwitchTile(
              title: "Enable Push Notifications",
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
                _saveSettings('notificationsEnabled', value);
              },
              icon: Icons.notifications,
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection("Appearance"),
            _buildAnimatedSwitchTile(
              title: "Dark Theme",
              value: _darkThemeEnabled,
              onChanged: (value) {
                setState(() => _darkThemeEnabled = value);
                _saveSettings('darkThemeEnabled', value);
              },
              icon: Icons.brightness_6,
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection("Units"),
            _buildAnimatedSwitchTile(
              title: "Use Metric Units (kg CO2)",
              subtitle: "Switch to imperial units (lbs CO2) if disabled",
              value: _useMetricUnits,
              onChanged: (value) {
                setState(() => _useMetricUnits = value);
                _saveSettings('useMetricUnits', value);
              },
              icon: Icons.straighten,
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection("Account"),
            _buildAnimatedListTile(
              title: "Edit Profile",
              icon: Icons.person,
              onTap: () => Navigator.pushNamed(context, '/Profile'),
            ),
            _buildAnimatedListTile(
              title: "Logout",
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
