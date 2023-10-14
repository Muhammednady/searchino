import 'package:searchino/features/customers/domain/entity/customer_entity.dart';

// ignore: must_be_immutable
class CustomerModel extends Customer {
  // CustomerModel(
  //     {required super.name,
  //     required super.phone,
  //     required super.company,
  //     required super.imageUrl});
  String? id;
  final String name;
  final String phone;
  final String company;
  String? imageUrl;

  CustomerModel(
      {
      required this.name,
      required this.phone,
      required this.company,
      required this.imageUrl})
      : super(name: name, phone: phone, company: company, imageUrl: imageUrl);

  CustomerModel.nullImage({
    required this.name,
    required this.phone,
    required this.company,
    required this.id
  }) : super(name: name, phone: phone, company: company,id: id);

  factory CustomerModel.formJson(Map<String, dynamic> json) {
    
    return CustomerModel(
        name: json['name'],
        phone: json['phone'],
        company: json['company'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "company": company,
      "imageUrl": imageUrl
    };
  }
}
