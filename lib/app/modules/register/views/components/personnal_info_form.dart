import 'package:flutter/material.dart';
import '../../controllers/register_controller.dart';

class PersonalInfoForm extends StatelessWidget {
  final RegisterController controller;

  const PersonalInfoForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.personalInfoFormKey,
      child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            Icons.person, 
            "First Name", 
            controller.nameController,
            controller.validateName,
          ),
          SizedBox(height: 10),
          _buildTextField(
            Icons.person_outline, 
            "Last Name", 
            controller.surnameController,
            controller.validateSurname,
          ),
          SizedBox(height: 10),
          _buildDateField(
            context,
            Icons.calendar_today, 
            "Date of Birth", 
            controller.dateOfBirthController,
            controller.validateDateOfBirth,
          ),
          SizedBox(height: 10),
          _buildTextField(
            Icons.location_city, 
            "City of Residence", 
            controller.cityController,
            controller.validateCity,
          ),
          SizedBox(height: 10),
          _buildTextField(
            Icons.email, 
            "Email", 
            controller.emailController,
            controller.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
           SizedBox(height: 10),
          _buildTextField(
            Icons.phone, 
            "Phone (Optional)", 
            controller.phoneController,
            controller.validatePhone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xFF03A9F4), Color(0xff281537)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ElevatedButton(
                onPressed: controller.nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    ),
    );
  }

  Widget _buildTextField(
    IconData icon, 
    String hintText, 
    TextEditingController controller,
    String? Function(String?)? validator, {
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildDateField(
    BuildContext context,
    IconData icon, 
    String hintText, 
    TextEditingController dateController,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      controller: dateController,
      validator: validator,
      readOnly: true,
      onTap: () => controller.selectDate(context),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}