import 'dart:io';
import 'package:cozy_home_1/features/owner/models/apartment_model.dart';
import 'package:image_picker/image_picker.dart';

class ApartmentController {
  String? _title;
  String? _description;
  String? _province;
  String? _city;
  String? _address;
  String? _price;

  final List<XFile> _images = [];

  // setters
  void setTitle(String v) => _title = v;
  void setDescription(String v) => _description = v;
  void setProvince(String v) => _province = v;
  void setCity(String v) => _city = v;
  void setAddress(String v) => _address = v;
  void setPrice(String v) => _price = v;

  void addImage(XFile img) => _images.add(img);

  // تحويل XFile → File
  List<File> get imageFiles => _images.map((x) => File(x.path)).toList();

  // بناء موديل Apartment الرسمي
  Apartment buildModel() {
    return Apartment(
      title: _title ?? "",
      description: _description ?? "",
      city: _city ?? "",
      province: _province ?? "",
      address: _address,
      pricePerNight: double.tryParse(_price ?? "0") ?? 0,
      images: const [], // الصور تُرفع من السيرفس وليس من هنا
    );
  }
}
