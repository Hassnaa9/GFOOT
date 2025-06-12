import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/profile_menu.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/profile_pic.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/main.dart'; // For routeObserver


class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // Trigger profile refresh when returning to this screen
    context.read<AuthCubit>().fetchUserProfile();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;
    // Fetch user profile on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AuthCubit>().fetchUserProfile();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(l10n.profileTitle), // Localized
      ),
      body: BlocBuilder<AuthCubit, UserState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: MyColors.kPrimaryColor),
            );
          } else if (state is UserProfileLoaded) {
            final user = state.user;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfilePic(),
                  Text(
                    user.displayName ?? l10n.notAvailable, // Localized
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1A1A1A),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "@${user.userName ?? l10n.notAvailable}", // Localized
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ProfileMenu(
                    text: '${l10n.emailPrefix}: ${user.email ?? l10n.notAvailable}', // Localized
                    icon: AssetsData.email,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: '${l10n.phonePrefix}: ${user.phoneNumber ?? l10n.notAvailable}', // Localized
                    icon: AssetsData.phone,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: '${l10n.locationPrefix}: ${[user.city, user.country].where((s) => s != null && s.isNotEmpty).join(', ') ?? l10n.notAvailable}', // Localized
                    icon: AssetsData.location,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: l10n.editMyAccount, // Localized
                    icon: AssetsData.user,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: l10n.notificationsTitle, // Localized
                    icon: AssetsData.bell,
                    press: () => Navigator.pushNamed(context, "/Notifications"),
                  ),
                  ProfileMenu(
                    text: l10n.navSettings, // Already localized in navSettings
                    icon: AssetsData.settings,
                    press: () => Navigator.pushNamed(context, "/Settings"),
                  ),
                  ProfileMenu(
                    text: l10n.helpCenter, // Localized
                    icon: AssetsData.questionMark,
                    press: () {},
                  ),
                  ProfileMenu(
                    text: l10n.logoutButton, // Localized
                    icon: AssetsData.logout,
                    press: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/SignIn',
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is UserProfileError) {
            return Center(
              child: Text(
                state.errorMessage, // Error message from cubit, should be localized at cubit level if possible
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
