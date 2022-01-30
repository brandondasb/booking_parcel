import 'package:booking_parcel/models/Order.dart';
import 'package:booking_parcel/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              Text("I am sending : ${order.items}"),
              Text(
                  "Start Date ${DateFormat('dd/MM/yyyy').format(order.startDate)}"),
              Text(
                  "End Date ${DateFormat('dd/MM/yyyy').format(order.endDate)}"),
              ElevatedButton(
                child: const Text("Finish"),
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
              )
            ],
          ),
        ));
  }
}
