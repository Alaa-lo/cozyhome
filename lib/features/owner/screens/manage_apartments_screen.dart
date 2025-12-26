import 'dart:io';
import 'package:cozy_home_1/features/owner/screens/edit_apartment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/owner_home_controller.dart';

class ManageApartmentsScreen extends StatelessWidget {
  const ManageApartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OwnerHomeController>(context);

    return Container(
      color: const Color(0xFFEBEADA),
      child: controller.apartments.isEmpty
          ? const Center(
              child: Text(
                "No apartments added yet",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF234E36),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.apartments.length,
              itemBuilder: (context, index) {
                final apt = controller.apartments[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة الشقة
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                        child: apt.images.isNotEmpty
                            ? Image.file(
                                File(apt.images.first),
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 180,
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.home,
                                  size: 60,
                                  color: Color(0xFF234E36),
                                ),
                              ),
                      ),

                      // معلومات الشقة
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              apt.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF234E36),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Governorate: ${apt.governorate}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "City: ${apt.city}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Price: \$${apt.price} / ${apt.priceType}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF234E36),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // أزرار Edit / Delete
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // زر Edit
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditApartmentScreen(apartment: apt),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF234E36),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  color: Color(0xFFEBEADA),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // زر Delete (بيج + أخضر)
                            OutlinedButton(
                              onPressed: () {
                                controller.deleteApartment(apt.id);
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF234E36),
                                  width: 2,
                                ),
                                backgroundColor: const Color(0xFFEBEADA),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                  color: Color(0xFF234E36),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
