import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Customer extends Equatable {
  String? id;
  final String name;
  final String phone;
  final String company;
  String? imageUrl;

  Customer(
      {required this.name,
      required this.phone,
      required this.company,
      this.imageUrl,
      this.id
      });

  @override
  List<Object?> get props => [name, phone, company, imageUrl];

   set setID(String id){
    this.id  = id;
  }

  
}
