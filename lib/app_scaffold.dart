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
    if (index == 0) {
      context.read<HomeCubit>().getCarbonFootprint();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
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
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.home), color: _selectedIndex == 0 ? MyColors.kPrimaryColor : theme.bottomNavigationBarTheme.unselectedItemColor),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.recomend), color: _selectedIndex == 1 ? MyColors.kPrimaryColor : theme.bottomNavigationBarTheme.unselectedItemColor),
            label: l10n.navLearn,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.setting), color: _selectedIndex == 2 ? MyColors.kPrimaryColor : theme.bottomNavigationBarTheme.unselectedItemColor),
            label: l10n.navSettings,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.profile), color: _selectedIndex == 3 ? MyColors.kPrimaryColor : theme.bottomNavigationBarTheme.unselectedItemColor),
            label: l10n.navProfile,
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
        return Home();
    }
  }
}