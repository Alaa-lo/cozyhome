import 'package:cozy_home_1/features/owner/models/apartment_model.dart';
import 'package:image_picker/image_picker.dart';

class ApartmentController {
  String title = "";
  String governorate = "";
  String city = "";
  String address = "";
  double price = 0;
  String priceType = " per month";

  List<XFile> images = [];

  void setTitle(String value) => title = value;
  void setGovernorate(String value) => governorate = value;
  void setCity(String value) => city = value;
  void setAddress(String value) => address = value;
  void setPrice(String value) => price = double.tryParse(value) ?? 0;
  void setPriceType(String value) => priceType = value;

  void addImage(XFile img) {
    if (images.length < 4) {
      images.add(img);
    }
  }

  ApartmentModel buildModel() {
    return ApartmentModel(
      title: title,
      governorate: governorate,
      city: city,
      address: address,
      price: price,
      priceType: priceType,
      images: images.map((e) => e.path).toList(),
    );
  }
}
