import 'package:booking_parcel/explore_view.dart';
import 'package:booking_parcel/models/Order.dart';
import 'package:booking_parcel/past_trips_view.dart';
import 'package:booking_parcel/services/auth_service.dart';
import 'package:booking_parcel/widgets/provider_widget.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';
import 'new_trips/transport_view.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    ExploreView(),
    PastTripsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newTrip =
        Order("", DateTime.now(), false, 200, "car", "Congo", <Item>[]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("FL"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewOrderTransportView(order: newTrip)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out!");
              } catch (e) {
                print(e);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed('/convertUser');
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabbedTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Past trips"),
        ],
      ),
    );
  }

  void onTabbedTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
