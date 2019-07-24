import 'package:flutter/material.dart';
import 'package:track_my_order/views/Drawer/DrawerItem.dart';

import 'IClient.dart';
import 'order.dart';

class Company implements IClient {
  int id;
  double longtitude, latitude;
  String name, phone, image, type, description, location;
  List<Order> currOrders = [];
  List<Order> prevOrders = [];
  List<DrawerItem> drawerItems = [
    DrawerItem("Add Order", '/addOrder', Icons.add_circle_outline),
    DrawerItem("Previous order", '/previousOrders', Icons.history),
  ];


  Company(this.id, this.longtitude, this.latitude, this.name, this.phone,
      this.type, this.description, this.location, this.image);

  @override
  void callAPI() {
    // TODO: implement callAPI
  }
}
