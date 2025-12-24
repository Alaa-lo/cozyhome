import 'package:cozy_home_1/features/renter/controllers/FilterController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
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
    final controller = Provider.of<FilterController>(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Scaffold(
          backgroundColor: const Color(0xFFEBEADA),

          appBar: AppBar(
            backgroundColor: const Color(0xFF234E36),
            title: const Text(
              "Filter Apartments",
              style: TextStyle(color: Color(0xFFEBEADA)),
            ),
            actions: [
              TextButton(
                onPressed: controller.reset,
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Color(0xFFEBEADA)),
                ),
              ),
            ],
          ),

          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Section Title
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 6),
                  child: Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF234E36),
                    ),
                  ),
                ),

                _buildCard(
                  title: "Governorate",
                  child: _dropdown(
                    value: controller.selectedGovernorate,
                    hint: "Select governorate",
                    items: controller.governorates,
                    onChanged: controller.setGovernorate,
                  ),
                ),

                const SizedBox(height: 20),

                _buildCard(
                  title: "City",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dropdown(
                        value: controller.selectedCity,
                        hint: "Select city",
                        items: controller.availableCities,
                        onChanged: controller.setCity,
                      ),

                      if (controller.selectedGovernorate == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Select a governorate first",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(
                  height: 30,
                  thickness: 1,
                  color: Color(0xFF234E36),
                  indent: 10,
                  endIndent: 10,
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 6),
                  child: Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF234E36),
                    ),
                  ),
                ),

                _buildCard(
                  title: "Price Range",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _rangeValuesBox(
                        label1: "Min",
                        value1: "\$${controller.minPrice.toInt()}",
                        label2: "Max",
                        value2: "\$${controller.maxPrice.toInt()}",
                      ),

                      const SizedBox(height: 12),

                      RangeSlider(
                        values: RangeValues(
                          controller.minPrice,
                          controller.maxPrice,
                        ),
                        min: 300,
                        max: 4000,
                        divisions: 20,
                        activeColor: const Color(0xFF234E36),
                        inactiveColor: const Color(0xFF234E36).withOpacity(0.3),
                        onChanged: (values) {
                          controller.setPrice(values.start, values.end);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF234E36),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, controller.getFilters());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.check, color: Color(0xFFEBEADA)),
                        SizedBox(width: 8),
                        Text(
                          "Apply Filters",
                          style: TextStyle(
                            color: Color(0xFFEBEADA),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ DROPDOWN
  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        suffixIcon: value != null
            ? IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF234E36)),
                onPressed: () => onChanged(null),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF234E36), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF234E36), width: 1.3),
        ),
      ),
      dropdownColor: Colors.white,
      iconEnabledColor: const Color(0xFF234E36),
      hint: Text(hint, style: const TextStyle(color: Color(0xFF234E36))),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              color: Color(0xFF234E36),
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // ✅ CARD
  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF234E36),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // ✅ PRICE BOXES
  Widget _rangeValuesBox({
    required String label1,
    required String value1,
    required String label2,
    required String value2,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F6F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _valueBox(label1, value1),
          const Icon(Icons.swap_horiz, color: Color(0xFF234E36)),
          _valueBox(label2, value2),
        ],
      ),
    );
  }

  Widget _valueBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF234E36), width: 1),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF234E36),
            ),
          ),
        ),
      ],
    );
  }
}
