import 'package:flutter/material.dart';
import 'package:shopping/data/models/advertisement_model.dart';

class Fav extends ChangeNotifier {
  List<Data> _items = [];
  double _price = 0;
  void add(Data item) {
    _items.add(item);
    
    notifyListeners();
  }
  void remove(Data item) {
    _items.remove(item);
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return _price;
  }

  List<Data> get favorite {
    return _items;
  }
}
