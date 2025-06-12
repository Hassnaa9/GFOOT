import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/Features/login&registration/presentation/views/widgets/login_methods.dart';
import 'package:graduation_project/app_localizations.dart';
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
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return Builder(
      builder: (scaffoldContext) {
        return Scaffold(
          body: BlocListener<AuthCubit, UserState>(
            listener: (context, state) {
              print('State received: $state'); // Debug
              if (state is SignUpFailure) {
                String errorMessage = state.errMessage ?? l10n.unknownErrorOccurred; // Localized
                if (errorMessage.contains('Email')) { // Still checking for 'Email' in raw error message
                  errorMessage = l10n.emailAlreadyRegistered; // Localized
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is SignUpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.registrationSuccessVerifyEmail), // Localized
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
    final l10n = AppLocalizations.of(context)!; // Get the localization instance

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
                    l10n.helloRegisterToGetStarted, // Localized
                    style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  _buildTextField(_userNameController, l10n.enterYourUsernameHint), // Localized
                  _buildTextField(_displayNameController, l10n.enterYourDisplayNameHint), // Localized
                  _buildDropdown(screenWidth, screenHeight), // Localized internally
                  _buildTextField(_emailController, l10n.enterYourEmailHint, keyboardType: TextInputType.emailAddress, validator: _emailValidator), // Localized
                  _buildPasswordField(_passwordController, l10n.enterYourPasswordHint), // Localized
                  _buildPasswordField(_confirmPasswordController, l10n.confirmYourPasswordHint, confirm: true), // Localized
                  _buildTextField(_phoneNumberController, l10n.enterYourPhoneNumberHint, keyboardType: TextInputType.phone, validator: _phoneValidator), // Localized
                  _buildTextField(_countryController, l10n.enterYourCountryHint), // Localized
                  _buildTextField(_cityController, l10n.enterYourCityHint), // Localized
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
                        : Text(l10n.registerButton), // Localized
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),
                  Text(l10n.orRegisterWith, style: const TextStyle(color: Colors.grey)), // Localized
                  const Divider(thickness: 1),
                  SizedBox(height: screenHeight * 0.02),
                  login_methods(screenWidth: screenWidth, screenHeight: screenHeight),
                  SizedBox(height: screenHeight * 0.08),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/SignIn'),
                    child: RichText(
                      text: TextSpan( // No longer const
                        text: l10n.alreadyHaveAccount, // Localized
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(text: l10n.loginNowLink, style: const TextStyle(color: MyColors.kPrimaryColor)), // Localized
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
        validator: validator ?? (value) {
          final l10n = AppLocalizations.of(context)!; // Access l10n in validator
          return value == null || value.isEmpty ? l10n.requiredField : null; // Localized
        },
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hintText, {bool confirm = false}) {
    final l10n = AppLocalizations.of(context)!; // Access l10n in validator scope

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
          if (value == null || value.isEmpty) return l10n.requiredField; // Localized
          if (!confirm) {
            if (value.length < 8) return l10n.passwordMinLength; // Localized
            if (!RegExp(r'[A-Z]').hasMatch(value)) return l10n.passwordOneUppercase; // Localized (new ARB key)
            if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) return l10n.passwordOneSpecialChar; // Localized (new ARB key)
          } else if (value != _passwordController.text) {
            return l10n.passwordsDoNotMatch; // Localized (new ARB key)
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(double screenWidth, double screenHeight) {
    final l10n = AppLocalizations.of(context)!; // Access l10n here

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _userType,
        decoration: InputDecoration(
          hintText: l10n.selectUserType, // Localized
          filled: true,
          fillColor: const Color(0xffE8ECF4),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none),
        ),
        items: [ // No longer const
          DropdownMenuItem(value: 'IndividualUser', child: Text(l10n.individualUserDropdown)), // Localized
          DropdownMenuItem(value: 'Admin', child: Text(l10n.companyUserDropdown)), // Mapped Admin to Company User for now
        ],
        onChanged: (value) {
          setState(() {
            _userType = value!;
            print('User type selected: $_userType');
          });
        },
        validator: (value) {
          print('Validating user type: $value');
          return value == null ? l10n.pleaseSelectUserType : null; // Localized
        },
      ),
    );
  }

  String? _emailValidator(String? value) {
    final l10n = AppLocalizations.of(context)!; // Access l10n here

    if (value == null || value.isEmpty) return l10n.enterYourEmailHint; // Localized
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return l10n.enterValidEmail; // Localized
    return null;
  }

  String? _phoneValidator(String? value) {
    final l10n = AppLocalizations.of(context)!; // Access l10n here

    if (value == null || value.isEmpty) return l10n.enterYourPhoneNumberHint; // Localized
    if (!RegExp(r'^\+\d{10,15}$').hasMatch(value)) return l10n.invalidPhoneNumberExample; // Localized (new ARB key)
    return null;
  }
}
