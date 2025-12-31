import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cozy_home_1/features/renter/controllers/bookinglistcontroller.dart';
import 'package:cozy_home_1/features/renter/screens/editbookingsheet.dart';
import 'package:cozy_home_1/features/renter/screens/rating_screen.dart';
import 'package:cozy_home_1/features/renter/screens/apartment_details_screen.dart';
import 'package:cozy_home_1/features/renter/controllers/homepage_controller.dart'; // ⭐ مهم
import 'package:cozy_home_1/features/renter/models/booking.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    
    // ⭐ جلب البيانات عند البداية
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingListController>(context, listen: false).fetchBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingListController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF234E36)));
        }

        return Column(
          children: [
            Container(
              color: const Color(0xFF234E36),
              child: TabBar(
                controller: tabController,
                indicatorColor: const Color(0xFFEBEADA),
                labelColor: const Color(0xFFEBEADA),
                unselectedLabelColor: Colors.white70,
                tabs: const [
                  Tab(text: "Current"),
                  Tab(text: "Previous"),
                  Tab(text: "Cancelled"),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  _buildList(controller.currentBookings),
                  _buildList(controller.previousBookings),
                  _buildList(controller.cancelledBookings),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(List<Booking> list) {
    if (list.isEmpty) return _emptyState();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _bookingCard(booking: list[index]);
      },
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month,
              size: 80,
              color: Color(0xFF234E36),
            ),
            const SizedBox(height: 20),
            Text(
              "No bookings here",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF234E36),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your bookings will appear in this category.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookingCard({required Booking booking}) {
    final homeController = Provider.of<RenterHomeController>(
      context,
      listen: false,
    ); // ⭐ مهم

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(
                Icons.delete_outline_outlined,
                color: Color(0xFF234E36),
                size: 22,
              ),
              onPressed: () {
                final bookingController = Provider.of<BookingListController>(
                  context,
                  listen: false,
                );

                if (booking.id != null) {
                  bookingController.cancelBooking(booking.id!);
                }
              },
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF234E36)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "${booking.startDate.day}/${booking.startDate.month}/${booking.startDate.year}"
                      "  →  "
                      "${booking.endDate.day}/${booking.endDate.month}/${booking.endDate.year}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFF234E36),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.group, color: Color(0xFF234E36)),
                  const SizedBox(width: 10),
                  Text(
                    "${booking.numberOfPersons} Guest(s)",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (booking.notes != null && booking.notes!.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.note, color: Color(0xFF234E36)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        booking.notes!,
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xFF234E36),
                        size: 26,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => EditBookingSheet(booking: booking),
                        );
                      },
                    ),

                    const SizedBox(width: 8),

                    IconButton(
                      icon: const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RatingScreen(booking: booking),
                          ),
                        );
                      },
                    ),

                    if (booking.apartment != null)
                      IconButton(
                        icon: Icon(
                          homeController.isFavorite(booking.apartment!)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: homeController.isFavorite(booking.apartment!)
                              ? Colors.pinkAccent
                              : Colors.black26,
                          size: 28,
                        ),
                        onPressed: () {
                          homeController.toggleFavorite(booking.apartment!);
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
