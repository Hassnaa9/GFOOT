import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/widgets/login_methods.dart';
import 'package:graduation_project/constants.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String _userType = 'IndividualUser'; // Default value
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
      body: BlocListener<AuthCubit, UserState>(
  listener: (context, state) {
    print('State received: $state'); // Debug
    if (state is SignUpFailure) {
      String errorMessage = state.errMessage ?? 'An unknown error occurred';
      if (errorMessage.contains('Email')) {
        errorMessage = 'This email is already registered. Please use a different email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } else if (state is SignUpSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Please verify your email.'),
          backgroundColor: MyColors.kPrimaryColor,
        ),
      );
      Navigator.pushNamed(context, '/ConfirmEmail', arguments: _emailController.text);
      context.read<AuthCubit>().resendResetConfirmEmailOtp(_emailController.text, context);

    }
  },
  child: _buildForm(scaffoldContext),
),
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<AuthCubit, UserState>(
          builder: (context, state) {
            final isLoading = state is SignUpLoading;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  Text(
                    "Hello! Register to get started",
                    style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  _buildTextField(_userNameController, 'Enter your username'),
                  _buildTextField(_displayNameController, 'Enter your display name'),
                  _buildDropdown(screenWidth, screenHeight),
                  _buildTextField(_emailController, 'Enter your email', keyboardType: TextInputType.emailAddress, validator: _emailValidator),
                  _buildPasswordField(_passwordController, 'Enter your password'),
                  _buildPasswordField(_confirmPasswordController, 'Confirm your password', confirm: true),
                  _buildTextField(_phoneNumberController, 'Enter your phone number (e.g., +20123456789)', keyboardType: TextInputType.phone, validator: _phoneValidator),
                  _buildTextField(_countryController, 'Enter your country'),
                  _buildTextField(_cityController, 'Enter your city'),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
  onPressed: isLoading
      ? null
      : () {
          print('Validating form...');
          if (_formKey.currentState!.validate()) {
            print('Form validated successfully');
            _formKey.currentState!.save();
            context.read<AuthCubit>().register(
                  _userNameController.text,
                  _displayNameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _phoneNumberController.text,
                  _countryController.text,
                  _cityController.text,
                  _userType,
                );

            // Move navigation to BlocListener to ensure it happens after success
          } else {
            print('Form validation failed');
          }
        },
  style: ElevatedButton.styleFrom(
    backgroundColor: MyColors.kPrimaryColor,
    foregroundColor: Colors.white,
    minimumSize: Size(screenWidth - 44, screenHeight * 0.07),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: isLoading
      ? const CircularProgressIndicator(color: Colors.white)
      : const Text("Register"),
),SizedBox(height: screenHeight * 0.02),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),
                  const Text("Or Register with", style: TextStyle(color: Colors.grey)),
                  const Divider(thickness: 1),
                  SizedBox(height: screenHeight * 0.02),
                  login_methods(screenWidth: screenWidth, screenHeight: screenHeight),
                  SizedBox(height: screenHeight * 0.08),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/SignIn'),
                    child: RichText(
                      text: const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(text: "Login Now", style: TextStyle(color: MyColors.kPrimaryColor)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {TextInputType? keyboardType, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xffE8ECF4),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none),
        ),
        keyboardType: keyboardType,
        validator: validator ?? (value) => value == null || value.isEmpty ? 'Required field' : null,
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hintText, {bool confirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xffE8ECF4),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none),
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required field';
          if (!confirm) {
            if (value.length < 8) return 'At least 8 characters';
            if (!RegExp(r'[A-Z]').hasMatch(value)) return 'One uppercase letter required';
            if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) return 'One special character required';
          } else if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _userType,
        decoration: InputDecoration(
          hintText: 'Select user type',
          filled: true,
          fillColor: const Color(0xffE8ECF4),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none),
        ),
        items: const [
          DropdownMenuItem(value: 'IndividualUser', child: Text('IndividualUser')),
          DropdownMenuItem(value: 'Admin', child: Text('Admin')),
        ],
        onChanged: (value) {
          setState(() {
            _userType = value!;
            print('User type selected: $_userType');
          });
        },
        validator: (value) {
          print('Validating user type: $value');
          return value == null ? 'Please select a user type' : null;
        },
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Enter your email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Enter your phone number';
    if (!RegExp(r'^\+\d{10,15}$').hasMatch(value)) return 'Invalid phone (e.g., +20123456789)';
    return null;
  }
}