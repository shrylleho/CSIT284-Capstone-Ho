import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../data/dummy_items.dart';

class ItemProvider extends ChangeNotifier {
  final List<ItemModel> _items = List.from(initialDummyItems);
  String _filter = 'All'; // 'All', 'Lost', 'Found'

  String get filter => _filter;

  List<ItemModel> get filteredItems {
    if (_filter == 'All') return _items;
    return _items.where((item) => item.status == _filter).toList();
  }

  void setFilter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  void addItem(ItemModel item) {
    _items.insert(0, item);
    notifyListeners();
  }

  void markAsClaimed(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].isClaimed = true;
      notifyListeners();
    }
  }
}