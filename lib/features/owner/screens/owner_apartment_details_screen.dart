import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cozy_home_1/core/models/apartment_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OwnerApartmentDetailsScreen extends StatefulWidget {
  final Apartment apartment;

  const OwnerApartmentDetailsScreen({super.key, required this.apartment});

  @override
  State<OwnerApartmentDetailsScreen> createState() =>
      _OwnerApartmentDetailsScreenState();
}

class _OwnerApartmentDetailsScreenState
    extends State<OwnerApartmentDetailsScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEADA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF234E36),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEBEADA)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.apartment.title,
          style: const TextStyle(color: Color(0xFFEBEADA)),
        ),
      ),

      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صور الشقة
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 260,
                    child: PageView(
                      controller: _pageController,
                      children: widget.apartment.images.map((img) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: img.startsWith('http')
                              ? Image.network(
                                  img,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  img,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.apartment.images.length,
                    effect: WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: const Color(0xFF234E36),
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.apartment.title,
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF234E36),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFF234E36),
                            size: 26,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "4.5",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF234E36),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "(120 reviews)",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _infoRow(Icons.map, widget.apartment.province),
                              const SizedBox(height: 15),
                              _infoRow(
                                Icons.location_on,
                                widget.apartment.city,
                              ),
                              const SizedBox(height: 15),
                              _infoRow(
                                Icons.attach_money,
                                "\$${widget.apartment.pricePerNight} / night",
                                isPrice: true,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Features",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF234E36),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          FeatureItem(icon: Icons.bed, label: "3 Beds"),
                          FeatureItem(icon: Icons.bathtub, label: "2 Baths"),
                          FeatureItem(icon: Icons.kitchen, label: "Kitchen"),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Description",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF234E36),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "A beautiful apartment located in a quiet area with modern design and spacious rooms.",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {bool isPrice = false}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF234E36)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: isPrice ? 20 : 18,
              fontWeight: isPrice ? FontWeight.w600 : FontWeight.normal,
              color: isPrice ? const Color(0xFF234E36) : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF234E36), size: 28),
        const SizedBox(height: 5),
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    );
  }
}
