import 'dart:io';
import 'package:flutter/material.dart';
import '../controllers/personal_info_controller.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late PersonalInfoController controller;

  @override
  void initState() {
    super.initState();
    controller = PersonalInfoController();
    controller.loadLocalData().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF234E36),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              buildInputField(
                controller: controller.firstNameController,
                label: "First Name",
                onChanged: (_) => controller.saveLocalData(),
              ),
              const SizedBox(height: 16),
              buildInputField(
                controller: controller.lastNameController,
                label: "Last Name",
                onChanged: (_) => controller.saveLocalData(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.birthDateController,
                readOnly: true,
                onTap: () =>
                    controller.pickBirthDate(context, () => setState(() {})),
                decoration: inputDecoration("Birth Date", "DD / MM / YYYY"),
                cursorColor: const Color(0xFF375534),
              ),
              const SizedBox(height: 32),
              buildImageSection(
                title: "Profile Image",
                image: controller.profileImage,
                onUpload: () => controller.pickImage(
                  isProfile: true,
                  onChanged: () => setState(() {}),
                ),
                onTapName: () => controller.openImagePreview(
                  context: context,
                  isProfile: true,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(height: 24),
              buildImageSection(
                title: "ID Image",
                image: controller.idImage,
                onUpload: () => controller.pickImage(
                  isProfile: false,
                  onChanged: () => setState(() {}),
                ),
                onTapName: () => controller.openImagePreview(
                  context: context,
                  isProfile: false,
                  onChanged: () => setState(() {}),
                ),
              ),
              const SizedBox(height: 40),
              const Divider(color: Color(0xFF375534), thickness: 1.2),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF234E36),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => controller.submit(context),
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: const Color(0xFF375534),
      decoration: inputDecoration(label, null),
    );
  }

  InputDecoration inputDecoration(String label, String? hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF375534)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF234E36), width: 2),
      ),
    );
  }

  Widget buildImageSection({
    required String title,
    required File? image,
    required VoidCallback onUpload,
    required VoidCallback onTapName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF234E36),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF234E36),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: onUpload,
            child: const Text(
              "Upload",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        if (image != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: GestureDetector(
                onTap: onTapName,
                child: Text(
                  image.path.split('/').last,
                  style: const TextStyle(
                    color: Color(0xFF234E36),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
