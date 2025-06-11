import 'package:flutter/material.dart';
import 'package:graduation_project/Core/utils/assets.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneController;

  const PhoneField({Key? key, required this.phoneController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Phone Number",
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            Image.asset(AssetsData.egyptFlag, width: 30, height: 20),
            const SizedBox(width: 10),
            const Text(
              "(+20)",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 10),
          ],
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
