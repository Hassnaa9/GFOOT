import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';
import 'package:graduation_project/Features/home/home.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_carbon_result.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/custom_services.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/gradient_indicator.dart';

import '../../../../constants.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  _HomeViewBodyState createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _selectedIndex = 0;

  // Function to navigate to the appropriate screen
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the appropriate screen based on the selected index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xffD4E0EB),
              child: TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(elevation: 10),
                child: Image.asset(
                  AssetsData.notify,
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6,),
              const Text(
                "See your carbon footprint today!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: screenHeight * .02),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * .25,
                    height: screenWidth * .25,
                    child: GradientCircularProgressIndicator(
                      value: 0.6,
                      size: screenWidth * .7,
                      strokeWidth: 10.0,
                    ),
                  ),
                  const CustomCarbonResult(),
                ],
              ),
              SizedBox(height: screenHeight*.02),
              const Text(
                "Good job!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: screenHeight*.01),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Services",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: MyColors.black),
                ),
              ),
              SizedBox(height: screenHeight*.02),
              CustomServices(screenHeight: screenHeight,screenWidth:screenWidth),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.kPrimaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,  // Handle item tap and navigation
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.home)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.recomend)),
            label: "Learn",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.setting)),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsData.profile)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
