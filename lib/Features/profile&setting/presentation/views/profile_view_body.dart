import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/profile_menu.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/profile_pic.dart';
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
    // Fetch user profile on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<AuthCubit>().fetchUserProfile();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profile"),
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
                    user.displayName ?? 'N/A',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1A1A1A),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "@${user.userName ?? 'N/A'}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ProfileMenu(
                    text: 'email: ${user.email ?? 'N/A'}',
                    icon: AssetsData.email,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: 'phone: ${user.phoneNumber ?? 'N/A'}',
                    icon: AssetsData.phone,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: 'location: ${[user.city, user.country].where((s) => s != null && s.isNotEmpty).join(', ') ?? 'N/A'}',
                    icon: AssetsData.location,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: "Edit My Account",
                    icon: AssetsData.user,
                    press: () => Navigator.pushNamed(context, "/Account"),
                  ),
                  ProfileMenu(
                    text: "Notifications",
                    icon: AssetsData.bell,
                    press: () => Navigator.pushNamed(context, "/Notifications"),
                  ),
                  ProfileMenu(
                    text: "Settings",
                    icon: AssetsData.settings,
                    press: () => Navigator.pushNamed(context, "/Settings"),
                  ),
                  ProfileMenu(
                    text: "Help Center",
                    icon: AssetsData.questionMark,
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Log Out",
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
                state.errorMessage,
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