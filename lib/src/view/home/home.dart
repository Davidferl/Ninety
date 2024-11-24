import 'package:bonne_reponse/src/view/addLog/page_select_objective_for_log.dart';
import 'package:bonne_reponse/src/view/create_group/create_group.dart';
import 'package:bonne_reponse/src/view/dashboard/dashboard.dart';
import 'package:bonne_reponse/src/view/explore/explore.dart';
import 'package:bonne_reponse/src/view/explore/group_viewer.dart';
import 'package:bonne_reponse/src/view/feed/feed.dart';
import 'package:bonne_reponse/src/view/profile/profile.dart';
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
    const Dashboard(),
    const Explore(),
    const PageCreateGroup(),
    const PageSelectObjectiveForLog(),
    Feed(),
    const Profile(),
  ];

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
              Icons.bar_chart,
              color: kcOnPrimary,
            ),
            icon: Icon(
              Icons.bar_chart,
              color: kcLightSecondary,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.explore,
              color: kcOnPrimary,
            ),
            icon: Icon(
              Icons.explore,
              color: kcLightSecondary,
            ),
            label: 'Explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.create,
              color: kcPrimary,
            ),
            icon: Icon(
              Icons.create,
              color: kcLightSecondary,
            ),
            label: 'Create group',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.add,
              color: kcOnPrimary,
            ),
            icon: Icon(
              Icons.add,
              color: kcLightSecondary,
            ),
            label: 'Add',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.groups,
              color: kcOnPrimary,
            ),
            icon: Icon(
              Icons.groups,
              color: kcLightSecondary,
            ),
            label: 'Groups',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: kcOnPrimary,
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
