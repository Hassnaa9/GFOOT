import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/home.dart';
import 'package:graduation_project/Features/home/learn.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/profile&setting/profile.dart';
import 'package:graduation_project/Features/profile&setting/setting.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/main.dart';

class AppScaffold extends StatefulWidget {
  final int initialIndex;
  final Map<String, dynamic>? userAnswers;

  const AppScaffold({super.key, this.initialIndex = 0, this.userAnswers});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> with RouteAware {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    // Fetch carbon footprint on initial load if on Home screen
    if (_selectedIndex == 0) {
      context.read<HomeCubit>().getCarbonFootprint();
      if (widget.userAnswers?.isNotEmpty ?? false) {
        context.read<HomeCubit>().logActivity(queryParameters: widget.userAnswers!);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // Refresh carbon footprint when returning to Home screen
    if (_selectedIndex == 0) {
      context.read<HomeCubit>().getCarbonFootprint();
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Fetch carbon footprint when switching to Home screen
    if (index == 0) {
      context.read<HomeCubit>().getCarbonFootprint();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xffD4E0EB),
              radius: 30, // Increased radius to accommodate larger icon
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Notifications');
                },
                child: Image.asset(
                  AssetsData.notify,
                  width: 40, // Increased from 0.4 to a fixed 40 (adjust as needed)
                  height: 40, // Increased from 0.4 to a fixed 40 (adjust as needed)
                  fit: BoxFit.contain, // Ensures the image scales properly within the space
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.kPrimaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Removed const as labels are now dynamic
        items: [
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage(AssetsData.home)),
            label: l10n.navHome, // Localized
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage(AssetsData.recomend)),
            label: l10n.navLearn, // Localized
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage(AssetsData.setting)),
            label: l10n.navSettings, // Localized
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage(AssetsData.profile)),
            label: l10n.navProfile, // Localized
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Home();
      case 1:
        return const Learn();
      case 2:
        return const Setting();
      case 3:
        return const Profile();
      default:
        return Home(); // No longer const
    }
  }
}
