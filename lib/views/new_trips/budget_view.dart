import 'package:booking_parcel/models/Order.dart';
import 'package:booking_parcel/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../reusables.dart';

class NewOrderBudgetView extends StatelessWidget {
  final Order order;
  FirebaseFirestore db = FirebaseFirestore.instance;

  NewOrderBudgetView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    _titleController.text = order.title;
    return Scaffold(
      appBar: AppBar(
        title: const Text('B - Budget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Order summary ${order.title}"),
            Text("Sending by ${order.travelType}"),
            Text("Sending to ${order.sendTo}"),
            Column(
              children: order.items
                  .map(
                      (element) => Text("${element.name} ${element.quantity} "))
                  .toList(),
            ),
            Text(
                "Booking date ${DateFormat('dd/MM/yyyy').format(order.startDate)}"),
            Text("Ready to collect ${order.rtc}"),
            Text("Total ${getTotalPrice(order.items)}"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: const Text("Book"),
                onPressed: () async {
                  // save to firebase
                  final uid = await Provider.of(context).auth.getCurrentUID();

                  await db
                      .collection("userData")
                      .doc(uid)
                      .collection("orders")
                      .add(order.toJson());
                  // .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()))
                  // .set(trip.toJson());// should still generate something unique with the date assigned
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getTotalPrice(List<Item> items) {
    int total = 0;
    for (var item in items) {
      switch (item.name) {
        case smallBox:
          total += item.quantity * 10;
          break;
        case mediumBox:
          total += item.quantity * 12;
          break;
        case largeBox:
          total += item.quantity * 15;
          break;
        case other:
          break;
      }
    }
    return total;
  }
}
