import 'dart:io';

import 'package:cozy_home_1/core/models/apartment_model.dart';
import 'package:cozy_home_1/features/owner/controllers/owner_home_controller.dart';
import 'package:cozy_home_1/features/owner/screens/owner_apartment_details_screen.dart';
import 'package:cozy_home_1/features/owner/service/owner_apartment_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cozy_home_1/features/owner/screens/add_apartment_screen.dart';
import 'package:cozy_home_1/features/owner/screens/manage_apartments_screen.dart';
import 'package:cozy_home_1/features/owner/screens/booking_requests_screen.dart';
import 'package:cozy_home_1/features/owner/screens/owner_profile_screen.dart';
import 'package:cozy_home_1/features/owner/screens/owner_notifications_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({Key? key}) : super(key: key);

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen>
    with SingleTickerProviderStateMixin {
  late OwnerHomeController controller;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();

    controller = Provider.of<OwnerHomeController>(context, listen: false);

    // 🔥 initAnimations مباشرة (آمنة)
    controller.initAnimations(this);

    // 🔥 fetchApartments بعد اكتمال build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchApartments();
    });

    _currentPage = _homeContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        elevation: 0,
        title: const Text(
          "Owner",
          style: TextStyle(
            color: Color(0xFFEBEADA),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFFEBEADA)),
            onPressed: () async {
              // 1. الانتقال لشاشة الإضافة وانتظار النتيجة
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddApartmentScreen()),
              );

              // 2. التحقق من النتيجة
              if (result != null) {
                // النتيجة القادمة من شاشة الإضافة
                // نصرّح عنه كـ Apartment لمنع أي خطأ من نوع []
                final Apartment apartmentModel = result["apartment"];
                final List<File> images = result["images"];

                try {
                  // 3. استدعاء السيرفس
                  final createdApt = await OwnerApartmentService()
                      .createApartment(
                        apartment: apartmentModel, // object وليس Map
                        images: images,
                      );

                  // 4. تحديث الواجهة عبر الكونترولر
                  controller.addApartment(createdApt);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Apartment created successfully"),
                    ),
                  );
                } catch (e) {
                  print("Error in UI: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to create apartment")),
                  );
                }
              }
            },
          ),

          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFFEBEADA),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OwnerNotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(children: [Expanded(child: _currentPage)]),

      bottomNavigationBar: _buildConvexNavBar(),
    );
  }

  Widget _homeContent() {
    return Consumer<OwnerHomeController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF234E36)),
          );
        }

        if (controller.errorMessage != null) {
          return Center(
            child: Text(
              controller.errorMessage!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        if (controller.apartments.isEmpty) {
          return const Center(
            child: Text(
              "No apartments found",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF234E36),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.apartments.length,
          itemBuilder: (context, index) {
            final apt = controller.apartments[index];

            return AnimatedBuilder(
              animation: controller.curveAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - controller.curveAnimation.value)),
                  child: Opacity(
                    opacity: controller.curveAnimation.value,

                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OwnerApartmentDetailsScreen(apartment: apt),
                          ),
                        );
                      },

                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: apt.images.isNotEmpty
                                  ? Image.network(
                                      apt.images.first,
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
                                  ), ////////////////////////////////
                                  const SizedBox(height: 6),
                                  Text(
                                    "Province: ${apt.province}",
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
                                    "Price: \$${apt.pricePerNight} / Night",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF234E36),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildConvexNavBar() {
    final icons = [
      Icons.home,
      Icons.home_work_outlined,
      Icons.list_alt,
      Icons.person,
    ];

    return SizedBox(
      height: 115,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEBEADA),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: 3,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: AnimatedBuilder(
              animation: controller.curveAnimation,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ConvexPainter(
                    selectedIndex: controller.selectedIndex,
                    curveValue: controller.curveAnimation.value,
                  ),
                );
              },
            ),
          ),

          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                final isSelected = index == controller.selectedIndex;

                return GestureDetector(
                  onTap: () {
                    controller.onNavTapped(index, () {
                      setState(() {
                        if (index == 0) {
                          _currentPage = _homeContent();
                        } else if (index == 1) {
                          _currentPage = const ManageApartmentsScreen();
                        } else if (index == 2) {
                          _currentPage = const BookingRequestsScreen();
                        } else if (index == 3) {
                          _currentPage = const OwnerProfileScreen();
                        }
                      });
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(bottom: isSelected ? 16 : 8),
                    child: AnimatedScale(
                      scale: isSelected ? 1.25 : 1.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      child: Icon(
                        icons[index],
                        color: const Color(0xFF234E36),
                        size: 28,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConvexPainter extends CustomPainter {
  final int selectedIndex;
  final double curveValue;

  _ConvexPainter({required this.selectedIndex, required this.curveValue});

  @override
  void paint(Canvas canvas, Size size) {
    final safeCurve = curveValue.clamp(0.0, 1.0);

    final paint = Paint()
      ..color = const Color(0xFFEBEADA)
      ..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    final itemWidth = width / 4;
    final centerX = (selectedIndex * itemWidth) + (itemWidth / 2);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(centerX - 30, 0)
      ..quadraticBezierTo(centerX, -20 * safeCurve, centerX + 30, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.12), 4, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ConvexPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.curveValue != curveValue;
  }
}
