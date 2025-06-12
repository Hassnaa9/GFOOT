import 'package:flutter/material.dart';
import 'package:graduation_project/Data/local/local_cubit.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/theme/theme_cubit.dart'; // Import ThemeCubit
import 'package:flutter_bloc/flutter_bloc.dart';

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

  // State variables for settings
  bool _notificationsEnabled = true;
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

    // No need to load darkThemeEnabled from API anymore, Cubit handles it
    // _loadSettings(); // Adjust if you still load other settings from API

    _controller.forward();
  }

  // Removed _loadSettings and _saveSettings for dark mode, as it's now handled by ThemeCubit
  // Keep if you still have other API settings to load/save.
  // For demonstration, I'm keeping the API logic for other settings as-is,
  // but you might want to switch them to local storage (e.g., SharedPreferences)
  // if you truly mean "local memory not API" for all settings.

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context); // Get current theme data
    final themeCubit = context.read<ThemeCubit>(); // Access ThemeCubit

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Use theme background
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor), // Use theme icon color
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.navSettings,
          style: theme.appBarTheme.titleTextStyle, // Use theme title style
        ),
        backgroundColor: theme.appBarTheme.backgroundColor, // Use theme app bar background
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            _buildAnimatedSection(l10n.notificationsSection),
            _buildAnimatedSwitchTile(
              title: l10n.enablePushNotifications,
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
                // _saveSettings('notificationsEnabled', value); // Keep if using API/local storage for this
              },
              icon: Icons.notifications,
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection(l10n.appearanceSection),
            // Use BlocBuilder to react to ThemeCubit's state for the switch value
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                // Determine if 'dark theme enabled' switch should be on.
                // If it's system theme, check current system brightness.
                bool isDarkActive = themeState.themeMode == ThemeMode.dark ||
                                  (themeState.themeMode == ThemeMode.system &&
                                   MediaQuery.of(context).platformBrightness == Brightness.dark);
                return _buildAnimatedSwitchTile(
                  title: l10n.darkTheme,
                  value: isDarkActive,
                  onChanged: (value) {
                    // This toggles between Light and Dark
                    themeCubit.toggleTheme(value);
                  },
                  icon: Icons.brightness_6,
                );
              },
            ),
            // NEW: Add a switch for "Use System Theme"
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return _buildAnimatedSwitchTile(
                  title: l10n.useSystemTheme, // You'll need to add this key to your AppLocalizations
                  value: themeState.themeMode == ThemeMode.system,
                  onChanged: (value) {
                    if (value) {
                      themeCubit.setSystemTheme();
                    } else {
                      // If switching off system theme, set it to the current actual brightness
                      final currentBrightness = MediaQuery.of(context).platformBrightness;
                      themeCubit.toggleTheme(currentBrightness == Brightness.dark);
                    }
                  },
                  icon: Icons.brightness_auto, // Icon for system theme
                );
              },
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection(l10n.unitsSection),
            _buildAnimatedSwitchTile(
              title: l10n.useMetricUnits,
              subtitle: l10n.useMetricUnitsSubtitle,
              value: _useMetricUnits,
              onChanged: (value) {
                setState(() => _useMetricUnits = value);
                // _saveSettings('useMetricUnits', value); // Keep if using API/local storage for this
              },
              icon: Icons.straighten,
            ),
            const SizedBox(height: 20),

            // NEW: Language Toggle Section
            _buildAnimatedSection(l10n.languageSection),
            _buildAnimatedListTile(
              title: l10n.toggleLanguage,
              icon: Icons.language,
              onTap: () {
                context.read<LocaleCubit>().toggleLocale();
              },
            ),
            const SizedBox(height: 20),

            _buildAnimatedSection(l10n.accountSection),
            _buildAnimatedListTile(
              title: l10n.editProfile,
              icon: Icons.person,
              onTap: () => Navigator.pushNamed(context, '/Profile'),
            ),
            _buildAnimatedListTile(
              title: l10n.logoutButton,
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

  Widget _buildAnimatedSection(String title) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onBackground, // Adjust color for theme
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          color: theme.cardTheme.color, // Use theme card color
          shape: theme.cardTheme.shape,
          elevation: theme.cardTheme.elevation,
          child: ListTile(
            leading: Icon(icon, color: theme.listTileTheme.iconColor), // Use theme icon color
            title: Text(title, style: theme.listTileTheme.textColor != null
                ? theme.textTheme.titleMedium?.copyWith(color: theme.listTileTheme.textColor)
                : theme.textTheme.titleMedium,
            ),
            subtitle: subtitle != null
                ? Text(subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.listTileTheme.textColor?.withOpacity(0.7) ?? Colors.grey,
                    ),
                  )
                : null,
            trailing: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: theme.colorScheme.primary, // Use primary color for active switch
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          color: theme.cardTheme.color, // Use theme card color
          shape: theme.cardTheme.shape,
          elevation: theme.cardTheme.elevation,
          child: ListTile(
            leading: Icon(icon, color: theme.listTileTheme.iconColor), // Use theme icon color
            title: Text(title, style: theme.listTileTheme.textColor != null
                ? theme.textTheme.titleMedium?.copyWith(color: theme.listTileTheme.textColor)
                : theme.textTheme.titleMedium,
            ),
            trailing: Icon(Icons.arrow_forward_ios,
                size: 16, color: theme.listTileTheme.iconColor?.withOpacity(0.5) ?? Colors.grey), // Adjust trailing icon color
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}