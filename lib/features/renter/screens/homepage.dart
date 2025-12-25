import 'package:cozy_home_1/features/renter/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:cozy_home_1/features/renter/controllers/homepage_controller.dart';
import 'package:cozy_home_1/features/renter/screens/filterscreen.dart';
import 'package:cozy_home_1/features/renter/screens/apartment_details_screen.dart';
import 'package:cozy_home_1/features/renter/screens/mybookingsScreen.dart';
import 'package:cozy_home_1/features/renter/screens/renterprofilescreen.dart';
import 'package:provider/provider.dart';
import 'favorites_screen.dart';

class RenterHomeScreen extends StatefulWidget {
  const RenterHomeScreen({Key? key}) : super(key: key);

  @override
  State<RenterHomeScreen> createState() => _RenterHomeScreenState();
}

class _RenterHomeScreenState extends State<RenterHomeScreen>
    with SingleTickerProviderStateMixin {
  late RenterHomeController controller;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    controller = RenterHomeController();
    controller.initAnimations(this);

    _currentPage = _homeContent();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Scaffold(
        backgroundColor: const Color(0xFFEBEADA),

        appBar: AppBar(
          backgroundColor: const Color(0xFF234E36),
          elevation: 0,
          title: const Text(
            "Find your place",
            style: TextStyle(
              color: Color(0xFFEBEADA),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFFEBEADA),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
          ],
        ),

        body: Column(children: [Expanded(child: _currentPage)]),

        bottomNavigationBar: _buildConvexNavBar(),
      ),
    );
  }

  Widget _homeContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF234E36)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: () async {
                  final filters = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ),
                  );

                  if (filters != null) {
                    controller.applyFilters(filters);
                    setState(() {});
                  }
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF234E36),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: Color(0xFFEBEADA),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: controller.filtered.isEmpty
              ? const Center(
                  child: Text(
                    "No apartments found",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filtered.length,
                  itemBuilder: (context, index) {
                    final apt = controller.filtered[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ApartmentDetailsScreen(apartment: apt),
                          ),
                        );
                      },
                      child: AnimatedBuilder(
                        animation: controller.curveAnimation,
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              20 * (1 - controller.curveAnimation.value),
                            ),
                            child: Opacity(
                              opacity: controller.curveAnimation.value,
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
                                      child: Image.asset(
                                        apt.images.first,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            "Price: \$${apt.price} / month",
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
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////
  Widget _buildConvexNavBar() {
    final icons = [Icons.home, Icons.event_note, Icons.favorite, Icons.person];

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
                          _currentPage = const MyBookingsScreen();
                        } else if (index == 2) {
                          _currentPage = FavoritesScreen(); // ⭐ التعديل الوحيد
                        } else if (index == 3) {
                          _currentPage = const ProfileScreen();
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
