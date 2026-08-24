import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reltm_crud/models/item.dart';
import 'package:reltm_crud/service/rltm_service.dart';

class HomeViewModel extends ChangeNotifier {
  final RltmService _rltmService = RltmService();

  List<Item> _items = [];
  List<Item> get items => _items;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  StreamSubscription<List<Item>>? _subscription;

  HomeViewModel() {
    _subscribeToItems();
  }

  void _subscribeToItems() {
    _isLoading = true;
    notifyListeners();

    _subscription = _rltmService.getItemsRealtime().listen(
      (itemsList) {
        _items = itemsList;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (err) {
        _error = err.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> deleteItem(String id) async {
    try {
      await _rltmService.deleteItem(id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
