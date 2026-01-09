import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cozy_home_1/features/owner/controllers/add_apartment_controller.dart';

class AddApartmentScreen extends StatefulWidget {
  const AddApartmentScreen({super.key});

  @override
  State<AddApartmentScreen> createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApartmentController controller = ApartmentController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _selectedGovernorate;
  String? _selectedCity;
  String _priceType = "Monthly";

  final List<XFile> _images = [];

  final Color mainGreen = const Color(0xFF234E36);
  final Color background = const Color(0xFFEBEADA);

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();

    if (_images.length >= 4) return;

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (_images.length < 4) {
          _images.add(image);
        }
      });
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: mainGreen, fontWeight: FontWeight.w600),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainGreen, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainGreen.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: mainGreen,
        title: const Text(
          "Add New Apartment",
          style: TextStyle(color: Color(0xFFEBEADA)),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Apartment Name
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration("Apartment Name"),
                style: TextStyle(color: mainGreen),
                validator: (v) => v!.isEmpty ? "Enter apartment name" : null,
              ),
              const SizedBox(height: 20),

              // Governorate
              DropdownButtonFormField<String>(
                value: _selectedGovernorate,
                decoration: _inputDecoration("Governorate"),
                dropdownColor: Colors.white,
                style: TextStyle(color: mainGreen, fontWeight: FontWeight.w600),
                items: const [
                  DropdownMenuItem(value: "Damascus", child: Text("Damascus")),
                  DropdownMenuItem(value: "Aleppo", child: Text("Aleppo")),
                  DropdownMenuItem(value: "Homs", child: Text("Homs")),
                ],
                onChanged: (v) => setState(() => _selectedGovernorate = v),
                validator: (v) => v == null ? "Select governorate" : null,
              ),
              const SizedBox(height: 20),

              // City
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: _inputDecoration("City"),
                dropdownColor: Colors.white,
                style: TextStyle(color: mainGreen, fontWeight: FontWeight.w600),
                items: const [
                  DropdownMenuItem(value: "Mazzeh", child: Text("Mazzeh")),
                  DropdownMenuItem(value: "Baramkeh", child: Text("Baramkeh")),
                ],
                onChanged: (v) => setState(() => _selectedCity = v),
                validator: (v) => v == null ? "Select city" : null,
              ),
              const SizedBox(height: 20),

              // Detailed Address
              TextFormField(
                controller: _addressController,
                decoration: _inputDecoration("Detailed Address"),
                style: TextStyle(color: mainGreen),
              ),
              const SizedBox(height: 20),

              // Price
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Price"),
                style: TextStyle(color: mainGreen),
                validator: (v) => v!.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 20),

              // Price Type
              Text(
                "Price Type",
                style: TextStyle(
                  fontSize: 16,
                  color: mainGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: "Monthly",
                    groupValue: _priceType,
                    activeColor: mainGreen,
                    onChanged: (v) => setState(() => _priceType = v!),
                  ),
                  Text("Monthly", style: TextStyle(color: mainGreen)),

                  Radio(
                    value: "Daily",
                    groupValue: _priceType,
                    activeColor: mainGreen,
                    onChanged: (v) => setState(() => _priceType = v!),
                  ),
                  Text("Daily", style: TextStyle(color: mainGreen)),
                ],
              ),
              const SizedBox(height: 20),

              // Images
              Text(
                "Apartment Images (Max 4)",
                style: TextStyle(
                  fontSize: 16,
                  color: mainGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _images.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  if (index == _images.length) {
                    if (_images.length < 4) {
                      return GestureDetector(
                        onTap: pickImages,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: mainGreen),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.add, size: 40, color: mainGreen),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(_images[index].path),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // تعبئة الكونترولر بالبيانات
                      controller.setTitle(_titleController.text);
                      controller.setProvince(_selectedGovernorate!);
                      controller.setCity(_selectedCity!);
                      controller.setAddress(_addressController.text);
                      controller.setPrice(_priceController.text);

                      // إضافة الصور
                      for (var img in _images) {
                        controller.addImage(img);
                      }

                      // بناء الموديل
                      final apartment = controller.buildModel();

                      // رجوع الشقة للصفحة السابقة
                      Navigator.pop(context, {
                        "apartment": apartment,
                        "images": controller.imageFiles,
                      });
                    }
                  },

                  child: const Text(
                    "Save Apartment",
                    style: TextStyle(fontSize: 18, color: Color(0xFFEBEADA)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
