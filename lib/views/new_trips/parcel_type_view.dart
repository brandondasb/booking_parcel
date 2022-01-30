import 'package:booking_parcel/models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'budget_view.dart';

class NewOrderParcelTypeView extends StatefulWidget {
  final Order order;

  const NewOrderParcelTypeView({Key? key, required this.order})
      : super(key: key);

  @override
  State<NewOrderParcelTypeView> createState() => _NewOrderParcelTypeViewState();
}

class _NewOrderParcelTypeViewState extends State<NewOrderParcelTypeView> {
  String currentItemSelected = 'small box';
  static List<String> defaultListOfItems = <String>[
    'small box',
    'medium box',
    'large box',
    'other',
    'vehicle'
  ];
  List<Item> currentBasket = defaultListOfItems.map((e) => Item(e, 0)).toList();

  @override
  Widget build(BuildContext context) {
    TextEditingController _quantityController = TextEditingController();
    _quantityController.text = "1";

    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking - Select Parcel'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("what are you sending?"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: currentItemSelected,
                  items: defaultListOfItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newItemSelected) {
                    setState(() {
                      currentItemSelected = newItemSelected!;
                    });
                  },
                ),
              ),
              Text("How many $currentItemSelected do you need?"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _quantityController,
                  decoration:
                      const InputDecoration(labelText: "Enter your quantity"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.pink,
                      primary: Colors.white,
                      onPrimary: Colors.red,
                      minimumSize: Size.fromHeight(50)),
                  child: const Text("Add to basket"),
                  onPressed: () {
                    for (var element in currentBasket) {
                      if (element.name == currentItemSelected) {
                        element.quantity = int.parse(_quantityController.text);
                      }
                    }
                    widget.order.items =
                        currentBasket.where((e) => e.quantity != 0).toList();
                    displayBasketSheet(context, widget.order.items);
                  },
                ),
              ),
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
                          builder: (context) =>
                              NewOrderBudgetView(order: widget.order)),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void displayBasketSheet(BuildContext context, List<Item> items) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(children: [
          const Center(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("items in basket"))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: getItemsInBasket(items),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                child: const Text("Continue"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewOrderBudgetView(order: widget.order)),
                  );
                },
              ),
            ),
          ),
        ]);
      },
    );
  }

  Widget getItemsInBasket(List<Item> items) {
    return Column(
        children: items
            .map(
              (item) => Row(children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/box.jpg',
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(child: Text(item.name)),
                Text("Quantity " + item.quantity.toString()),
                const Expanded(child: Icon(Icons.delete_forever)),
                const Divider(),
              ]),
            )
            .toList());
  }
}
