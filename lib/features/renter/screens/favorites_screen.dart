import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cozy_home_1/features/renter/controllers/homepage_controller.dart';
import 'package:cozy_home_1/features/renter/screens/apartment_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RenterHomeController>(context);

    return Container(
      color: const Color(0xFFEBEADA),
      child: controller.favorites.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.favorites.length,
              itemBuilder: (context, index) {
                final apt = controller.favorites[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ApartmentDetailsScreen(apartmentId: apt.id!),
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
                              ? (apt.images.first.startsWith('http')
                                    ? Image.network(
                                        apt.images.first,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        apt.images.first,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ))
                              : Container(
                                  height: 180,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.home, size: 50),
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
                              ),
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
                                "Price: \$${apt.pricePerNight} / night",
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
                );
              },
            ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite_border, size: 80, color: Color(0xFF234E36)),
          SizedBox(height: 20),
          Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF234E36),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Your favorite apartments will appear here.",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
