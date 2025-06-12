import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/gender_field.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/phone_field.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/custom_text_field.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class EditAccountViewBody extends StatefulWidget {
  const EditAccountViewBody({super.key});

  @override
  State<EditAccountViewBody> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditAccountViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? _profileImage; // To store the selected image
  final ImagePicker _picker = ImagePicker();

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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Check and request permissions before picking an image
  Future<bool> _checkAndRequestPermission(Permission permission) async {
    if (await permission.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    }
    return true;
  }

  // Function to pick an image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;
    try {
      bool hasPermission = false;
      if (source == ImageSource.camera) {
        hasPermission = await _checkAndRequestPermission(Permission.camera);
      } else {
        hasPermission = await _checkAndRequestPermission(Permission.storage);
        if (!hasPermission) {
          hasPermission = await _checkAndRequestPermission(Permission.photos);
        }
      }

      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.permissionDeniedMessage)), // Localized
        );
        return;
      }

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${l10n.errorPickingImageMessage}: $e")), // Localized
      );
    }
  }

  // Show a dialog to choose between camera and gallery
  void _showImageSourceDialog() {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(l10n.cameraOption), // Localized
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(l10n.galleryOption), // Localized
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  // Save the image locally
  Future<String?> _saveImageLocally(File image) async {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final fileName = 'profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await image.copy('$path/$fileName');
      return savedImage.path;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${l10n.errorSavingImageMessage}: $e")), // Localized
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          l10n.editProfileTitle, // Localized
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 70, color: Colors.white)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.grey),
                        onPressed: _showImageSourceDialog,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _slideAnimation,
              child: CustomTextField(
                controller: _fullNameController,
                label: l10n.fullNameLabel, // Localized
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 15),
            SlideTransition(
              position: _slideAnimation,
              child: CustomTextField(
                controller: _addressController,
                label: l10n.addressLabel, // Localized
                icon: Icons.location_on,
              ),
            ),
            const SizedBox(height: 15),
            SlideTransition(
              position: _slideAnimation,
              child: CustomTextField(
                controller: _dobController,
                label: l10n.dateOfBirthLabel, // Localized
                icon: Icons.calendar_today,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    _dobController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            SlideTransition(
              position: _slideAnimation,
              child: CustomTextField(
                controller: _emailController,
                label: l10n.emailLabel, // Localized
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 15),
            SlideTransition(
              position: _slideAnimation,
              child: PhoneField(phoneController: _phoneController),
            ),
            const SizedBox(height: 15),
            SlideTransition(
              position: _slideAnimation,
              child: GenderField(),
            ),
            const SizedBox(height: 30),
            SlideTransition(
              position: _slideAnimation,
              child: ElevatedButton(
                onPressed: () async {
                  String? savedImagePath;
                  if (_profileImage != null) {
                    savedImagePath = await _saveImageLocally(_profileImage!);
                  }

                  try {
                    await context.read<HomeCubit>().fetchUserProfile(); // Refresh user profile
                    final activityRepository = context.read<ActivityRepository>();
                    await activityRepository.updateProfile(
                      displayName: _fullNameController.text,
                      phoneNumber: _phoneController.text,
                      country: _addressController.text.split(',').last.trim(), // Assuming country is last part of address
                      city: _addressController.text.split(',').first.trim(), // Assuming city is first part of address
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.profileUpdateSuccessMessage)), // Localized
                    );
                    Navigator.pop(context); // Return to previous screen
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${l10n.profileUpdateFailedMessage}: $e")), // Localized
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.kPrimaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(l10n.updateButton), // Localized
              ),
            ),
          ],
        ),
      ),
    );
  }
}
