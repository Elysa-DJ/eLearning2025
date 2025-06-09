import 'package:flutter/material.dart';
import '../../controllers/register_controller.dart';

class PersonalInfoForm extends StatelessWidget {
  final RegisterController controller;

  const PersonalInfoForm({
    super.key,
    required this.controller,
  });

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
           _buildDropdownField(
              context: context, // Ajoutez cette ligne
              icon: Icons.wc,
              hintText: "Sex",
              value: controller.selectedGender.value,
              items: ["Masculin", "Féminin"],
              onChanged: (val) => controller.genderController.text = val??"",
              validator: controller.validateGender,
            ),
            SizedBox(height: 10),
            _buildDropdownField(
              context: context, // Ajoutez cette ligne
              icon: Icons.flag,
              hintText: "Nationality",
              value: controller.selectedNationality.value,
              items: controller.africanCountries,
              onChanged: (val) => controller.nationalityController.text = val??"",
              validator: controller.validateNationality,
            ),
            SizedBox(height: 10),
            _buildDropdownField(
              context: context, // Ajoutez cette ligne
              icon: Icons.school,
              hintText: "School Year",
              value: controller.selectedAcademicYear.value,
              items: controller.academicYears,
              onChanged: (val) => controller.academicYearController.text = val??"",
              validator: controller.validateAcademicYear,
            ),
            SizedBox(height: 10),
            _buildTextField(
              Icons.location_on,
              "Place of Birth",
              controller.birthPlaceController,
              controller.validateBirthPlace,
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
                  onPressed: () => controller.nextStep(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text("Suivant", style: TextStyle(color: Colors.white)),
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

Widget _buildDropdownField({
  required BuildContext context,
  required IconData icon,
  required String hintText,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  String? Function(String?)? validator,
}) {

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
      dropdownColor: Colors.white,
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      icon: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Theme.of(context).primaryColor,
          size: 24,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ))
          .toList(),
    ),
  );
}
}