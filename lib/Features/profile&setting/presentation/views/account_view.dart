import 'package:flutter/material.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/gender_field.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/phone_field.dart';
import 'package:graduation_project/Features/profile&setting/presentation/views/widgets/custom_text_field.dart';
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
    try {
      // Check permissions based on the source
      bool hasPermission = false;
      if (source == ImageSource.camera) {
        hasPermission = await _checkAndRequestPermission(Permission.camera);
      } else {
        hasPermission = await _checkAndRequestPermission(Permission.storage);
        // For Android 13+, also check media permissions
        if (!hasPermission) {
          hasPermission = await _checkAndRequestPermission(Permission.photos);
        }
      }

      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission denied. Please enable it in settings.")),
        );
        return;
      }

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 300, // Reduce resolution for performance
        maxHeight: 300,
        imageQuality: 85, // Compress image
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  // Show a dialog to choose between camera and gallery
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Gallery"),
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
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final fileName = 'profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await image.copy('$path/$fileName');
      return savedImage.path;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving image: $e")),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F5F0), // Light green background
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5F5F0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Profile Picture
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

            // Full Name
            SlideTransition(
              position: _slideAnimation,
              child: CustomTextField(
                controller: _fullNameController,
                label: "Full Name",
                icon: Icons.person,
              ),
            ),
            const SizedBox(height: 15),

            // Address
            SlideTransition(
              position: _slideAnimation,
                child: CustomTextField(
                controller: _addressController,
                label: "Address",
                icon: Icons.location_on,
              ),
            ),
            const SizedBox(height: 15),

            // Date of Birth
            SlideTransition(
              position: _slideAnimation,
              child: CustomTextField(
                controller: _dobController,
                label: "Date of Birth",
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

            // Email
            SlideTransition(
              position: _slideAnimation,
              child: CustomTextField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 15),

            // Phone Number
            SlideTransition(
              position: _slideAnimation,
              child: PhoneField(phoneController:  _phoneController),
            ),
            const SizedBox(height: 15),

            // Gender
            SlideTransition(
              position: _slideAnimation,
              child: GenderField(),
            ),
            const SizedBox(height: 30),

            // Update Button
            SlideTransition(
              position: _slideAnimation,
              child: ElevatedButton(
                onPressed: () async {
                  String? savedImagePath;
                  if (_profileImage != null) {
                    savedImagePath = await _saveImageLocally(_profileImage!);
                  }
                  print("Update button pressed");
                  print("Full Name: ${_fullNameController.text}");
                  print("Address: ${_addressController.text}");
                  print("DOB: ${_dobController.text}");
                  print("Email: ${_emailController.text}");
                  print("Phone: ${_phoneController.text}");
                  print("Profile Image Path: $savedImagePath");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.kPrimaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text("UPDATE"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  

}