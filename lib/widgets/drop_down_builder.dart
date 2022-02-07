import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  CustomDropdown({Key? key}) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdown();
}

class _CustomDropdown extends State<CustomDropdown> {
  String dropdownValue = 'Car';

  currentlySelectedValue() {
    return dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      alignment: AlignmentDirectional.centerEnd,
      value: dropdownValue,
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      // style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        // color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Car', 'Boat', 'Flight']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
