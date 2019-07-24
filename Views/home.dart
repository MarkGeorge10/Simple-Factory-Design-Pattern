import 'package:flutter/material.dart';
import 'package:track_my_order/models/IClient.dart';
import 'package:track_my_order/models/order.dart';
import 'package:track_my_order/models/orderState.dart';

import '../main.dart';
import 'Drawer/myDrawer.dart';
import 'orderDetails.dart';

class Home extends StatefulWidget {
  final int selectedType;

  const Home({Key key, this.selectedType}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

// Instance from abstract class Iclient to know client that is logined as  User or company
  IClient client;

  @override
  void initState() {
    super.initState();
    switch (widget.selectedType) {
      case 1:
        client = users[0];
        break;
      case 2:
        client = companies[0];
        break;
      
    }

//-------------------------- Enter Data until API get ready-------------------------------------

    if (users[0].currOrders.isEmpty && companies[0].currOrders.isEmpty) {
      Order order1 = Order("512", users[0], [
        OrderState("get components"),
        OrderState("mix components"),
        OrderState("put it in the oven for 15 minute"),
        OrderState("Serve it fresh"),
      ]);
      order1.orderCompany = companies[0];

      Order order2 = Order("1024", users[1], [
        OrderState("get components"),
        OrderState("Serve it fresh"),
      ]);
      order2.orderCompany = companies[0];

      users[0].currOrders.add(order1);
      users[1].currOrders.add(order2);
      companies[0].currOrders.add(order1);
      companies[0].currOrders.add(order2);
    }
  }

//----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:
            client.currOrders.isEmpty ? buildEmptyListText() : buildOrderList(),
      ),
      drawer: MyDrawer(
        client: client,
      ),
    );
  }

  Widget buildEmptyListText() {
    return Center(
      child: Text(
        "You Don't Have any orders in progress right now.",
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  Widget buildOrderList() {
    return ListView.builder(
      itemCount: client.currOrders.length,
      itemBuilder: (context, i) {
        return buildOrder(i);
      },
    );
  }

  Widget buildOrder(int i) {
    return Card(
      elevation: 4,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Order ID: ${client.currOrders[i].orderId}"),
                    // bold
                    subtitle: Text(
                        "${client.currOrders[i].orderUser.name} | ${client.currOrders[i].orderCompany.name}"),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 30, 10),
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    color: Colors.indigo,
                    child: FlatButton(
                      child: Text(
                        "Order Details",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => OrderDetails(
                                    order: client.currOrders[i],
                                    selectedType: widget.selectedType,
                                  ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(
              child: Image.asset(client.currOrders[i].orderUser.image),
            ),
          ),
          Container(
            color: Colors.brown,
            margin: EdgeInsets.all(10),
            width: 1,
            height: MediaQuery.of(context).size.height / 10,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Image.asset(client.currOrders[i].orderCompany.image),
            ),
          ),
        ],
      ),
    );
  }
}
