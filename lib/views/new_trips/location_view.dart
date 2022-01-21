import 'package:booking_parcel/models/Trip.dart';
import 'package:flutter/material.dart';

import 'date_view.dart';

class NewTripLocationView extends StatelessWidget {
  final Trip trip;

  const NewTripLocationView({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    String? currentItemSelected = 'Car';
    _titleController.text = trip.title;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Book parcel - select travel'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Select transport"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: DropdownButton<String>(
                  items: <String>['Car', 'Boat', 'flight']
                      .map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newItemSelected) {
                    setState(() {
                      currentItemSelected = newItemSelected;
                    });
                  },
                  value: currentItemSelected,
                ),
              ),
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  trip.title = _titleController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTripDateView(trip: trip)),
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
