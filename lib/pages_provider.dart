import 'dart:collection';

import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<String> _pages = ["First Tab"];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<String> get pages => UnmodifiableListView(_pages);


  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(String item) {
    _pages.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}