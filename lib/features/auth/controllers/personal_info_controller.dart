import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
    if (profilePath != null) profileImage = File(profilePath);

    String? idPath = prefs.getString('idImagePath');
    if (idPath != null) idImage = File(idPath);
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
      birthDateController.text = "${date.year}-${date.month}-${date.day}";
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
    String? token = prefs.getString("token");

    if (token == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User not authenticated")));
      return;
    }

    try {
      // ⭐⭐ الرّوت الصحيح ⭐⭐
      var uri = Uri.parse("http://172.16.0.8:8000/api/profile");

      var request = http.MultipartRequest("POST", uri);

      request.headers["Authorization"] = "Bearer $token";
      request.headers["Accept"] = "application/json";

      request.fields["first_name"] = firstNameController.text;
      request.fields["last_name"] = lastNameController.text;
      request.fields["birth_date"] = birthDateController.text;

      request.files.add(
        await http.MultipartFile.fromPath("profile_image", profileImage!.path),
      );

      request.files.add(
        await http.MultipartFile.fromPath("id_image", idImage!.path),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("PROFILE RESPONSE: $responseBody");

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OTPVerificationScreen()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $responseBody")));
      }
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong: $e")));
    }
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
