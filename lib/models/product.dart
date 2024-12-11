import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int? id;
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String? imageUrl; // Add this line to include imageUrl

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    this.imageUrl, // Add this line to include imageUrl
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
