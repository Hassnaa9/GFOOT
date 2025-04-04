import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/Features/forget_password/presentation/views/widgets/otp_form_text.dart';
import 'package:graduation_project/constants.dart';

class OtpForm extends StatefulWidget {
  final Function(String) onOtpSubmitted; // Callback to send OTP to parent

  const OtpForm({super.key, required this.onOtpSubmitted});

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (_) => FocusNode());
    _controllers = List.generate(6, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitOtp() {
    if (_formKey.currentState!.validate()) {
      final otp = _controllers.map((c) => c.text).join();
      widget.onOtpSubmitted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return SizedBox(
                width: screenWidth * 0.12,
                child: OtpTextFormField(
                  focusNode: _focusNodes[index],
                  controller: _controllers[index],
                  onChanged: (value) {
                    if (value.length == 1 && index < 5) {
                      _focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    } else if (value.length == 1 && index == 5) {
                      _focusNodes[index].unfocus();
                      _submitOtp(); // Auto-submit on last digit
                    }
                  },
                  onSaved: (pin) {},
                  autofocus: index == 0,
                ),
              );
            }),
          ),
          SizedBox(height: screenHeight * 0.03),
          ElevatedButton(
            onPressed: _submitOtp,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: MyColors.kPrimaryColor,
              foregroundColor: MyColors.white,
              minimumSize: Size(screenWidth - 44, screenHeight * .086),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }
}

const InputDecoration otpInputDecoration = InputDecoration(
  filled: false,
  border: UnderlineInputBorder(),
  hintText: "0",
);