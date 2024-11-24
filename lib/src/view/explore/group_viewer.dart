import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:go_router/go_router.dart';

class GroupViewer extends HookWidget {
  const GroupViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final dropdownActive = useState(false);
    final selectedIndex = useState(0);

    RadioGroupController myController = RadioGroupController();

    onTypeSelection(String value) {
      selectedIndex.value = value == "continuous" ? 0 : 1;
    }

    useEffect(() {
      onTypeSelection("continuous");
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => context.pop(''),
                      icon: const Icon(Icons.chevron_left, size: 30)),
                  const SectionName(name: 'Sleep earlier'),
                  IconButton(
                      onPressed: () => {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
              const Divider(
                color: kcDivider,
                thickness: 1,
              ),
              verticalSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What is this group about?",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: kcSecondaryVariant,
                        ),
                  ),
                  verticalSpace(4),
                  Text(
                    "This group is about sleeping earlier. We will share tips and tricks to help you sleep earlier. Join us!",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: kcDarkGray, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              verticalSpace(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create an objective!",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: kcSecondaryVariant,
                        ),
                  ),
                  verticalSpace(4),
                  Text(
                    "To join this group, you need to create an objective. What type of objective would you like to create?",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: kcDarkGray, fontWeight: FontWeight.w500),
                  ),
                  verticalSpace(16),
                  Column(
                    children: [
                      ExpansionPanelList(
                        expandIconColor: kcSecondaryVariant,
                        expansionCallback: (panelIndex, isExpanded) {
                          dropdownActive.value = !dropdownActive.value;
                        },
                        children: <ExpansionPanel>[
                          ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  iconColor: kcSecondaryVariant,
                                  title: Text(
                                    "What do the following values mean?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: kcSecondaryVariant,
                                            fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                              body: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Text(
                                  """Continuous values are for objectives that are ongoing, like "Run 3km a day".
                              
Discrete values are for objectives that happen one or many times during the week, like "Eat a salad for lunch".
                                                  """,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: kcDarkGray,
                                          fontWeight: FontWeight.w500),
                                ),
                              ),
                              isExpanded: dropdownActive.value,
                              canTapOnHeader: true)
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  RadioGroup(
                    onChanged: (value) {
                      onTypeSelection(value);
                    },
                    indexOfDefault: 0,
                    controller: myController,
                    values: const ["continuous", "discrete"],
                    labelBuilder: (value) => Text(
                        value == "continuous"
                            ? AppLocalizations.of(context)!.continuous
                            : AppLocalizations.of(context)!.discrete,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: kcSecondaryVariant,
                            fontWeight: FontWeight.w500)),
                    orientation: RadioGroupOrientation.vertical,
                    decoration: RadioGroupDecoration(
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                              color: kcSecondaryVariant,
                              fontWeight: FontWeight.w500),
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  (selectedIndex.value) == 0
                      ? Row(
                          children: [
                            horizontalSpace(10),
                          ],
                        )
                      : const Text(
                          "Discrete objective example: 'Eat a salad for lunch'"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
