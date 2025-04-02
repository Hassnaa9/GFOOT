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
  String? _userType; // For dropdown
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                .01 * screenWidth,
                .1 * screenHeight,
                0,
                10,
              ),
              child: Text(
                "Hello! Register to get started",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: screenWidth * .07,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeight * .02),
            BlocBuilder<AuthCubit, UserState>(
              builder: (context, state) {
                // Handle loading state
                bool isLoading = state is SignUpLoading;

                // Handle error state
                if (state is SignUpFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    String errorMessage = state.errMessage;
                    if (errorMessage.contains('Email already exists')) {
                      errorMessage = 'This email is already registered. Please use a different email.';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });
                }

                // Handle success state
                if (state is SignUpSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registration successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushReplacementNamed(context, '/SignIn');
                    });
                  });
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _userNameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your username',
                            filled: true,
                            fillColor: Color(0xffE8ECF4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _displayNameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your display name',
                            filled: true,
                            fillColor: Color(0xffE8ECF4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your display name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: DropdownButtonFormField<String>(
                          value: _userType,
                          decoration: const InputDecoration(
                            hintText: 'Select user type',
                            filled: true,
                            fillColor: Color(0xffE8ECF4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'IndividualUser', child: Text('IndividualUser')),
                            DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _userType = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a user type';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            filled: true,
                            fillColor: Color(0xffE8ECF4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            filled: true,
                            fillColor: const Color(0xffE8ECF4),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'Password must have at least one uppercase letter';
                            }
                            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                              return 'Password must have at least one non-alphanumeric character';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Confirm your password',
                            filled: true,
                            fillColor: const Color(0xffE8ECF4),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your phone number (e.g., +20123456789)',
                            filled: true,
                            fillColor: Color(0xffE8ECF4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^\+\d{10,15}$').hasMatch(value)) {
                              return 'Please enter a valid phone number (e.g., +20123456789)';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _countryController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your country',
                            filled: true,
                            fillColor: Color(0xffE8ECF4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your country';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      SizedBox(
                        width: screenWidth - 44,
                        height: screenHeight * .086,
                        child: TextFormField(
                          controller: _cityController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your city',
                            filled: true,
                            fillColor: Color(0xffE8ECF4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * .02),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  context.read<AuthCubit>().register(
                                        _userNameController.text,
                                        _displayNameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                        _phoneNumberController.text,
                                        _countryController.text,
                                        _cityController.text,
                                        _userType ?? 'IndividualUser',
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: MyColors.kPrimaryColor,
                          foregroundColor: MyColors.white,
                          minimumSize: Size(screenWidth - 44, screenHeight * .086),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Register"),
                      ),
                      SizedBox(height: screenHeight * .02),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Or Register with",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * .02),
                      login_methods(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * .17),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/SignIn');
                        },
                        child: Text.rich(
                          const TextSpan(
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: "Login Now",
                                style: TextStyle(color: MyColors.kPrimaryColor),
                              ),
                            ],
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}