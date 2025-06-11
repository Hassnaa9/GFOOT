import 'package:flutter/material.dart';

class GenderField extends StatelessWidget {
  const GenderField({super.key});
    final String _selectedGender = 'Male'; // Default gender


  @override
  Widget build(BuildContext context) {
    return _buildGenderField();
  }

  Widget _buildGenderField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        decoration: const InputDecoration(
          labelText: "Gender",
          prefixIcon: Icon(Icons.person, color: Colors.grey),
          border: InputBorder.none,
        ),
        items: ['Male', 'Female', 'Other']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
            .toList(),
        onChanged: (value) {
          // You need to manage the state properly here
        },
      ),
    );
  }
}