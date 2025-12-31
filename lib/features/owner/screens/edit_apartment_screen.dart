import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../controllers/owner_home_controller.dart';
import 'package:cozy_home_1/features/renter/models/apartment.dart';

class EditApartmentScreen extends StatefulWidget {
  final Apartment apartment;

  const EditApartmentScreen({super.key, required this.apartment});

  @override
  State<EditApartmentScreen> createState() => _EditApartmentScreenState();
}

class _EditApartmentScreenState extends State<EditApartmentScreen> {
  late TextEditingController titleController;
  late TextEditingController provinceController;
  late TextEditingController cityController;
  late TextEditingController priceController;

  List<String> images = [];

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.apartment.title);
    provinceController = TextEditingController(
      text: widget.apartment.province,
    );
    cityController = TextEditingController(text: widget.apartment.city);
    priceController = TextEditingController(
      text: widget.apartment.pricePerNight.toString(),
    );

    images = List.from(widget.apartment.images);
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();

    if (picked.isNotEmpty) {
      setState(() {
        images.addAll(picked.map((e) => e.path));
        if (images.length > 4) {
          images = images.sublist(0, 4);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OwnerHomeController>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        elevation: 0,
        title: const Text(
          "Edit Apartment",
          style: TextStyle(
            color: Color(0xFFEBEADA),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // صور الشقة
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...images.map((img) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(img),
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          top: 6,
                          right: 16,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                images.remove(img);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),

                  if (images.length < 4)
                    GestureDetector(
                      onTap: pickImages,
                      child: Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Color(0xFF234E36),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _field("Title", titleController),
            _field("Province", provinceController),
            _field("City", cityController),
            _field("Price", priceController, isNumber: true),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                final updated = Apartment(
                  id: widget.apartment.id,
                  title: titleController.text,
                  description: widget.apartment.description, // Keep original description
                  province: provinceController.text,
                  city: cityController.text,
                  pricePerNight: double.tryParse(priceController.text) ?? 0,
                  images: images,
                );

                controller.updateApartment(updated);

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF234E36),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(
                  color: Color(0xFFEBEADA),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF234E36)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF234E36), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
