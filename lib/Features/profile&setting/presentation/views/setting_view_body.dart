import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carbon Footprint App',
      theme: ThemeData.light(), // Default light theme
      darkTheme: ThemeData.dark(), // Default dark theme
      themeMode: ThemeMode.system, // Default to system theme
      home: SettingViewBody(),
      routes: {
        '/edit_profile': (context) => Scaffold(
              appBar: AppBar(title: Text('Edit Profile')),
              body: Center(child: Text('Edit Profile Screen')),
            ),
        '/SignIn': (context) => Scaffold(
              appBar: AppBar(title: Text('Sign In')),
              body: Center(child: Text('Sign In Screen')),
            ),
      },
    );
  }
}

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

  // Settings state
  bool _notificationsEnabled = true;
  bool _darkThemeEnabled = false;
  bool _useMetricUnits = true;

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

    // Load saved settings
    _loadSettings();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //   setState(() {
    //     _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    //     _darkThemeEnabled = prefs.getBool('darkThemeEnabled') ?? false;
    //     _useMetricUnits = prefs.getBool('useMetricUnits') ?? true;
    //   });
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Error loading settings: $e")),
    //   );
    //   setState(() {
    //     _notificationsEnabled = true;
    //     _darkThemeEnabled = false;
    //     _useMetricUnits = true;
    //   });
    // }
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings(String key, bool value) async {
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setBool(key, value);
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Error saving settings: $e")),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            // Notification Settings
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSectionTitle("Notifications"),
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSwitchTile(
                  title: "Enable Push Notifications",
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    _saveSettings('notificationsEnabled', value);
                  },
                  icon: Icons.notifications,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Theme Preferences
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSectionTitle("Appearance"),
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSwitchTile(
                  title: "Dark Theme",
                  value: _darkThemeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkThemeEnabled = value;
                    });
                    _saveSettings('darkThemeEnabled', value);
                    // Note: Theme change needs to be handled at a higher level (e.g., in MyApp)
                  },
                  icon: Icons.brightness_6,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Unit Preferences
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSectionTitle("Units"),
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSwitchTile(
                  title: "Use Metric Units (kg CO2)",
                  subtitle: "Switch to imperial units (lbs CO2) if disabled",
                  value: _useMetricUnits,
                  onChanged: (value) {
                    setState(() {
                      _useMetricUnits = value;
                    });
                    _saveSettings('useMetricUnits', value);
                  },
                  icon: Icons.straighten,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Account Options
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSectionTitle("Account"),
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildListTile(
                  title: "Edit Profile",
                  icon: Icons.person,
                  onTap: () {
                    Navigator.pushNamed(context, '/Profile');
                  },
                ),
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildListTile(
                  title: "Logout",
                  icon: Icons.logout,
                  onTap: () {
                    print("Logging out...");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/SignIn',
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            : null,
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}