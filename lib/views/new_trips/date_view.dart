import 'dart:async';

// import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:booking_parcel/models/Order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'budget_view.dart';

class NewTripDateView extends StatefulWidget {
  final Order order;

  const NewTripDateView({Key? key, required this.order}) : super(key: key);

  @override
  State<NewTripDateView> createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
  late DateTime date;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  bool readyToCollect = false;

  Future displayDateRangePicker(BuildContext context) async {
    // final List<DateTime> picked = await DateRagePicker.showDatePicker(
    //     context: context,
    //     initialFirstDate: _startDate,
    //     initialLastDate: _endDate,
    //     firstDate: DateTime(DateTime.now().year - 50),
    //     lastDate: DateTime(DateTime.now().year + 50));
    //once date picked
    // if (picked != null && picked.length == 2) {
    //   setState(() {
    //     _startDate = picked[0];
    //     _endDate = picked[1];
    //   });
    // }

    // final List<DateTime> newDate = await showDatePicker(
    //     context: context,
    //     //     initialLastDate: _endDate,
    //     firstDate: DateTime(DateTime.now().year - 50),
    //     lastDate: DateTime(DateTime.now().year + 50),
    //     initialDate: _startDate);
    // if (newDate == null) return;
    // setState(() => date = newDate);
    // setState(() {
    //   _startDate = newDate[0];
    //   _endDate = newDate[1];
    // });
    /** attempt for the date range**/
    final initialDateRange = DateTimeRange(start: _startDate, end: _endDate);

    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 50),
        initialDateRange: initialDateRange);
    if (newDateRange == null) return;
    setState(() => _startDate = _startDate);
  }

  String getFrom() {
    if (_startDate != null) {
      return DateFormat('dd/MM/yyyy').format(_startDate);
    } else {
      return "from";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Trip - Date'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Location ${widget.order.title}"),
              ElevatedButton(
                onPressed: () async {
                  await displayDateRangePicker(context);
                },
                child: Text("Select date"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(getFrom()),
                ],
              ),
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  widget.order.startDate = _startDate;
                  widget.order.rtc = readyToCollect;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewOrderBudgetView(order: widget.order)),
                  );
                },
              )
            ],
          ),
        ));
  }
}
