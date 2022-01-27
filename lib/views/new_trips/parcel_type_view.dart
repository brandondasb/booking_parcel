import 'package:booking_parcel/models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewOrderParcelTypeView extends StatefulWidget {
  final Order order;

  const NewOrderParcelTypeView({Key? key, required this.order})
      : super(key: key);

  @override
  State<NewOrderParcelTypeView> createState() => _NewOrderParcelTypeViewState();
}

class _NewOrderParcelTypeViewState extends State<NewOrderParcelTypeView> {
  String currentItemSelected = 'small box';
  List<Item> currentBasket = [];

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
                  value: currentItemSelected,
                  items: <String>[
                    'small box',
                    'medium box',
                    'large box',
                    'other',
                    'vehicle'
                  ].map<DropdownMenuItem<String>>((String value) {
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
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  widget.order.items.add(Item(currentItemSelected,
                      int.parse(_quantityController.text)));
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(children: [
                          Center(child: Text("items in basket")),
                          // widget.order.items.forEach((element) {
                          //                           //   Text(widget.order.items[element].name)
                          //                           // }),
                          getItemsInBasket(widget.order.items),
                          ListTile(
                            leading: Icon(Icons.share),
                            title: Text("bin"),
                            trailing: Icon(Icons.receipt),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.copy),
                            title: Text(widget.order.travelType),
                          ),
                        ]);
                      });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           NewOrderBudgetView(order: widget.order)),
                  // );
                },
              )
            ],
          ),
        ));
  }

  Widget getItemsInBasket(List<Item> items) {
    return Column(
        children: items
            .map(
              (item) => Wrap(children: [
                Image.asset(
                  'assets/images/box.jpg',
                  width: 100,
                  height: 100,
                ),
                Text(item.name),
                Text(item.quantity.toString()),
                const Divider(),
              ]),
            )
            .toList());
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
