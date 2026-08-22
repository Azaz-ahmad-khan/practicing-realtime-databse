import 'package:flutter/material.dart';
import 'package:reltm_crud/models/item.dart';
import 'package:reltm_crud/service/rltm_service.dart';

class AddItemViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final RltmService rltmService = RltmService();
  int _quantity = 1;
  bool _isBought = false;
  bool _isLoading = false;
  String? errorMessage;

  int get quantity => _quantity;
  bool get isBought => _isBought;
  bool get isLoading => _isLoading;

  void setQuantity(int value) {
    if (value > 0) {
      _quantity = value;
      notifyListeners();
    }
  }

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void setIsBought(bool value) {
    _isBought = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Construct the Item object from the current input states.
  /// Returns null if inputs are invalid.
  Item? getItem() {
    final name = nameController.text.trim();
    if (name.isEmpty) return null;

    return Item(
      name: name,
      quantity: _quantity,
      isbought: _isBought,
      addedAt: DateTime.now(),
    );
  }

  Future<void> addItems(Item item) async {
    try {
      await rltmService.addPost(item);
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
   
    }
  }

  void reset() {
    nameController.clear();
    _quantity = 1;
    _isBought = false;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
