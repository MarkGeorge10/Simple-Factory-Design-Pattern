import 'package:flutter/material.dart';
import 'package:track_my_order/views/Drawer/DrawerItem.dart';

import 'IClient.dart';
import 'company.dart';
import 'order.dart';

class User implements IClient {
  int id;
  String name, phone, image;
  List<Order> currOrders = [];
  List<Order> prevOrders = [];
  List<Company> favorites = [];
  //List<Company> savedFavourite = List<Company>();
  List<DrawerItem> drawerItems = [
    DrawerItem("Explore", '/Explore', Icons.explore),
    DrawerItem("Favourites", '/FavouritePage', Icons.favorite),
    DrawerItem("Previous order", '/previousOrders', Icons.history),
  ];

  User(this.id, this.name, this.phone, this.image);

  @override
  void callAPI() {
    // TODO: implement callAPI
  }
}
