import 'package:track_my_order/views/Drawer/DrawerItem.dart';

import 'order.dart';

abstract class IClient {
  int id;
  String name, phone, image;
  List<Order> currOrders = [];
  List<Order> prevOrders = [];
  List<DrawerItem> drawerItems;

  void callAPI();
}
