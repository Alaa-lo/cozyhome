// features/owner/controllers/add_apartment_controller.dart

import 'dart:io';
import 'package:cozy_home_1/core/models/apartment_model.dart';

class ApartmentController {
  String? _title;
  String? _description;
  String? _province;
  String? _city;
  String? _address;
  String? _price;
  // إضافة متغير لنوع الإيجار
  String _rentType = "Monthly";
  final List<File> _images = [];

  void setTitle(String v) => _title = v;
  void setDescription(String v) => _description = v;
  void setProvince(String v) => _province = v;
  void setCity(String v) => _city = v;
  void setAddress(String v) => _address = v;
  void setPrice(String v) => _price = v;
  // دالة لتحديث نوع الإيجار من الشاشة
  void setRentType(String v) => _rentType = v;

  void clearImages() => _images.clear();
  void addImage(File img) => _images.add(img);
  List<File> get imageFiles => _images;

  Apartment buildModel() {
    return Apartment(
      title: _title ?? "",
      description: _description ?? "No description provided",
      city: _city ?? "",
      province: _province ?? "",
      address: _address,
      pricePerNight: double.tryParse(_price ?? "0") ?? 0,
      // تأكد أن موديل الـ Apartment يحتوي على حقل rentType
      // إذا لم يكن موجوداً في الموديل بعد، يجب إضافته هناك أولاً
      rentType: _rentType,
      images: const [],
    );
  }
}
