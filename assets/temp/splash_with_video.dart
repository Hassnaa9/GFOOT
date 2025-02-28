// import 'package:flutter/material.dart';
// import 'package:graduation_project/Core/utils/assets.dart';
// import 'package:video_player/video_player.dart';
//
//
// class SplashViewBody extends StatefulWidget{
//   const SplashViewBody({Key? key}) : super(key: key);
//
//   @override
//   State<SplashViewBody> createState() => _SplashViewBodyState();
// }
//
// class _SplashViewBodyState extends State<SplashViewBody> {
//   @override
//   Widget build(BuildContext context) {
//
//     late VideoPlayerController controller;
//     // Get screen width and height
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     // Method to navigate to the next screen
//     void navigateToLoginOrReg() {
//       Navigator.pushReplacementNamed(context, '/SigninOrSignup');
//     }
//
//     @override
//     void initState() {
//       super.initState();
//       controller = VideoPlayerController.asset(AssetsData.splashImg)
//         ..initialize().then((_) {
//           setState(() {});
//           controller.play(); // Play the video once it's loaded
//           controller.setLooping(true); // Loop the video for continuous background
//         });
//     }
//
//     return GestureDetector(
//       onTap: navigateToLoginOrReg,  // Navigate on tap
//       child: Stack(
//         fit: StackFit.expand, // To cover the entire screen
//         children: [
//           // Video Background
//           if (controller.value.isInitialized)
//             Positioned.fill(
//               child: FittedBox(
//                 fit: BoxFit.cover, // Ensure video covers the entire screen
//                 child: SizedBox(
//                   width: controller.value.size.width,
//                   height: controller.value.size.height,
//                   child: VideoPlayer(controller),
//                 ),
//               ),
//             ),
//           // Responsive Logo in the center
//           Center(
//             child: FractionallySizedBox(
//               alignment: Alignment.center,
//               widthFactor: 0.5, // Adjust width factor (50% of screen width)
//               child: Image.asset(
//                 AssetsData.logo, // Your logo file path
//                 fit: BoxFit.contain, // Keep the logo's aspect ratio
//               ),
//             ),
//           ),
//           // "Tap to Continue" Text at 5% of screen height below the logo
//           Positioned(
//             bottom: screenHeight * 0.05, // Position the text 2% from the bottom of the screen
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Text(
//                 'Tap to Start!',
//                 // style: GoogleFonts.rokkitt(
//                 //     fontSize: screenHeight * 0.03,  // Set font size to 3% of screen height
//                 //     fontWeight: FontWeight.bold,
//                 //     color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//
//   }
// }