import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    //const Home(),
    //const Electricity(),
    //const Transport(),
    //const Leftover(),
    //const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        shadowColor: kcLightSecondary,
        selectedIndex: _selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: kcPrimary,
            ),
            icon: Icon(
              Icons.home,
              color: kcLightSecondary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.lightbulb,
              color: kcPrimary,
            ),
            icon: Icon(
              Icons.lightbulb,
              color: kcLightSecondary,
            ),
            label: 'Electricity',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.directions_car_filled,
              color: kcPrimary,
            ),
            icon: Icon(
              Icons.directions_car_filled,
              color: kcLightSecondary,
            ),
            label: 'Transport',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.shopping_basket,
              color: kcPrimary,
            ),
            icon: Icon(
              Icons.shopping_basket,
              color: kcLightSecondary,
            ),
            label: 'Alimentation',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: kcPrimary,
            ),
            icon: Icon(
              Icons.person,
              color: kcLightSecondary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
