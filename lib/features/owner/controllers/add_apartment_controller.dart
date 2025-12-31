import 'package:image_picker/image_picker.dart';
import 'package:cozy_home_1/features/renter/models/apartment.dart';

class ApartmentController {
  String? _title;
  String? _description;
  String? _province;
  String? _city;
  String? _price;

  final List<XFile> _images = [];

  void setTitle(String v) => _title = v;
  void setDescription(String v) => _description = v;
  void setProvince(String v) => _province = v;
  void setGovernorate(String v) => _province = v; // Compatibility
  void setCity(String v) => _city = v;
  void setPrice(String v) => _price = v;
  void setAddress(String v) => _description = v; // Map to description
  void setPriceType(String v) {} // Dummy for now

  void addImage(XFile img) => _images.add(img);

  Apartment buildModel() {
    return Apartment(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _title!,
      description: _description ?? "",
      province: _province!,
      city: _city!,
      pricePerNight: double.tryParse(_price!) ?? 0,
      images: _images.map((e) => e.path).toList(),
    );
  }
}
