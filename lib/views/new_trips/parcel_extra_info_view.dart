import 'package:booking_parcel/models/Order.dart';
import 'package:booking_parcel/reusables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'budget_view.dart';

class NewOrderParcelExtraInfoView extends StatefulWidget {
  final Order order;

  const NewOrderParcelExtraInfoView({Key? key, required this.order})
      : super(key: key);

  @override
  State<NewOrderParcelExtraInfoView> createState() =>
      _NewOrderParcelExtraInfoViewState();
}

class _NewOrderParcelExtraInfoViewState
    extends State<NewOrderParcelExtraInfoView> {
  String currentItemSelected = 'small box';
  static List<String> defaultListOfItems = <String>[
    'small box',
    'medium box',
  ];
  List<Item> currentBasket = defaultListOfItems.map((e) => Item(e, 0)).toList();

  @override
  Widget build(BuildContext context) {
    TextEditingController _quantityController = TextEditingController();
    _quantityController.text = "1";

    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking - more details'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("Based on your previous choices"),
                      Text("How many $currentItemSelected do you need?"),
                    ],
                  ),
                  Column(
                    children: getFinalForm(widget.order.items) +
                        [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50)),
                              child: const Text("Continue"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewOrderBudgetView(
                                          order: widget.order)),
                                );
                              },
                            ),
                          )
                        ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  List<Widget> getFinalForm(List<Item> items) {
    TextEditingController _carRegController = TextEditingController();
    _carRegController.text = "";
    List<Widget> views = [];
    for (var item in items) {
      switch (item.name) {
        case smallBox:
          views.add(Container(child: Text("small")));
          break;
        case mediumBox:
          views.add(Container(child: Text("medium")));
          break;
        case largeBox:
          views.add(Container(child: Text("L")));
          break;
        case other:
          views.add(Column(
            children: [
              const Text("Other type of packaging"),
              const Text("Your sending an item that won fit our box sizes?"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _carRegController,
                  decoration: const InputDecoration(
                      labelText:
                          "Please provide details about the item e.g name, size"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                ),
              ),
            ],
          ));
          break;
        case vehicle:
          views.add(Column(children: [
            const Text("Sending a Vehicle?"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _carRegController,
                decoration: const InputDecoration(
                    labelText: "Enter your Registration or make and model"),
              ),
            ),
          ]));
      }
    }
    return views;
  }
}
