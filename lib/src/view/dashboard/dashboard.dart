import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/src/authentication/hooks/use_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends HookWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = useAuthentication();

    void onLogout() {
      context.goNamed(Routes.login.name);
    }

    return SafeArea(
        child: Column(
      children: [
        ElevatedButton(
          onPressed: () => auth.logout(onLogout),
          child: const Text('Logout'),
        ),
        const Text("Dashboard"),
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
          dotColor: const Color(0xFF333A47),
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            }),
          ),
        )
      ],
    ));
  }
}
