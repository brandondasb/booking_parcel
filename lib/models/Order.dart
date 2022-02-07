class Order {
  String title;
  DateTime startDate;
  bool rtc;
  double budget;
  String travelType;
  String sendTo;
  List<Item> items;

  Order(this.title, this.startDate, this.rtc, this.budget, this.travelType,
      this.sendTo, this.items);

  //convert class to json for firebase
  Map<String, dynamic> toJson() => {
        'budget': budget,
        'rtc': rtc,
        'startDate': startDate,
        'title': title,
        "travelType": travelType,
        "sendTo": sendTo,
        //todo add Item to Json
      };
}

class Item {
  String name;
  int quantity;

  Item(this.name, this.quantity);
}
