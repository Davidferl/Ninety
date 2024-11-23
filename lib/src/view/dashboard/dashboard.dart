import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class Dashboard extends HookWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
        Column(
          children: [
            Text("Dashboard"),
            CalendarTimeline(
              initialDate: DateTime(2020, 4, 20),
              firstDate: DateTime(2019, 1, 15),
              lastDate: DateTime(2020, 11, 20),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotColor: Color(0xFF333A47),
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en_ISO',
            )
          ],
        )
    );
  }
}