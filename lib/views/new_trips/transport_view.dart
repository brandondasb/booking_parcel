import 'package:booking_parcel/models/Order.dart';
import 'package:booking_parcel/views/new_trips/destination_to_view.dart';
import 'package:flutter/material.dart';

class NewOrderTransportView extends StatefulWidget {
  final Order order;

  const NewOrderTransportView({Key? key, required this.order})
      : super(key: key);

  @override
  State<NewOrderTransportView> createState() => _NewOrderTransportViewState();
}

class _NewOrderTransportViewState extends State<NewOrderTransportView> {
  String currentItemSelected = 'Car';

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    _titleController.text = widget.order.title;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking - select transport'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Select transport method"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: currentItemSelected,
                  items: <String>['Car', 'Boat', 'flight']
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: const Text("Continue"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    widget.order.travelType = currentItemSelected ?? " ";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewOrderDestinationView(order: widget.order)),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
