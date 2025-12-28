import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cozy_home_1/features/auth/screens/otpverificationscreen.dart';
import '../screens/image_preview_screen.dart';

class PersonalInfoController {
  PersonalInfoController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  File? profileImage;
  File? idImage;

  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    firstNameController.text = prefs.getString('firstName') ?? '';
    lastNameController.text = prefs.getString('lastName') ?? '';
    birthDateController.text = prefs.getString('birthDate') ?? '';

    String? profilePath = prefs.getString('profileImagePath');
    if (profilePath != null) {
      profileImage = File(profilePath);
    }

    String? idPath = prefs.getString('idImagePath');
    if (idPath != null) {
      idImage = File(idPath);
    }
  }

  Future<void> saveLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('birthDate', birthDateController.text);

    if (profileImage != null) {
      await prefs.setString('profileImagePath', profileImage!.path);
    }
    if (idImage != null) {
      await prefs.setString('idImagePath', idImage!.path);
    }
  }

  Future<void> pickImage({
    required bool isProfile,
    required VoidCallback onChanged,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (isProfile) {
        profileImage = File(pickedFile.path);
      } else {
        idImage = File(pickedFile.path);
      }
      await saveLocalData();
      onChanged();
    }
  }

  Future<void> pickBirthDate(
    BuildContext context,
    VoidCallback onChanged,
  ) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      birthDateController.text = "${date.day}/${date.month}/${date.year}";
      await saveLocalData();
      onChanged();
    }
  }

  bool validateInputs(BuildContext context) {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        birthDateController.text.isEmpty ||
        profileImage == null ||
        idImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> submit(BuildContext context) async {
    if (!validateInputs(context)) return;

    final prefs = await SharedPreferences.getInstance();

    // حفظ حالة إكمال الملف الشخصي
    await prefs.setBool("profileCompleted", true);

    // ⭐ جلب الإيميل من الريجستر
    String email = prefs.getString("email") ?? "";

    // ⭐ إضافة المستخدم لقائمة الطلبات
    List<String> pending = prefs.getStringList("pendingRequests") ?? [];

    if (!pending.contains(email)) {
      pending.add(email);
      await prefs.setStringList("pendingRequests", pending);
    }

    // ⭐ بعد إدخال المعلومات → ننتقل إلى شاشة التحقق
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OTPVerificationScreen()),
    );
  }

  void openImagePreview({
    required BuildContext context,
    required bool isProfile,
    required VoidCallback onChanged,
  }) {
    final File? imageFile = isProfile ? profileImage : idImage;
    if (imageFile == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImagePreviewScreen(
          imageFile: imageFile,
          onDelete: () async {
            if (isProfile) {
              profileImage = null;
            } else {
              idImage = null;
            }
            await saveLocalData();
            onChanged();
          },
          onReplace: () async {
            await pickImage(isProfile: isProfile, onChanged: onChanged);
          },
        ),
      ),
    );
  }
}
