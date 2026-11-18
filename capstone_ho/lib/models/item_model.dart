class ItemModel {
  final String id;
  final String title;
  final String description;
  final String status; 
  final String location;
  final String contactInfo;
  final String? imagePath; 
  final DateTime datePosted;
  bool isClaimed;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.location,
    required this.contactInfo,
    this.imagePath,
    required this.datePosted,
    this.isClaimed = false,
  });
}