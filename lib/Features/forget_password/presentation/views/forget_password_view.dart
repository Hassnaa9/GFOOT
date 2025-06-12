import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/logo_with_title.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:graduation_project/app_localizations.dart';
import 'package:graduation_project/constants.dart';
import '../../../../Core/utils/assets.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Get the localization instance
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthCubit, UserState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        return LogoWithTitle(
          logo: AssetsData.forgotPassImg,
          title: l10n.forgotPasswordTitle, // Localized
          subText: l10n.forgotPasswordHint, // Localized
          children: [
            Form(
              key: _formKey,
              child: SizedBox(
                width: screenWidth - 44,
                height: screenHeight * .086,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration( // No longer const
                    hintText: l10n.enterYourEmailHint, // Localized
                    filled: true,
                    fillColor: const Color(0xffE8ECF4),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.enterYourEmailHint; // Localized
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return l10n.enterValidEmail; // Localized
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * .04),
            ElevatedButton(
              onPressed: state is SignInLoading
                  ? null // Disable button during loading
                  : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().forgotPassword(
                              _emailController.text,
                              context,
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
              child: state is SignInLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(l10n.continueButton), // Localized
            ),
          ],
            );
      },
    );
  }
}
