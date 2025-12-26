import 'package:image_picker/image_picker.dart';
import '../models/apartment_model.dart';

class ApartmentController {
  String? _title;
  String? _governorate;
  String? _city;
  String? _address;
  String? _price;
  String? _priceType;

  final List<XFile> _images = [];

  void setTitle(String v) => _title = v;
  void setGovernorate(String v) => _governorate = v;
  void setCity(String v) => _city = v;
  void setAddress(String v) => _address = v;
  void setPrice(String v) => _price = v;
  void setPriceType(String v) => _priceType = v;

  void addImage(XFile img) => _images.add(img);

  ApartmentModel buildModel() {
    return ApartmentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // 🔥 أهم سطر
      title: _title!,
      governorate: _governorate!,
      city: _city!,
      address: _address ?? "",
      price: double.tryParse(_price!) ?? 0,
      priceType: _priceType ?? "Monthly",
      images: _images.map((e) => e.path).toList(),
    );
  }
}
