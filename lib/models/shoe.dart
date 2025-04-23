import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Shoe {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String price;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  final String description;
  final String category;
  final dynamic imageUrl;

  Shoe({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.imageUrl, 
  });
}
