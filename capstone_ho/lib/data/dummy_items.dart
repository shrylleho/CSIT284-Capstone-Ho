import '../models/item_model.dart';

final List<ItemModel> initialDummyItems = [
  ItemModel(
    id: '1',
    title: 'Black Hydro Flask (32oz)',
    description: 'Left near the computer lab tables. Has a small sticker on the bottom.',
    status: 'Found',
    location: 'CCS Building, 3rd Floor',
    contactInfo: '0917-123-4567 / FB: Juan Dela Cruz',
    datePosted: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  ItemModel(
    id: '2',
    title: 'Student ID & Lanyard',
    description: 'Lost my ID around the canteen area during lunch break.',
    status: 'Lost',
    location: 'Main Canteen',
    contactInfo: 'maria.santos@school.edu.ph',
    datePosted: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  ItemModel(
    id: '3',
    title: 'Casio Scientific Calculator',
    description: 'Found inside Room 204 after the morning lecture.',
    status: 'Found',
    location: 'Room 204',
    contactInfo: 'Claim at Security Desk / 0998-765-4321',
    datePosted: DateTime.now().subtract(const Duration(days: 1)),
    isClaimed: true,
  ),
];