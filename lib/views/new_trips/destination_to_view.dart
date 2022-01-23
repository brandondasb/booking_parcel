import 'package:booking_parcel/models/Order.dart';
import 'package:booking_parcel/views/new_trips/parcel_type_view.dart';
import 'package:flutter/material.dart';

class NewOrderDestinationView extends StatefulWidget {
  final Order order;

  const NewOrderDestinationView({Key? key, required this.order})
      : super(key: key);

  @override
  State<NewOrderDestinationView> createState() =>
      _NewOrderDestinationViewState();
}

class _NewOrderDestinationViewState extends State<NewOrderDestinationView> {
  String currentItemSelected = 'Congo';

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    _titleController.text = widget.order.title;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking - select destination'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("What country are you sending to?"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: DropdownButton<String>(
                  value: currentItemSelected,
                  items: <String>['Congo', 'Angola']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newItemSelected) {
                    setState(() {
                      currentItemSelected = newItemSelected ?? "Congo";
                    });
                  },
                ),
              ),
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  widget.order.sendTo = currentItemSelected;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewOrderParcelTypeView(order: widget.order)),
                  );
                },
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
