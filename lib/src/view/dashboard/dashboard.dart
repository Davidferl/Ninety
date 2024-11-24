import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/user/services/user_service.dart';
import 'package:bonne_reponse/src/view/dashboard/analytics_section.dart';
import 'package:bonne_reponse/src/view/dashboard/misc_stats_section.dart';
import 'package:bonne_reponse/src/view/dashboard/objectives_progress.dart';
import 'package:bonne_reponse/src/view/dashboard/statistics_section.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:bonne_reponse/src/view/widgets/subsection_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bonne_reponse/src/user/domain/user.dart';

class Dashboard extends HookWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userService = locator<UserService>();

    final user = useState<User?>(null);

    useEffect(() {
      Future<void> getUser() async {
        try {
          final fetchedUser = await userService.getCurrentUser();
          user.value = fetchedUser as User?;
        } catch (e) {}
      }

      getUser();
      return () {};
    }, []);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionName(
                name: AppLocalizations.of(context)!
                    .welcome(user.value?.name ?? '')),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const CategoriesStatsSection(),
                    const MiscStatsSection(),
                    verticalSpace(24),
                    const AnalyticsSection(),
                    verticalSpace(24),
                    SubsectionName(
                        name: AppLocalizations.of(context)!.your_progress),
                    const SizedBox(height: 4),
                    const ObjectivesProgress(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
