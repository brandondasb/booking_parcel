class Order {
  String title;
  DateTime startDate;
  DateTime endDate;
  double budget;
  String travelType;
  String sendTo;
  List<Item> items;

  Order(this.title, this.startDate, this.endDate, this.budget, this.travelType,
      this.sendTo, this.items);

  //convert class to json for firebase
  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'budget': budget,
        "travelType": travelType,
        "sendTo": sendTo,
      };
}

class Item {
  String name;
  int quantity;

  Item(this.name, this.quantity);
}
